#!/bin/bash

opt -O0 -pgo-instr-use -pgo-test-profile-file=pgo.profdata main-gened.bc -o main-gen-using.bc
