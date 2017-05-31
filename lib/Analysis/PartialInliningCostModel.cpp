//===--- BranchProbabilityInfo.h - Branch Probability Analysis --*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
// Pass to analyze profiling data and provide information on which functions
// should be partially inlined.
// Note that right now it is also used by the vectorization for determining
// which loops have better chances to be interleaved/unrolled.
// It can/should be extended to provide a general control flow analysis that
// is not only fine-tuned for partial-inlining.
//===----------------------------------------------------------------------===//
//
// Information obtained by the module:
// 1. Call frequency of the relevant function.
// 1. Probabilities of "inner" branches ("inner" defined below).
// 2. Code size of functions.
// 3. Number of call sites & large avg depth.
// Thus generating several maps from func names to the amounts of aforementioned
// values.
//
//===----------------------------------------------------------------------===//
//
// Information obtained in this module is mainly used by the partial inlining
// and 2 cases are taken into account:
//
// 1. "Merge" case --- the terminator of the first BB of a given function splits
// control flow into several not necessarily independent chains which are at
// some point merged back.
// Example:
// fun() {
//   <linear code>
//   if (cond) {
//     ....
//     <no ret instrs>
//   } else if (cond2) {
//     ....
//     <no ret instrs>
//   } else {
//     ....
//     <no ret instrs>
//   }
//   ...
//   ret
// }
//
// 2. "Separate" --- terminator of the first BB splits control flow into
// independent chains which occasionally reach their own rets.
// Example:
// fun() {
//   <linear code>
//   if (cond) {
//     ....
//     ret
//   } else if (cond2) {
//     ....
//     ret
//   }
// }
// 
// The following branches are called "inner":
// 1. Branches that for the 1st example split the flow into non-returning chains
// 2. All the branches for the 2nd example.
//===----------------------------------------------------------------------===//

#include "llvm/Analysis/PartialInliningCostModel.h"
#include "llvm/Analysis/InstCount.h"
#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/CFG.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include <functional>

using namespace llvm;

static const int ExpectedFunctionInModuleCount = 10; // FIXME AL Parameter?
static const int FuncDepthThreshold = 5; // FIXME AL Parameter?

// FIXME AL Move std::map to StringMap for example? Or some other LLVM-specific map?
// So far the compiler is angry.

// Frequency of every function that can potentially be inlined.
static std::map<std::string, uint64_t> FuncFreqMap;

// Probabilities of every relevant inner branch in a function.
static std::map<std::string, std::vector<uint64_t>> FuncCondProbMap;

// Number of instructions for each map instance.
static std::map<std::string, uint64_t> InstCountMap;

// Set of funcs that are potentially to be excluded from size-increasing loop
// optmizations.
static std::set<std::string> LoopOptBadFuncSet;

std::map<std::string, uint64_t>
PartialInliningCostModelPass::getFuncFreqMap() {
  return FuncFreqMap;
}

void PartialInliningCostModelPass::
addFFMEntry(std::string Func, uint64_t FreqVal) {
  FuncFreqMap[Func] = FreqVal;
}

std::map<std::string, std::vector<uint64_t>>
PartialInliningCostModelPass::getFuncCondProbMap() {
  return FuncCondProbMap;
}

void PartialInliningCostModelPass::
addFCPMEntry(std::string Func, uint64_t Val) {
  FuncCondProbMap[Func] = Val;
}

std::map<std::string, uint64_t>
PartialInliningCostModelPass::getInstCountMap() {
  return InstCountMap;
}

// Instruction count of all the instruction that can be possibly partially
// inlined.
static std::map<std::string, int> PartInlineInstCount;

// Amount of call sites for each function.
static std::map<std::string, int> CallSitesCount;

// For each function --- sum of depths of the function in the call stack
// together with total number of visits (using traversal started from each
// function in the module. 
// (Useful for further potential code growth, specially with lots of call sites,
// especially which many be deep themselves.)
static std::map<std::string, std::pair<int, int>> FuncTotalDepthMap;

// The map is obtained from the FuncTotalDepthMap simply by computing avg depth.
static std::map<std::string, int> FuncAvgDepthMap;

PartialInliningCostModelPassImpl::PartialInliningCostModelPassImpl(
    function_ref<BlockFrequencyInfo *(Function &)> LookupBFI,
    function_ref<BranchProbabilityInfo *(Function &)> LookupBPI,
    function_ref<unsigned(Function &)> LookupInstCount)
  : LookupBFI(LookupBFI), LookupBPI(LookupBPI), LookupInstCount(LookupInstCount)
{}

bool PartialInliningCostModelPassImpl
::searchForReachableBB(const BasicBlock *StartingBB,
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

bool PartialInliningCostModelPassImpl::checkSuccessorBranchesIndependence(
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

void PartialInliningCostModelPassImpl::checkSuccessorBranchesIndependenceImpl(
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

// DFS over functions in the module, collecting all the needed values
// (freqs, counts, # call sites, depths).
bool PartialInliningCostModelPassImpl::collectModuleProfileHeuristics(
    Module &M) {
  std::vector<FuncInfo> Worklist;
  Worklist.reserve(M.size());
  for (Function &F : M)
    if (!F.use_empty() && !F.isDeclaration()) {
      FuncInfo CurFuncInfo;
      CurFuncInfo.Func = &F;
      CurFuncInfo.Depth = 1; // Initially set all the depths to 1.
      Worklist.push_back(CurFuncInfo);
    }
  
  for (auto &F : Worklist) {
     collectFunctionProfileHeuristics(&F);
  }

  // To finalize, applying heuristics to squeeze profile data maps.
  cropProfileData();

  // Create a set of bad loop opt functions
  generateLoopOptBadFuncSet();

  return false;
}

void PartialInliningCostModelPassImpl::cropFuncFreq() {
  // To start with taking 30% best. FIXME AL Rely on parameter.
  int TopCount = FuncFreqMap.size() * 0.3;

  std::vector<std::pair<std::string, uint64_t>> TopFreqVec(TopCount);
  std::partial_sort_copy(FuncFreqMap.begin(),
                         FuncFreqMap.end(),
                         TopFreqVec.begin(),
                         TopFreqVec.end(),
                         [](const std::pair<const std::string, uint64_t> &l,
                            const std::pair<const std::string, uint64_t> &r)
                         {
                             return l.second < r.second;
                         });

  // TODO AL Really inefficient.
  // Reset the initial func freq map.
  FuncFreqMap.clear();
  for (auto &Pair : TopFreqVec) {
      FuncFreqMap[Pair.first] = Pair.second;
  }
}

// Helper function to allow somewhat "removing_if" for maps.
template<typename ContainerT, typename PredicateT>
static void eraseIf(ContainerT &items, const PredicateT &predicate) {
  for (auto it = items.begin(); it != items.end(); ) {
    if (predicate(*it))
      it = items.erase(it);
    else
      ++it;
  }
}

// Filter out elements of the cond prob map that are too unevenly distributed.
void PartialInliningCostModelPassImpl::cropFuncCondProb() {
  constexpr unsigned FuncCondProbThreshold = 0.5;
  eraseIf(FuncCondProbMap,
          [](const std::pair<std::string,
                             std::vector<uint64_t>> &entry) {
            return *std::max_element(entry.second.begin(),
                                     entry.second.end()) < FuncCondProbThreshold;
          });
}

void PartialInliningCostModelPassImpl::cropInstCount() {
  constexpr unsigned InstCountThreshold = 50;
  eraseIf(InstCountMap,
          [](const std::pair<std::string, uint64_t> &entry) {
            return entry.second < InstCountThreshold;
          });
}

// Leave only the bad funcs in the corresponding maps
void PartialInliningCostModelPassImpl::cropProfileData() {
  cropFuncFreq();
  cropFuncCondProb();
  cropInstCount();
}

template <typename T>
std::set<T> intersect_n(std::initializer_list<std::set<T>> Args) {
  if (Args.size() == 0) return std::set<T>();
  std::set<T> Result = Args[0];
  for (auto &Arg : Args) {
    // TODO: remove copy if possible
    auto Intersection = Result;
    std::set_intersection(Result.begin(), Result.end(),
                          Arg.begin(), Arg.end(),
                          std::back_inserter(Intersection));
    Result = Intersection;
  }
  return Result;
}

void PartialInliningCostModelPassImpl::generateLoopOptBadFuncSet() {
  // Initialize all the keys
  std::set<std::string> FFMKeys, FCPMKeys, InstCountKeys;
  for (auto &pair : FuncFreqMap)
    FFMKeys.insert(pair.first);
  for (auto &pair : FuncCondProbMap)
    FFMKeys.insert(pair.first);
  for (auto &pair : InstCountMap)
    FFMKeys.insert(pair.first);

  LoopOptBadFuncSet = intersect_n({FFMKeys, FCPMKeys, InstCountKeys});
}

bool PartialInliningCostModelPassImpl::isFuncBad(Function &F) {
  return LoopOptBadFuncSet.find(F) != LoopOptBadFuncSet.end();
}

void PartialInliningCostModelPassImpl::extractBlockBreq(Function *F) {
  auto FuncEntryProfCount = LookupBFI(*F)->getEntryFreq();
  if (!FuncEntryProfCount)
    return;

  FuncFreqMap[F->getName().str()] = FuncEntryProfCount;
}

void PartialInliningCostModelPassImpl::extractBranchProb(
  Function *F, BasicBlock *EntryBlock, unsigned SingleReturnBlockIdx) {
  // Extract BP. Only performed for "merge" case of partial inlining.
  // Computing average over all the blocks except the one that all the chains
  // will be eventually merged into.
  BranchProbability AvgSuccessorProb; 
  for (succ_iterator SI = succ_begin(EntryBlock), SE = succ_end(EntryBlock);
       SI != SE;
       ++SI) {
    if (SI.getSuccessorIndex() != SingleReturnBlockIdx)
      AvgSuccessorProb += LookupBPI(*F)->getEdgeProbability(EntryBlock, *SI);
  }
  AvgSuccessorProb /= std::distance(succ_begin(EntryBlock),
                                    succ_end(EntryBlock)) - 1;
}

void PartialInliningCostModelPassImpl::extractInstCount(Function *F) {
  auto TotalInstCount = LookupInstCount(*F);
  if (!TotalInstCount)
    return;

  InstCountMap[F->getName().str()] = TotalInstCount;
}

void PartialInliningCostModelPassImpl::
collectFunctionProfileHeuristics(FuncInfo *Info) {
  Function *F = Info->Func;

  // First, verify that this function is an partial inlining candidate...
  BasicBlock *EntryBlock = &F->front();
  TerminatorInst *Term = EntryBlock->getTerminator();
  BranchInst *BR = dyn_cast<BranchInst>(Term);
  SwitchInst *SW = dyn_cast<SwitchInst>(Term);
  if ((!BR || BR->isUnconditional()) && !SW)
    return;

  if (!checkSuccessorBranchesIndependence(successors(EntryBlock)))
    return;

  // This is only relevant in the "merge" case:
  // the index of the signle returning block.
  // Used to distinguish the block while computing avg branch probability.
  unsigned SingleReturnBlockIdx = 0;

  std::vector<BasicBlock *> ReturnBlocks;
  std::vector<BasicBlock *> NonReturnBlocks;
  for (succ_iterator SI = succ_begin(EntryBlock), SE = succ_end(EntryBlock);
       SI != SE;
       ++SI) {
    BasicBlock *BB = *SI;
    if (searchForReachableBB(BB, EntryBlock)) {
      return;
    }
    // Check for independency for a branch / switch case.
    if (isa<ReturnInst>(BB->getTerminator())) {
      ReturnBlocks.push_back(BB);
      SingleReturnBlockIdx = SI.getSuccessorIndex();
    } else {
      NonReturnBlocks.push_back(BB);
    }
  }

  if (ReturnBlocks.size() != 1 &&
      ReturnBlocks.size() != (size_t)std::distance(succ_begin(EntryBlock),
                                                   succ_begin(EntryBlock)))
    return;

  // By the time we get here we're sure it's a partial inlining candidate.

  extractBlockBreq(F);

  if (ReturnBlocks.size() == 1) // "merge" case
    extractBranchProb(F, EntryBlock, SingleReturnBlockIdx);

  extractInstCount(F);
}

void PartialInliningCostModelPass::
getAnalysisUsage(AnalysisUsage &AU) const {
  AU.addRequired<BlockFrequencyInfoWrapperPass>();
  AU.addRequired<InstCount>();
  AU.setPreservesAll();
}

char PartialInliningCostModelPass::ID = 0;
INITIALIZE_PASS_BEGIN(PartialInliningCostModelPass,
            "partial-inliner-cost-model", "Partial Inliner",
            false, false)
INITIALIZE_PASS_DEPENDENCY(BlockFrequencyInfoWrapperPass)
INITIALIZE_PASS_END(PartialInliningCostModelPass, "partial-inliner-cost-model",
                    "Partial Inliner", false, false)

//static void registerPartialInliningCostModelPass(
//  const PassManagerBuilder &, legacy::PassManagerBase &PM) {
//  PM.add(new PartialInliningCostModelPass());
//}
//static RegisterStandardPasses
//  RegisterMyPass(PassManagerBuilder::EP_ModuleOptimizerEarly,
//                 registerPartialInliningCostModelPass);

bool PartialInliningCostModelPass::runOnModule(Module &M) {
  if (skipModule(M))
    return false;

  auto LookupBFI = [this](Function &F) {
    return &this->getAnalysis<BlockFrequencyInfoWrapperPass>(F).getBFI();
  };

  auto LookupBPI = [this](Function &F) {
    return &this->getAnalysis<BranchProbabilityInfoWrapperPass>(F).getBPI();
  };

  auto LookupInstCount = [this](Function &F) {
    return this->getAnalysis<InstCount>(F).getTotalInstCount();
  };

  if (!Impl)
    Impl = PartialInliningCostModelPassImpl(LookupBFI, LookupBPI, LookupInstCount);

  return Impl.collectModuleProfileHeuristics(M);
}

PreservedAnalyses PartialInliningCostModelPass::
run(Module &M, ModuleAnalysisManager &AM) {
  auto LookupBFI = [this](Function &F) {
    return &this->getAnalysis<BlockFrequencyInfoWrapperPass>(F).getBFI();
  };

  auto LookupBPI = [this](Function &F) {
    return &this->getAnalysis<BranchProbabilityInfoWrapperPass>(F).getBPI();
  };

  auto LookupInstCount = [this](Function &F) {
    return this->getAnalysis<InstCount>(F).getTotalInstCount();
  };

  if (PartialInliningCostModelPassImpl(LookupBFI, LookupBPI, LookupInstCount)
      .collectModuleProfileHeuristics(M))
    return PreservedAnalyses::none();
  return PreservedAnalyses::all();
}
