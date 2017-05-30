define internal i32 @inlinedFunc1(i1 %cond, i32* align 4 %align.val) {
entry:
  br i1 %cond, label %if.then, label %return
if.then:
  ; Dummy store to have more than 0 uses
  store i32 11, i32* %align.val, align 4
  br label %return
return:
  ret i32 1
}

define internal i32 @inlinedFunc2(i1 %cond, i32* align 4 %align.val) {
entry:
  br i1 %cond, label %if.then, label %return
if.then:
  ; Dummy store to have more than 0 uses
  store i32 12, i32* %align.val, align 4
  br label %return
return:
  ret i32 2
}

define internal i32 @inlinedFunc(i1 %cond, i32* align 4 %align.val) {
entry:
  br i1 %cond, label %if.then, label %return
if.then:
  br i1 %cond, label %if.then.call1, label %if.then.call2
if.then.call1:
  %val1 = call i32 @inlinedFunc1(i1 %cond, i32* %align.val)
  br label %if.then.return
if.then.call2:
  %val2 = call i32 @inlinedFunc2(i1 %cond, i32* %align.val)
  br label %if.then.return
if.then.return:
  %val = phi i32 [ %val1, %if.then.call1 ], [ %val2, %if.then.call2 ]
  ret i32 %val
return:
  ret i32 0
}

define internal i32 @dummyCaller(i1 %cond, i32* align 2 %align.val) {
entry:
  %val = call i32 @inlinedFunc(i1 %cond, i32* %align.val)
  ret i32 %val
}

@.str = private unnamed_addr constant [7 x i8] c"hello\0A\00", align 1

define i32 @main() {
entry:
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0))
  
  %res = call i32 (i1, i32* ) @dummyCaller(i1 1, )
  ret i32 0
}

declare i32 @printf(i8*, ...)
