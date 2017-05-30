; ModuleID = 'main-using.bc'
source_filename = "main.ll"

define internal i32 @inlinedFunc(i1 %cond, i32* align 4 %align.val) {
entry:
  br i1 %cond, label %if.then, label %return

if.then:                                          ; preds = %entry
  store i32 10, i32* %align.val, align 4
  br label %return

return:                                           ; preds = %if.then, %entry
  ret i32 0
}

define internal i32 @dummyCaller(i1 %cond, i32* align 2 %align.val) {
entry:
  %val = call i32 @inlinedFunc.1(i1 %cond, i32* %align.val)
  ret i32 %val
}

define internal i32 @inlinedFunc.1(i1 %cond, i32* align 4 %align.val) {
entry:
  br i1 %cond, label %codeRepl, label %0

codeRepl:                                         ; preds = %entry
  call void @inlinedFunc.1_if.then(i32* %align.val)
  br label %0

; <label>:0:                                      ; preds = %codeRepl, %entry
  ret i32 0
}

define internal void @inlinedFunc.1_if.then(i32* %align.val) {
newFuncRoot:
  br label %if.then

.exitStub:                                        ; preds = %return
  ret void

if.then:                                          ; preds = %newFuncRoot
  store i32 10, i32* %align.val, align 4
  br label %return

return:                                           ; preds = %if.then
  br label %.exitStub
}
