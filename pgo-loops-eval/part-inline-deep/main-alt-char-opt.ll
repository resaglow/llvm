; ModuleID = 'main-alt-2-opt.bc'
source_filename = "main-alt.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"hello\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define i32 @_Z3funcPi(i8 signext %cond, i32* %p) #0 {
entry:
  %cond.addr.i1 = alloca i8, align 1
  %p.addr.i2 = alloca i32*, align 8
  %cond.addr.i = alloca i8, align 1
  %p.addr.i = alloca i32*, align 8
  %retval = alloca i32, align 4
  %cond.addr = alloca i8, align 1
  %p.addr = alloca i32*, align 8
  %res = alloca i32, align 4
  store i8 %cond, i8* %cond.addr, align 1
  store i32* %p, i32** %p.addr, align 8
  %0 = load i8, i8* %cond.addr, align 1
  %tobool = icmp ne i8 %0, 0
  br i1 %tobool, label %if.then, label %if.end4

if.then:                                          ; preds = %entry
  %1 = load i8, i8* %cond.addr, align 1
  %tobool1 = icmp ne i8 %1, 0
  br i1 %tobool1, label %if.then2, label %if.else

if.then2:                                         ; preds = %if.then
  %2 = load i8, i8* %cond.addr, align 1
  %3 = load i32*, i32** %p.addr, align 8
  call void @llvm.lifetime.start(i64 1, i8* %cond.addr.i1)
  %4 = bitcast i32** %p.addr.i2 to i8*
  call void @llvm.lifetime.start(i64 8, i8* %4)
  store i8 %2, i8* %cond.addr.i1, align 1
  store i32* %3, i32** %p.addr.i2, align 8
  %5 = load i8, i8* %cond.addr.i1, align 1
  %tobool.i3 = icmp ne i8 %5, 0
  br i1 %tobool.i3, label %codeRepl.i4, label %_Z4fun1cPi.2.exit

codeRepl.i4:                                      ; preds = %if.then2
  call void @_Z4fun1cPi.2_if.then(i32** %p.addr.i2) #5
  br label %_Z4fun1cPi.2.exit

_Z4fun1cPi.2.exit:                                ; preds = %if.then2, %codeRepl.i4
  call void @llvm.lifetime.end(i64 1, i8* %cond.addr.i1)
  %6 = bitcast i32** %p.addr.i2 to i8*
  call void @llvm.lifetime.end(i64 8, i8* %6)
  store i32 1, i32* %res, align 4
  br label %if.end

if.else:                                          ; preds = %if.then
  %7 = load i8, i8* %cond.addr, align 1
  %8 = load i32*, i32** %p.addr, align 8
  call void @llvm.lifetime.start(i64 1, i8* %cond.addr.i)
  %9 = bitcast i32** %p.addr.i to i8*
  call void @llvm.lifetime.start(i64 8, i8* %9)
  store i8 %7, i8* %cond.addr.i, align 1
  store i32* %8, i32** %p.addr.i, align 8
  %10 = load i8, i8* %cond.addr.i, align 1
  %tobool.i = icmp ne i8 %10, 0
  br i1 %tobool.i, label %codeRepl.i, label %_Z4fun2cPi.1.exit

codeRepl.i:                                       ; preds = %if.else
  call void @_Z4fun2cPi.1_if.then(i32** %p.addr.i) #5
  br label %_Z4fun2cPi.1.exit

_Z4fun2cPi.1.exit:                                ; preds = %if.else, %codeRepl.i
  call void @llvm.lifetime.end(i64 1, i8* %cond.addr.i)
  %11 = bitcast i32** %p.addr.i to i8*
  call void @llvm.lifetime.end(i64 8, i8* %11)
  store i32 2, i32* %res, align 4
  br label %if.end

if.end:                                           ; preds = %_Z4fun2cPi.1.exit, %_Z4fun1cPi.2.exit
  %12 = load i32, i32* %res, align 4
  store i32 %12, i32* %retval, align 4
  br label %return

if.end4:                                          ; preds = %entry
  store i32 0, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end4, %if.end
  %13 = load i32, i32* %retval, align 4
  ret i32 %13
}

; Function Attrs: noinline nounwind uwtable
define i32 @_Z11dummyCallercPi(i8 signext %cond, i32* %p) #0 {
entry:
  %cond.addr = alloca i8, align 1
  %p.addr = alloca i32*, align 8
  %i = alloca i32, align 4
  store i8 %cond, i8* %cond.addr, align 1
  store i32* %p, i32** %p.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 100000000
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i8, i8* %cond.addr, align 1
  %2 = load i32*, i32** %p.addr, align 8
  %call = call i32 @_Z3funcPi(i8 signext %1, i32* %2)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4
  %inc = add nsw i32 %3, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %4 = load i8, i8* %cond.addr, align 1
  %5 = load i32*, i32** %p.addr, align 8
  %call1 = call i32 @_Z3funcPi(i8 signext %4, i32* %5)
  ret i32 %call1
}

; Function Attrs: noinline norecurse uwtable
define i32 @main() #1 {
entry:
  %x = alloca i32, align 4
  %res = alloca i32, align 4
  %call = call i32 @_Z11dummyCallercPi(i8 signext 1, i32* %x)
  store i32 %call, i32* %res, align 4
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0))
  ret i32 0
}

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define internal void @_Z4fun2cPi.1_if.then(i32** %p.addr) #3 {
  %0 = load i32*, i32** %p.addr, align 8
  store i32 12, i32* %0, align 4
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #4

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #4

; Function Attrs: nounwind uwtable
define internal void @_Z4fun1cPi.2_if.then(i32** %p.addr) #3 {
  %0 = load i32*, i32** %p.addr, align 8
  store i32 11, i32* %0, align 4
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
