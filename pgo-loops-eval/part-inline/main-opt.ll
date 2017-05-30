; ModuleID = 'main-opt.bc'
source_filename = "main.ll"

define internal i32 @inlinedFunc(i1 %cond, i32* align 4 %align.val) {
entry:
  br i1 %cond, label %if.then, label %return

if.then:                                          ; preds = %entry
  store i32 10, i32* %align.val, align 4
  br label %dummy

dummy:                                            ; preds = %if.then
  store i32 12, i32* %align.val, align 4
  br i1 %cond, label %dummy2, label %dummy3

dummy2:                                           ; preds = %dummy
  store i32 44, i32* %align.val, align 4
  ret i32 999

dummy3:                                           ; preds = %dummy
  store i32 55, i32* %align.val, align 4
  ret i32 888

return:                                           ; preds = %entry
  ret i32 0
}

define internal i32 @dummyCaller(i1 %cond, i32* align 2 %align.val) {
entry:
  %ptrint = ptrtoint i32* %align.val to i64
  %maskedptr = and i64 %ptrint, 3
  %maskcond = icmp eq i64 %maskedptr, 0
  call void @llvm.assume(i1 %maskcond)
  br i1 %cond, label %codeRepl.i, label %0

codeRepl.i:                                       ; preds = %entry
  %targetBlock.i = call i16 @inlinedFunc.1_if.then(i32* %align.val, i1 %cond)
  switch i16 %targetBlock.i, label %0 [
    i16 0, label %dummy2.ret.i
    i16 1, label %dummy3.ret.i
  ], !prof !0

dummy2.ret.i:                                     ; preds = %codeRepl.i
  br label %inlinedFunc.1.exit

dummy3.ret.i:                                     ; preds = %codeRepl.i
  br label %inlinedFunc.1.exit

; <label>:0:                                      ; preds = %codeRepl.i, %entry
  br label %inlinedFunc.1.exit

inlinedFunc.1.exit:                               ; preds = %0, %dummy3.ret.i, %dummy2.ret.i
  %val1 = phi i32 [ 999, %dummy2.ret.i ], [ 888, %dummy3.ret.i ], [ 0, %0 ]
  ret i32 %val1
}

define internal i16 @inlinedFunc.1_if.then(i32* %align.val, i1 %cond) {
newFuncRoot:
  br label %if.then

dummy2.ret.exitStub:                              ; preds = %dummy2
  ret i16 0

dummy3.ret.exitStub:                              ; preds = %dummy3
  ret i16 1

.exitStub:                                        ; preds = %return
  ret i16 2

if.then:                                          ; preds = %newFuncRoot
  store i32 10, i32* %align.val, align 4
  br label %dummy

dummy:                                            ; preds = %if.then
  store i32 12, i32* %align.val, align 4
  br i1 %cond, label %dummy2, label %dummy3

dummy2:                                           ; preds = %dummy
  store i32 44, i32* %align.val, align 4
  br label %dummy2.ret.exitStub

dummy3:                                           ; preds = %dummy
  store i32 55, i32* %align.val, align 4
  br label %dummy3.ret.exitStub

return:                                           ; No predecessors!
  br label %.exitStub
}

; Function Attrs: nounwind
declare void @llvm.assume(i1) #0

attributes #0 = { nounwind }

!0 = !{!"branch_weights", i32 0, i32 8, i32 8}
