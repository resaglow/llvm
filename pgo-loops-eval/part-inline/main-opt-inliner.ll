; ModuleID = 'main-opt-inliner.bc'
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
