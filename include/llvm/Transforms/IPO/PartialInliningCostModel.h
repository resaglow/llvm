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

class PartialInliningCostModelPass : public ModulePass {
public:
  static char ID;

  PartialInliningCostModelPass() : ModulePass(ID) {}

  virtual bool runOnModule(Module &F);

  PreservedAnalyses run(Module &M, ModuleAnalysisManager &);

private:
  BlockFrequencyInfo *BFI;
  BranchProbabilityInfo *BPI;

  void getAnalysisUsage(AnalysisUsage &AU) const override;
};

class PartialInliningCostModelPassImpl {
public:
  PartialInliningCostModelPassImpl(
    BlockFrequencyInfo *BFI, BranchProbabilityInfo *BPI);

  // FIXME Pointers vs. refs
  bool collectModuleProfileHeuristics(Module &M);

private:
  BlockFrequencyInfo *BFI;
  BranchProbabilityInfo *BPI;

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

  // Helpers to extract useful information from profiling analysis.
  void extractBlockBreq(Function *F);
  void extractBranchProb(
    Function *F, BasicBlock *EntryBlock, unsigned SingleReturnBlockIdx);
};

} // llvm
