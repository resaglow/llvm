; ModuleID = 'main.bc'
source_filename = "main.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline norecurse nounwind uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %arr = alloca [32 x i32], align 16
  %i = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %0 = bitcast [32 x i32]* %arr to i8*
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 128, i32 16, i1 false)
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %1, 32
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %i, align 4
  %3 = load i32, i32* %i, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds [32 x i32], [32 x i32]* %arr, i64 0, i64 %idxprom
  store i32 %2, i32* %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %4 = load i32, i32* %i, align 4
  %inc = add nsw i32 %4, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %5 = load i32, i32* %retval, align 4
  ret i32 %5
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #1

attributes #0 = { noinline norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
