//===- CallGraphSCCPass.h - Pass that operates BU on call graph -*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines the CallGraphSCCPass class, which is used for passes which
// are implemented as bottom-up traversals on the call graph.  Because there may
// be cycles in the call graph, passes of this type operate on the call-graph in
// SCC order: that is, they process function bottom-up, except for recursive
// functions, which they process all at once.
//
// These passes are inherently interprocedural, and are required to keep the
// call graph up-to-date if they do anything which could modify it.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_ANALYSIS_INSTCOUNT_H
#define LLVM_ANALYSIS_INSTCOUNT_H

#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/Passes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"

namespace llvm {

#define DEBUG_TYPE "instcount"

#define HANDLE_INST(N, OPCODE, CLASS) \
  STATISTIC(Num ## OPCODE ## Inst, "Number of " #OPCODE " insts");

#include "llvm/IR/Instruction.def"

STATISTIC(TotalInsts , "Number of instructions (of all types)");
STATISTIC(TotalBlocks, "Number of basic blocks");
STATISTIC(TotalFuncs , "Number of non-external functions");

class InstCount : public FunctionPass, public InstVisitor<InstCount> {
  friend class InstVisitor<InstCount>;

  void visitFunction  (Function &F) { ++TotalFuncs; }
  void visitBasicBlock(BasicBlock &BB) { ++TotalBlocks; }

#define HANDLE_INST(N, OPCODE, CLASS) \
  void visit##OPCODE(CLASS &) { ++Num##OPCODE##Inst; ++TotalInsts; }

#include "llvm/IR/Instruction.def"

  void visitInstruction(Instruction &I) {
    errs() << "Instruction Count does not know about " << I;
    llvm_unreachable(nullptr);
  }
public:
  static char ID; // Pass identification, replacement for typeid
  InstCount() : FunctionPass(ID) {
    initializeInstCountPass(*PassRegistry::getPassRegistry());
  }

  bool runOnFunction(Function &F) override;

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.setPreservesAll();
  }

  void print(raw_ostream &O, const Module *M) const override {}

  unsigned getTotalInstCount() {
    return TotalInsts.Value;
  }

};

} // llvm

#endif
