; ModuleID = 'main-alt-opt4-inline.bc'
source_filename = "main-alt.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"hello\0A\00", align 1

; Function Attrs: noinline norecurse uwtable
define i32 @main() #0 {
entry:
  %p.addr.i.i.i = alloca i32*, align 8
  %condFun1.i.i.i = alloca i8, align 1
  %p.addr.i.i = alloca i32*, align 8
  %cond.i.i = alloca i8, align 1
  %cond2.i.i = alloca i8, align 1
  %res.i.i = alloca i32, align 4
  %p.addr.i = alloca i32*, align 8
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
  %1 = bitcast i32** %p.addr.i.i.i to i8*
  call void @llvm.lifetime.start(i64 8, i8* %1)
  call void @llvm.lifetime.start(i64 1, i8* %condFun1.i.i.i)
  %2 = bitcast i32** %p.addr.i to i8*
  call void @llvm.lifetime.start(i64 8, i8* %2)
  store i32* %x, i32** %p.addr.i, align 8
  %3 = load i32*, i32** %p.addr.i, align 8
  %4 = bitcast i32** %p.addr.i.i to i8*
  call void @llvm.lifetime.start(i64 8, i8* %4) #3
  call void @llvm.lifetime.start(i64 1, i8* %cond.i.i) #3
  call void @llvm.lifetime.start(i64 1, i8* %cond2.i.i) #3
  %5 = bitcast i32* %res.i.i to i8*
  call void @llvm.lifetime.start(i64 4, i8* %5) #3
  store i32* %3, i32** %p.addr.i.i, align 8
  store i8 1, i8* %cond.i.i, align 1
  store i8 1, i8* %cond2.i.i, align 1
  store i32 99, i32* %res.i.i, align 4
  %6 = load i8, i8* %cond.i.i, align 1
  %tobool.i.i = icmp ne i8 %6, 0
  br i1 %tobool.i.i, label %codeRepl.i, label %_Z11dummyCallerPi.2.exit

codeRepl.i:                                       ; preds = %for.body
  %7 = bitcast i32** %p.addr.i.i.i to i8*
  call void @llvm.lifetime.start(i64 8, i8* %7) #3
  call void @llvm.lifetime.start(i64 1, i8* %condFun1.i.i.i) #3
  %8 = load i8, i8* %cond2.i.i, align 1
  %tobool1.i.i = icmp ne i8 %8, 0
  br i1 %tobool1.i.i, label %codeRepl.i1, label %_Z11dummyCallerPi.2_codeRepl.i.1.exit

codeRepl.i1:                                      ; preds = %codeRepl.i
  %9 = load i32*, i32** %p.addr.i.i, align 8
  %10 = bitcast i32** %p.addr.i.i.i to i8*
  call void @llvm.lifetime.start(i64 8, i8* %10) #3
  call void @llvm.lifetime.start(i64 1, i8* %condFun1.i.i.i) #3
  store i32* %9, i32** %p.addr.i.i.i, align 8
  store i8 1, i8* %condFun1.i.i.i, align 1
  %11 = load i8, i8* %condFun1.i.i.i, align 1
  %tobool.i.i.i = icmp ne i8 %11, 0
  br i1 %tobool.i.i.i, label %codeRepl.i2, label %_Z11dummyCallerPi.2_codeRepl.i.1_codeRepl.i1.1.exit

codeRepl.i2:                                      ; preds = %codeRepl.i1
  %12 = load i32*, i32** %p.addr.i.i.i, align 8
  store i32 11, i32* %12, align 4
  br label %_Z11dummyCallerPi.2_codeRepl.i.1_codeRepl.i1.1.exit

_Z11dummyCallerPi.2_codeRepl.i.1_codeRepl.i1.1.exit: ; preds = %codeRepl.i2, %codeRepl.i1
  %13 = bitcast i32** %p.addr.i.i.i to i8*
  call void @llvm.lifetime.end(i64 8, i8* %13) #3
  call void @llvm.lifetime.end(i64 1, i8* %condFun1.i.i.i) #3
  br label %_Z11dummyCallerPi.2_codeRepl.i.1.exit

_Z11dummyCallerPi.2_codeRepl.i.1.exit:            ; preds = %_Z11dummyCallerPi.2_codeRepl.i.1_codeRepl.i1.1.exit, %codeRepl.i
  %14 = bitcast i32** %p.addr.i.i.i to i8*
  call void @llvm.lifetime.end(i64 8, i8* %14) #3
  call void @llvm.lifetime.end(i64 1, i8* %condFun1.i.i.i) #3
  br label %_Z11dummyCallerPi.2.exit

_Z11dummyCallerPi.2.exit:                         ; preds = %_Z11dummyCallerPi.2_codeRepl.i.1.exit, %for.body
  %15 = bitcast i32** %p.addr.i.i to i8*
  call void @llvm.lifetime.end(i64 8, i8* %15) #3
  call void @llvm.lifetime.end(i64 1, i8* %cond.i.i) #3
  call void @llvm.lifetime.end(i64 1, i8* %cond2.i.i) #3
  %16 = bitcast i32* %res.i.i to i8*
  call void @llvm.lifetime.end(i64 4, i8* %16) #3
  %17 = bitcast i32** %p.addr.i.i.i to i8*
  call void @llvm.lifetime.end(i64 8, i8* %17)
  call void @llvm.lifetime.end(i64 1, i8* %condFun1.i.i.i)
  %18 = bitcast i32** %p.addr.i to i8*
  call void @llvm.lifetime.end(i64 8, i8* %18)
  br label %for.inc

for.inc:                                          ; preds = %_Z11dummyCallerPi.2.exit
  %19 = load i32, i32* %i, align 4
  %inc = add nsw i32 %19, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0))
  %20 = load i32, i32* %retval, align 4
  ret i32 %20
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

attributes #0 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
