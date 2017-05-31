; ModuleID = 'main-alt-opt.bc'
source_filename = "main-alt.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"hello\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define void @_Z11dummyCallerPi(i32* %p) #0 {
entry:
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
  store i8 0, i8* %cond.i, align 1
  store i8 1, i8* %cond2.i, align 1
  store i32 99, i32* %res.i, align 4
  %3 = load i8, i8* %cond.i, align 1
  %tobool.i = icmp ne i8 %3, 0
  br i1 %tobool.i, label %codeRepl.i, label %_Z3funPi.1.exit

codeRepl.i:                                       ; preds = %entry
  call void @_Z3funPi.1_if.then(i8* %cond2.i, i32** %p.addr.i) #5
  br label %_Z3funPi.1.exit

_Z3funPi.1.exit:                                  ; preds = %entry, %codeRepl.i
  %4 = bitcast i32** %p.addr.i to i8*
  call void @llvm.lifetime.end(i64 8, i8* %4)
  call void @llvm.lifetime.end(i64 1, i8* %cond.i)
  call void @llvm.lifetime.end(i64 1, i8* %cond2.i)
  %5 = bitcast i32* %res.i to i8*
  call void @llvm.lifetime.end(i64 4, i8* %5)
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

; Function Attrs: nounwind uwtable
define internal void @_Z3funPi.1_if.then(i8* %cond2, i32** %p.addr) #3 {
newFuncRoot:
  %p.addr.i = alloca i32*, align 8
  %condFun1.i = alloca i8, align 1
  %0 = load i8, i8* %cond2, align 1
  %tobool1 = icmp ne i8 %0, 0
  br i1 %tobool1, label %if.then2, label %if.end

if.then2:                                         ; preds = %newFuncRoot
  %1 = load i32*, i32** %p.addr, align 8
  %2 = bitcast i32** %p.addr.i to i8*
  call void @llvm.lifetime.start(i64 8, i8* %2)
  call void @llvm.lifetime.start(i64 1, i8* %condFun1.i)
  store i32* %1, i32** %p.addr.i, align 8
  store i8 1, i8* %condFun1.i, align 1
  %3 = load i8, i8* %condFun1.i, align 1
  %tobool.i = icmp ne i8 %3, 0
  br i1 %tobool.i, label %codeRepl.i, label %_Z4fun1Pi.2.exit

codeRepl.i:                                       ; preds = %if.then2
  call void @_Z4fun1Pi.2_if.then(i32** %p.addr.i) #5
  br label %_Z4fun1Pi.2.exit

_Z4fun1Pi.2.exit:                                 ; preds = %if.then2, %codeRepl.i
  %4 = bitcast i32** %p.addr.i to i8*
  call void @llvm.lifetime.end(i64 8, i8* %4)
  call void @llvm.lifetime.end(i64 1, i8* %condFun1.i)
  br label %if.end

if.end:                                           ; preds = %_Z4fun1Pi.2.exit, %if.then
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #4

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #4

; Function Attrs: nounwind uwtable
define internal void @_Z4fun1Pi.2_if.then(i32** %p.addr) #3 {
newFuncRoot:
  br label %if.then

.exitStub:                                        ; preds = %if.end
  ret void

if.then:                                          ; preds = %newFuncRoot
  %0 = load i32*, i32** %p.addr, align 8
  store i32 11, i32* %0, align 4
  br label %if.end

if.end:                                           ; preds = %if.then
  br label %.exitStub
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
