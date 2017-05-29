//===- PartialInlining.cpp - Inline parts of functions --------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This pass performs partial inlining, typically by inlining an if statement
// that surrounds the body of the function.
//
//===----------------------------------------------------------------------===//

#include "llvm/Transforms/IPO/PartialInlining.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/BlockFrequencyInfo.h"
#include "llvm/Analysis/BranchProbabilityInfo.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Transforms/IPO.h"
#include "llvm/Transforms/IPO/PartialInliningCostModel.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Transforms/Utils/CodeExtractor.h"
using namespace llvm;

#define DEBUG_TYPE "partialinlining"

STATISTIC(NumPartialInlined, "Number of functions partially inlined");

static cl::opt<unsigned> PartInlineOptForSize(
    "part-inliner-opt-for-size", cl::init(0), cl::Hidden,
    cl::desc("Set the degree to which patial inliner should optimize for "
             "code size"));

namespace {
struct PartialInlinerImpl {
  PartialInlinerImpl(InlineFunctionInfo IFI,
                     PartialInliningCostModelPass *PICM) : IFI(IFI), PICM(PICM) {}
  bool run(Module &M);
  std::vector<Function *> unswitchFunction(Function *F);

private:
  InlineFunctionInfo IFI;
  PartialInliningCostModelPass *PICM;

  // Check if a given given target basic block is reachable from
  // a given source basic block.
  bool searchForReachableBB(const BasicBlock *StartingBB,
                            const BasicBlock *TargetBB);

  // Check if all the successors of a given basic block go through independent
  // code paths except they may be merged together at some point.
  bool checkSuccessorBranchesIndependence(succ_range &&SuccessorRange);

  void checkSuccessorBranchesIndependenceImpl(
      const BasicBlock *BB,
      std::map<const BasicBlock *, int> &BBOccurenceCounts,
      std::set<const BasicBlock *> &CurBBOccurences);

  // Unswitch function in case when paths of the successors of the entry BB need
  // to be merged.
  std::vector<Function *> unswitchFunctionMerge(
      Function *F, BasicBlock *EntryBlock,
      BasicBlock *ReturnBlock,
      const std::vector<BasicBlock *> &NonReturnBlocks);

  // Unswitch function in case when successors of the entry BB have completely
  // separate paths.
  std::vector<Function *> unswitchFunctionSeparate(
      Function *F,
      BasicBlock *EntryBlock, const std::vector<BasicBlock *> &ReturnBlocks);

  // Collect all the blocks reachable from the given one.
  void collectReachableBlocks(
      BasicBlock *StartingBB,
      std::vector<BasicBlock *> &ReachableBlocks,
      std::set<BasicBlock *> &ReachableBlocksSet);
};
struct PartialInlinerLegacyPass : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  PartialInlinerLegacyPass() : ModulePass(ID) {
    initializePartialInlinerLegacyPassPass(*PassRegistry::getPassRegistry());
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<AssumptionCacheTracker>();
    AU.addRequired<PartialInliningCostModelPass>();
    AU.addPreserved<PartialInliningCostModelPass>();
  }

  bool runOnModule(Module &M) override {
    if (skipModule(M))
      return false;

    AssumptionCacheTracker *ACT = &getAnalysis<AssumptionCacheTracker>();
    std::function<AssumptionCache &(Function &)> GetAssumptionCache =
        [&ACT](Function &F) -> AssumptionCache & {
      return ACT->getAssumptionCache(F);
    };
    PartialInliningCostModelPass *PICM =
        &getAnalysis<PartialInliningCostModelPass>();

    InlineFunctionInfo IFI(nullptr, &GetAssumptionCache);
    return PartialInlinerImpl(IFI, PICM).run(M);
  }
};
}

bool PartialInlinerImpl::searchForReachableBB(const BasicBlock *StartingBB,
                                              const BasicBlock *TargetBB) {
  for (const BasicBlock *BB : successors(StartingBB)) {
    if (BB == TargetBB) return true;
  }
  for (const BasicBlock *BB : successors(StartingBB)) {
    if (searchForReachableBB(BB, TargetBB))
      return true;
  }
  return false;
}

bool PartialInlinerImpl::checkSuccessorBranchesIndependence(
    succ_range &&SuccessorRange) {
  std::map<const BasicBlock *, int> BBOccurenceCounts;
  for (const auto &BB : SuccessorRange) {
    std::set<const BasicBlock *> CurBBOccurences;
    checkSuccessorBranchesIndependenceImpl(BB,
                                           BBOccurenceCounts,
                                           CurBBOccurences);
  }

  int AllSuccessorsPresentBBCount = 0;
  for (auto &Pair : BBOccurenceCounts) {
    if (Pair.second == 1)
      continue;

    if (Pair.second ==
        std::distance(SuccessorRange.begin(), SuccessorRange.end())) {
      AllSuccessorsPresentBBCount++;
    } else {
      return false;
    }
  }

  return AllSuccessorsPresentBBCount == 1 || // merged paths
         AllSuccessorsPresentBBCount == 0;   // completely separate paths
}

void PartialInlinerImpl::checkSuccessorBranchesIndependenceImpl(
    const BasicBlock *BB,
    std::map<const BasicBlock *, int> &BBOccurenceCounts,
    std::set<const BasicBlock *> &CurBBOccurences) {
  if (CurBBOccurences.find(BB) == CurBBOccurences.end()) {
    BBOccurenceCounts[BB]++;
  }
  CurBBOccurences.insert(BB);

  for (const BasicBlock *SuccBB : successors(BB)) {
    checkSuccessorBranchesIndependenceImpl(SuccBB,
                                           BBOccurenceCounts,
                                           CurBBOccurences);
  }
}

void PartialInlinerImpl::collectReachableBlocks(
    BasicBlock *StartingBB,
    std::vector<BasicBlock *> &ReachableBlocks,
    std::set<BasicBlock *> &ReachableBlocksSet) {
  if (ReachableBlocksSet.find(StartingBB) == ReachableBlocksSet.end()) {
    ReachableBlocks.push_back(StartingBB);
  }
  ReachableBlocksSet.insert(StartingBB);
  for (const auto &BB : successors(StartingBB)) {
    collectReachableBlocks(BB, ReachableBlocks, ReachableBlocksSet);
  }
}

std::vector<Function *> PartialInlinerImpl::unswitchFunctionMerge(
    Function *F,
    BasicBlock *EntryBlock, BasicBlock *ReturnBlock,
    const std::vector<BasicBlock *> &NonReturnBlocks) {

  // Clone the function, so that we can hack away on it.
  ValueToValueMapTy VMap;
  Function *DuplicateFunction = CloneFunction(F, VMap);
  DuplicateFunction->setLinkage(GlobalValue::InternalLinkage);
  BasicBlock *NewEntryBlock = cast<BasicBlock>(VMap[EntryBlock]);
  BasicBlock *NewReturnBlock = cast<BasicBlock>(VMap[ReturnBlock]);
  std::vector<BasicBlock *> NewNonReturnBlocks;
  for (auto &NonReturnBlock: NonReturnBlocks) {
    NewNonReturnBlocks.push_back(cast<BasicBlock>(VMap[NonReturnBlock]));
  }

  // Go ahead and update all uses to the duplicate, so that we can just
  // use the inliner functionality when we're done hacking.
  F->replaceAllUsesWith(DuplicateFunction);

  // Special hackery is needed with PHI nodes that have inputs from more than
  // one extracted block.  For simplicity, just split the PHIs into a two-level
  // sequence of PHIs, some of which will go in the extracted region, and some
  // of which will go outside.
  BasicBlock *PreReturn = NewReturnBlock;
  NewReturnBlock = NewReturnBlock->splitBasicBlock(
      NewReturnBlock->getFirstNonPHI()->getIterator());
  BasicBlock::iterator I = PreReturn->begin();
  Instruction *Ins = &NewReturnBlock->front();
  while (I != PreReturn->end()) {
    PHINode *OldPhi = dyn_cast<PHINode>(I);
    if (!OldPhi)
      break;

    PHINode *RetPhi = PHINode::Create(OldPhi->getType(), 2, "", Ins);
    OldPhi->replaceAllUsesWith(RetPhi);
    Ins = NewReturnBlock->getFirstNonPHI();

    RetPhi->addIncoming(&*I, PreReturn);
    RetPhi->addIncoming(OldPhi->getIncomingValueForBlock(NewEntryBlock),
                        NewEntryBlock);
    OldPhi->removeIncomingValue(NewEntryBlock);

    ++I;
  }

  NewEntryBlock->getTerminator()->replaceUsesOfWith(PreReturn, NewReturnBlock);

  // All the functions that were extracted during partial inlining.
  std::vector<Function *> ExtractedFunctions;

  // Extract all the relevant blocks of code under conditions.
  for (auto &BB : NewNonReturnBlocks) {
    std::vector<BasicBlock *> ToExtract;
    std::set<BasicBlock *> ExtractedBlockSet;
    // Collect all blocks reachable from the current non returning successor.
    collectReachableBlocks(BB, ToExtract, ExtractedBlockSet);
    // Except the final return block.
    ToExtract.erase(std::remove_if(ToExtract.begin(), ToExtract.end(),
                                   [&](BasicBlock *X) {
                      return X == NewReturnBlock || X == PreReturn;
                    }),
                    ToExtract.end());

    // The CodeExtractor needs a dominator tree.
    DominatorTree DT;
    DT.recalculate(*DuplicateFunction);

    // Manually calculate a BlockFrequencyInfo and BranchProbabilityInfo.
    LoopInfo LI(DT);
    BranchProbabilityInfo BPI(*DuplicateFunction, LI);
    BlockFrequencyInfo BFI(*DuplicateFunction, BPI, LI);

    // Extract the body of the if.
    ExtractedFunctions.push_back(
        CodeExtractor(ToExtract, &DT, /*AggregateArgs*/ false, &BFI, &BPI)
            .extractCodeRegion());
  }

  // Inline the top-level if test into all callers.
  std::vector<User *> Users(DuplicateFunction->user_begin(),
                            DuplicateFunction->user_end());
  for (User *User : Users)
    if (CallInst *CI = dyn_cast<CallInst>(User))
      InlineFunction(CI, IFI);
    else if (InvokeInst *II = dyn_cast<InvokeInst>(User))
      InlineFunction(II, IFI);

  // Ditch the duplicate, since we're done with it, and rewrite all remaining
  // users (function pointers, etc.) back to the original function.
  DuplicateFunction->replaceAllUsesWith(F);
  DuplicateFunction->eraseFromParent();

  return ExtractedFunctions;
}

std::vector<Function *> PartialInlinerImpl::unswitchFunctionSeparate(
    Function *F,
    BasicBlock *EntryBlock, const std::vector<BasicBlock *> &ReturnBlocks) {
  // FIXME AL Is entry block parameter needed?
  // FIXME AL Fix copying FIXME AL Which copying :(
  // Clone the function, so that we can hack away on it.
  ValueToValueMapTy VMap;
  Function *DuplicateFunction = CloneFunction(F, VMap);
  DuplicateFunction->setLinkage(GlobalValue::InternalLinkage);
  std::vector<BasicBlock *> NewReturnBlocks;
  for (auto &ReturnBlock: ReturnBlocks) {
    NewReturnBlocks.push_back(cast<BasicBlock>(VMap[ReturnBlock]));
  }

  // FIXME AL Comment + Remove CP.
  std::vector<Function *> ExtractedFunctions;

  // Extract all the relevant blocks of code under conditions.
  for (auto &BB : NewReturnBlocks) {
    std::vector<BasicBlock *> ToExtract;
    std::set<BasicBlock *> ExtractedBlockSet;
    // Collect all blocks reachable from the current non returning successor.
    collectReachableBlocks(BB, ToExtract, ExtractedBlockSet);

    // The CodeExtractor needs a dominator tree.
    DominatorTree DT;
    DT.recalculate(*DuplicateFunction);

    // Manually calculate a BlockFrequencyInfo and BranchProbabilityInfo.
    LoopInfo LI(DT);
    BranchProbabilityInfo BPI(*DuplicateFunction, LI);
    BlockFrequencyInfo BFI(*DuplicateFunction, BPI, LI);

    // Extract the body of the if.
    ExtractedFunctions.push_back(
        CodeExtractor(ToExtract, &DT, /*AggregateArgs*/ false, &BFI, &BPI)
            .extractCodeRegion());
  }

  // Inline the top-level if test into all callers.
  std::vector<User *> Users(DuplicateFunction->user_begin(),
                            DuplicateFunction->user_end());
  for (User *User : Users)
    if (CallInst *CI = dyn_cast<CallInst>(User))
      InlineFunction(CI, IFI);
    else if (InvokeInst *II = dyn_cast<InvokeInst>(User))
      InlineFunction(II, IFI);

  // Ditch the duplicate, since we're done with it, and rewrite all remaining
  // users (function pointers, etc.) back to the original function.
  DuplicateFunction->replaceAllUsesWith(F);
  DuplicateFunction->eraseFromParent();

  return ExtractedFunctions;
}

// FIXME AL Integrate optionals
std::vector<Function *> PartialInlinerImpl::unswitchFunction(Function *F) {
  // First, verify that this function is an unswitching candidate...
  BasicBlock *EntryBlock = &F->front();
  TerminatorInst *Term = EntryBlock->getTerminator();
  BranchInst *BR = dyn_cast<BranchInst>(Term);
  SwitchInst *SW = dyn_cast<SwitchInst>(Term);
  if ((!BR || BR->isUnconditional()) && !SW)
    return std::vector<Function *>(); // FIXME AL Refactor.

  if (!checkSuccessorBranchesIndependence(successors(EntryBlock)))
    return std::vector<Function *>();

  std::vector<BasicBlock *> ReturnBlocks;
  std::vector<BasicBlock *> NonReturnBlocks;
  succ_range &&succs = successors(EntryBlock);
  for (BasicBlock *BB : succs) {
    if (searchForReachableBB(BB, EntryBlock)) {
      return std::vector<Function *>();
    }
    // Check for independency for a branch / switch case.
    if (isa<ReturnInst>(BB->getTerminator())) {
      ReturnBlocks.push_back(BB);
    } else {
      NonReturnBlocks.push_back(BB);
    }
  }

  if (ReturnBlocks.size() != 1 &&
      ReturnBlocks.size() != (size_t)std::distance(succs.begin(), succs.end()))
    return std::vector<Function *>();

  // By the time we get here we're sure it's an unswitching candidate.

  ++NumPartialInlined;
  if (ReturnBlocks.size() == 1) {
    return unswitchFunctionMerge(F, EntryBlock,
                                 ReturnBlocks[0], NonReturnBlocks);
  } else if (ReturnBlocks.size() ==
             (size_t)std::distance(succs.begin(), succs.end())) {
    return unswitchFunctionSeparate(F, EntryBlock, ReturnBlocks);
  } else {
    return std::vector<Function *>();
  }
}

bool PartialInlinerImpl::run(Module &M) {
  std::vector<Function *> Worklist;
  Worklist.reserve(M.size());
  for (Function &F : M)
    if (!F.use_empty() && !F.isDeclaration())
      Worklist.push_back(&F);

  bool Changed = false;
  while (!Worklist.empty()) {
    Function *CurrFunc = Worklist.back();
    Worklist.pop_back();

    if (CurrFunc->use_empty())
      continue;

    bool Recursive = false;
    for (User *U : CurrFunc->users())
      if (Instruction *I = dyn_cast<Instruction>(U))
        if (I->getParent()->getParent() == CurrFunc) {
          Recursive = true;
          break;
        }
    if (Recursive)
      continue;

    auto ExtractedFunctions = unswitchFunction(CurrFunc);
    if (!ExtractedFunctions.empty()) {
      for (auto &F : ExtractedFunctions)
        Worklist.push_back(F);
      Changed = true;
    }
  }

  return Changed;
}

char PartialInlinerLegacyPass::ID = 0;
INITIALIZE_PASS_BEGIN(PartialInlinerLegacyPass, "partial-inliner",
                      "Partial Inliner", false, false)
INITIALIZE_PASS_DEPENDENCY(AssumptionCacheTracker)
INITIALIZE_PASS_END(PartialInlinerLegacyPass, "partial-inliner",
                    "Partial Inliner", false, false)

ModulePass *llvm::createPartialInliningPass() {
  return new PartialInlinerLegacyPass();
}

PreservedAnalyses PartialInlinerPass::run(Module &M,
                                          ModuleAnalysisManager &AM) {
  // FIXME AL Add cost model dependecy
  auto &FAM = AM.getResult<FunctionAnalysisManagerModuleProxy>(M).getManager();
  std::function<AssumptionCache &(Function &)> GetAssumptionCache =
      [&FAM](Function &F) -> AssumptionCache & {
    return FAM.getResult<AssumptionAnalysis>(F);
  };
  InlineFunctionInfo IFI(nullptr, &GetAssumptionCache);
  PartialInliningCostModelPass *PICM = nullptr; // FIXME AL FIX
  if (PartialInlinerImpl(IFI, PICM).run(M))
    return PreservedAnalyses::none();
  return PreservedAnalyses::all();
}
