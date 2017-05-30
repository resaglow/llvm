#ifndef LLVM_TRANSFORMS_IPO_PARTIALINLINING_CM_H
#define LLVM_TRANSFORMS_IPO_PARTIALINLINING_CM_H

#include "llvm/Analysis/BlockFrequencyInfo.h"
#include "llvm/Analysis/BranchProbabilityInfo.h"
#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/CFG.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"
#include <set>

namespace llvm {

// Helper structure keeping depth with the func while traversing.
struct FuncInfo {
  Function *Func;
  int Depth;
};

// Profile count info for every partial inlining candidate.
// - Profile count of an entry block (of the entire func).
// - For each branch destination except the "merged" block in inline-merge
//   case this is a profile count of the destination block.
struct PartInlineFuncProfCounts {
  uint64_t EntryBlockCount;
  std::vector<uint64_t> ConditionBlockCounts; 
};

static const std::string ThisPassName = "PartInlineCM";

struct PartialInliningCostModelPass : public ModulePass {
  static char ID;

  PartialInliningCostModelPass() : ModulePass(ID) {
    initializePartialInliningCostModelPassPass(
        *PassRegistry::getPassRegistry());
  }

  virtual bool runOnModule(Module &M);

  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);

  virtual StringRef getPassName() const override {
    return StringRef(ThisPassName);
  }

  std::map<std::string, uint64_t> getFuncFreqMap();

  std::map<std::string, std::vector<uint64_t>> getFuncCondProbMap();

  std::map<std::string, uint64_t> getInstCountMap();

  virtual void getAnalysisUsage(AnalysisUsage &AU) const override;
};

struct PartialInliningCostModelPassImpl {
  PartialInliningCostModelPassImpl(
    function_ref<BlockFrequencyInfo *(Function &)> LookupBFI,
    function_ref<BranchProbabilityInfo *(Function &)> LookupBPI,
    function_ref<unsigned(Function &)> LookupInstCount);

  bool collectModuleProfileHeuristics(Module &M);

  function_ref<BlockFrequencyInfo *(Function &)> LookupBFI;
  function_ref<BranchProbabilityInfo *(Function &)> LookupBPI;
  function_ref<unsigned(Function &)> LookupInstCount;

  // Calculate block frequencies of funcs that are relevant to partially inline
  // and depths of such functions in a call stack.
  bool generateFreqsAndDepths(Module &M);

  // Obtain block frequency of the current function if it fits the criteria.
  bool getPotentialFuncBlockFreqs(Function *F);

  void collectFunctionProfileHeuristics(FuncInfo *Info);

  bool searchForReachableBB(const BasicBlock *StartingBB,
                            const BasicBlock *TargetBB);

  bool checkSuccessorBranchesIndependence(succ_range &&SuccessorRange);

  void checkSuccessorBranchesIndependenceImpl(
    const BasicBlock *BB,
    std::map<const BasicBlock *, int> &BBOccurenceCounts,
    std::set<const BasicBlock *> &CurBBOccurences);

  // Filter out rarely used functions.
  void cropFuncFreq();
  // Filter out elements of the cond prob map that are too unevenly distributed.
  void cropFuncCondProb();
  // Just filter funcs with too many instructions.
  void cropInstCount();
  // Go over all the useful data collected during profiling and apply internal
  // heuristics.
  void cropProfileData();

  // Helpers to extract useful information from profiling analysis.
  void extractBlockBreq(Function *F);
  void extractBranchProb(
    Function *F, BasicBlock *EntryBlock, unsigned SingleReturnBlockIdx);
  void extractInstCount(Function *F);
};

} // llvm


#endif
