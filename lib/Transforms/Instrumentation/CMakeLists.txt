add_llvm_library(LLVMInstrumentation
  AddressSanitizer.cpp
  BoundsChecking.cpp
  DataFlowSanitizer.cpp
  GCOVProfiling.cpp
  MemorySanitizer.cpp
  IndirectCallPromotion.cpp
  Instrumentation.cpp
  InstrProfiling.cpp
  PGOInstrumentation.cpp
  SanitizerCoverage.cpp
  ThreadSanitizer.cpp
  EfficiencySanitizer.cpp

  ADDITIONAL_HEADER_DIRS
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms

  LINK_LIBS -L/usr/lib/x86_64-linux-gnu -lpython3.5m

  DEPENDS
  intrinsics_gen
  )

include_directories(/usr/local/lib/python3.5/dist-packages/numpy/core/include)
include_directories(/usr/include/python3.5m)
