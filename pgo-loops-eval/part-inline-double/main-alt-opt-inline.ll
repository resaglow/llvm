; ModuleID = 'main-alt-opt-inline.bc'
source_filename = "main-alt.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"hello\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define void @_Z11dummyCallerPi(i32* %p) #0 {
entry:
  %p.addr.i1.i = alloca i32*, align 8
  %condFun1.i.i = alloca i8, align 1
  %p.addr.i.i = alloca i32*, align 8
  %condFun2.i.i = alloca i8, align 1
  %p.addr.i = alloca i32*, align 8
  %cond.i = alloca i8, align 1
  %cond2.i = alloca i8, align 1
  %res.i = alloca i32, align 4
  %p.addr = alloca i32*, align 8
  store i32* %p, i32** %p.addr, align 8
  %0 = load i32*, i32** %p.addr, align 8
  %1 = bitcast i32** %p.addr.i to i8*
  call void @llvm.lifetime.start(i64 8, i8* %1)
  call void @llvm.lifetime.start(i64 1, i8* %cond.i)
  call void @llvm.lifetime.start(i64 1, i8* %cond2.i)
  %2 = bitcast i32* %res.i to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2)
  store i32* %0, i32** %p.addr.i, align 8
  store i8 1, i8* %cond.i, align 1
  store i8 0, i8* %cond2.i, align 1
  store i32 99, i32* %res.i, align 4
  %3 = load i8, i8* %cond.i, align 1
  %tobool.i = icmp ne i8 %3, 0
  br i1 %tobool.i, label %codeRepl.i, label %_Z3funPi.1.exit

codeRepl.i:                                       ; preds = %entry
  %4 = load i8, i8* %cond2.i, align 1
  %tobool1.i = icmp ne i8 %4, 0
  br i1 %tobool1.i, label %if.then2.i, label %if.else.i

if.then2.i:                                       ; preds = %codeRepl.i
  %5 = load i32*, i32** %p.addr.i, align 8
  %6 = bitcast i32** %p.addr.i1.i to i8*
  call void @llvm.lifetime.start(i64 8, i8* %6) #4
  call void @llvm.lifetime.start(i64 1, i8* %condFun1.i.i) #4
  store i32* %5, i32** %p.addr.i1.i, align 8
  store i8 1, i8* %condFun1.i.i, align 1
  %7 = load i8, i8* %condFun1.i.i, align 1
  %tobool.i2.i = icmp ne i8 %7, 0
  br i1 %tobool.i2.i, label %codeRepl.i3.i, label %_Z4fun1Pi.3.exit.i

codeRepl.i3.i:                                    ; preds = %if.then2.i
  %8 = load i32*, i32** %p.addr.i1.i, align 8
  store i32 11, i32* %8, align 4
  br label %_Z4fun1Pi.3.exit.i

_Z4fun1Pi.3.exit.i:                               ; preds = %codeRepl.i3.i, %if.then2.i
  %9 = bitcast i32** %p.addr.i1.i to i8*
  call void @llvm.lifetime.end(i64 8, i8* %9) #4
  call void @llvm.lifetime.end(i64 1, i8* %condFun1.i.i) #4
  br label %_Z3funPi.1_if.then.exit

if.else.i:                                        ; preds = %codeRepl.i
  %10 = load i32*, i32** %p.addr.i, align 8
  %11 = bitcast i32** %p.addr.i.i to i8*
  call void @llvm.lifetime.start(i64 8, i8* %11) #4
  call void @llvm.lifetime.start(i64 1, i8* %condFun2.i.i) #4
  store i32* %10, i32** %p.addr.i.i, align 8
  store i8 0, i8* %condFun2.i.i, align 1
  %12 = load i8, i8* %condFun2.i.i, align 1
  %tobool.i.i = icmp ne i8 %12, 0
  br i1 %tobool.i.i, label %codeRepl.i.i, label %_Z4fun2Pi.2.exit.i

codeRepl.i.i:                                     ; preds = %if.else.i
  %13 = load i32*, i32** %p.addr.i.i, align 8
  store i32 12, i32* %13, align 4
  br label %_Z4fun2Pi.2.exit.i

_Z4fun2Pi.2.exit.i:                               ; preds = %codeRepl.i.i, %if.else.i
  %14 = bitcast i32** %p.addr.i.i to i8*
  call void @llvm.lifetime.end(i64 8, i8* %14) #4
  call void @llvm.lifetime.end(i64 1, i8* %condFun2.i.i) #4
  br label %_Z3funPi.1_if.then.exit

_Z3funPi.1_if.then.exit:                          ; preds = %_Z4fun1Pi.3.exit.i, %_Z4fun2Pi.2.exit.i
  br label %_Z3funPi.1.exit

_Z3funPi.1.exit:                                  ; preds = %_Z3funPi.1_if.then.exit, %entry
  %15 = bitcast i32** %p.addr.i to i8*
  call void @llvm.lifetime.end(i64 8, i8* %15)
  call void @llvm.lifetime.end(i64 1, i8* %cond.i)
  call void @llvm.lifetime.end(i64 1, i8* %cond2.i)
  %16 = bitcast i32* %res.i to i8*
  call void @llvm.lifetime.end(i64 4, i8* %16)
  ret void
}

; Function Attrs: noinline norecurse uwtable
define i32 @main() #1 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 100000000
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  call void @_Z11dummyCallerPi(i32* %x)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %1 = load i32, i32* %i, align 4
  %inc = add nsw i32 %1, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0))
  %2 = load i32, i32* %retval, align 4
  ret i32 %2
}

declare i32 @printf(i8*, ...) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #3

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
