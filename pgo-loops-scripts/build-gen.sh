#!/bin/bash

cd /home/resaglow/Dev/llvm-global/test
clang++ -O0 main.cpp -fprofile-generate -emit-llvm -c -o main-gened.bc
opt -O0 -pgo-instr-gen -instrprof main-gened.bc -o main-gened-optgen.bc
llc -O0 main-gened-optgen.bc -o main-gened-optgen-comp.s
clang++ -O0 -fprofile-instr-generate main-gened-optgen-comp.s -o main-gened-optgen-comp-gened
