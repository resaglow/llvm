; ModuleID = 'main-deep-opt.bc'
source_filename = "main.ll"

define internal i32 @dummyCaller(i1 %cond, i32* align 2 %align.val) {
entry:
  %val.loc.i = alloca i32
  %ptrint = ptrtoint i32* %align.val to i64
  %maskedptr = and i64 %ptrint, 3
  %maskcond = icmp eq i64 %maskedptr, 0
  call void @llvm.assume(i1 %maskcond)
  %0 = bitcast i32* %val.loc.i to i8*
  call void @llvm.lifetime.start(i64 4, i8* %0)
  br i1 %cond, label %codeRepl.i, label %2

codeRepl.i:                                       ; preds = %entry
  %targetBlock.i = call i1 @inlinedFunc.1_if.then(i1 %cond, i32* %align.val, i32* %val.loc.i)
  %val.reload.i = load i32, i32* %val.loc.i
  br i1 %targetBlock.i, label %if.then.return.ret.i, label %2, !prof !0

if.then.return.ret.i:                             ; preds = %codeRepl.i
  %1 = bitcast i32* %val.loc.i to i8*
  call void @llvm.lifetime.end(i64 4, i8* %1)
  br label %inlinedFunc.1.exit

; <label>:2:                                      ; preds = %codeRepl.i, %entry
  %3 = bitcast i32* %val.loc.i to i8*
  call void @llvm.lifetime.end(i64 4, i8* %3)
  br label %inlinedFunc.1.exit

inlinedFunc.1.exit:                               ; preds = %2, %if.then.return.ret.i
  %val1 = phi i32 [ %val.reload.i, %if.then.return.ret.i ], [ 0, %2 ]
  ret i32 %val1
}

define internal i1 @inlinedFunc.1_if.then(i1 %cond, i32* %align.val, i32* %val.out) {
newFuncRoot:
  br label %if.then

if.then.return.ret.exitStub:                      ; preds = %if.then.return
  store i32 %val, i32* %val.out
  ret i1 true

.exitStub:                                        ; preds = %return
  ret i1 false

if.then:                                          ; preds = %newFuncRoot
  br i1 %cond, label %if.then.call1, label %if.then.call2

if.then.call1:                                    ; preds = %if.then
  %ptrint1 = ptrtoint i32* %align.val to i64
  %maskedptr2 = and i64 %ptrint1, 3
  %maskcond3 = icmp eq i64 %maskedptr2, 0
  call void @llvm.assume(i1 %maskcond3)
  br i1 %cond, label %codeRepl.i4, label %inlinedFunc1.3.exit

codeRepl.i4:                                      ; preds = %if.then.call1
  call void @inlinedFunc1.3_if.then(i32* %align.val)
  br label %inlinedFunc1.3.exit

inlinedFunc1.3.exit:                              ; preds = %if.then.call1, %codeRepl.i4
  br label %if.then.return

if.then.call2:                                    ; preds = %if.then
  %ptrint = ptrtoint i32* %align.val to i64
  %maskedptr = and i64 %ptrint, 3
  %maskcond = icmp eq i64 %maskedptr, 0
  call void @llvm.assume(i1 %maskcond)
  br i1 %cond, label %codeRepl.i, label %inlinedFunc2.2.exit

codeRepl.i:                                       ; preds = %if.then.call2
  call void @inlinedFunc2.2_if.then(i32* %align.val)
  br label %inlinedFunc2.2.exit

inlinedFunc2.2.exit:                              ; preds = %if.then.call2, %codeRepl.i
  br label %if.then.return

if.then.return:                                   ; preds = %inlinedFunc2.2.exit, %inlinedFunc1.3.exit
  %val = phi i32 [ 1, %inlinedFunc1.3.exit ], [ 2, %inlinedFunc2.2.exit ]
  br label %if.then.return.ret.exitStub

return:                                           ; No predecessors!
  br label %.exitStub
}

; Function Attrs: nounwind
declare void @llvm.assume(i1) #0

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

define internal void @inlinedFunc2.2_if.then(i32* %align.val) {
  store i32 12, i32* %align.val, align 4
  ret void
}

define internal void @inlinedFunc1.3_if.then(i32* %align.val) {
  store i32 11, i32* %align.val, align 4
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { argmemonly nounwind }

!0 = !{!"branch_weights", i32 1, i32 0}
