; ModuleID = 'main-opt-vfdef-uf1.bc'
source_filename = "main.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.ST4 = type { i32, i32, i32, i32 }

; Function Attrs: noinline nounwind uwtable
define i32 @test_struct_load4(%struct.ST4* nocapture readonly %S) #0 {
entry:
  br i1 false, label %scalar.ph, label %min.iters.checked

min.iters.checked:                                ; preds = %entry
  br i1 false, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %min.iters.checked
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <8 x i32> [ zeroinitializer, %vector.ph ], [ %10, %vector.body ]
  %broadcast.splatinsert = insertelement <8 x i64> undef, i64 %index, i32 0
  %broadcast.splat = shufflevector <8 x i64> %broadcast.splatinsert, <8 x i64> undef, <8 x i32> zeroinitializer
  %induction = add <8 x i64> %broadcast.splat, <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7>
  %0 = add i64 %index, 0
  %1 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 0
  %2 = getelementptr i32, i32* %1, i32 0
  %3 = bitcast i32* %2 to <32 x i32>*
  %wide.vec = load <32 x i32>, <32 x i32>* %3, align 4
  %strided.vec = shufflevector <32 x i32> %wide.vec, <32 x i32> undef, <8 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28>
  %strided.vec1 = shufflevector <32 x i32> %wide.vec, <32 x i32> undef, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  %strided.vec2 = shufflevector <32 x i32> %wide.vec, <32 x i32> undef, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  %strided.vec3 = shufflevector <32 x i32> %wide.vec, <32 x i32> undef, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>
  %4 = add nsw <8 x i32> %strided.vec, %vec.phi
  %5 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 1
  %6 = sub <8 x i32> %4, %strided.vec1
  %7 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 2
  %8 = add nsw <8 x i32> %6, %strided.vec2
  %9 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 3
  %10 = sub <8 x i32> %8, %strided.vec3
  %index.next = add i64 %index, 8
  %11 = icmp eq i64 %index.next, 1024
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %rdx.shuf = shufflevector <8 x i32> %10, <8 x i32> undef, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx = add <8 x i32> %10, %rdx.shuf
  %rdx.shuf4 = shufflevector <8 x i32> %bin.rdx, <8 x i32> undef, <8 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx5 = add <8 x i32> %bin.rdx, %rdx.shuf4
  %rdx.shuf6 = shufflevector <8 x i32> %bin.rdx5, <8 x i32> undef, <8 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx7 = add <8 x i32> %bin.rdx5, %rdx.shuf6
  %12 = extractelement <8 x i32> %bin.rdx7, i32 0
  %cmp.n = icmp eq i64 1024, 1024
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %min.iters.checked, %entry
  %bc.resume.val = phi i64 [ 1024, %middle.block ], [ 0, %entry ], [ 0, %min.iters.checked ]
  %bc.merge.rdx = phi i32 [ 0, %entry ], [ 0, %min.iters.checked ], [ %12, %middle.block ]
  br label %for.body

for.body:                                         ; preds = %for.body, %scalar.ph
  %indvars.iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %indvars.iv.next, %for.body ]
  %r.022 = phi i32 [ %bc.merge.rdx, %scalar.ph ], [ %sub8, %for.body ]
  %x = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %indvars.iv, i32 0
  %tmp = load i32, i32* %x, align 4
  %add = add nsw i32 %tmp, %r.022
  %y = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %indvars.iv, i32 1
  %tmp1 = load i32, i32* %y, align 4
  %sub = sub i32 %add, %tmp1
  %z = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %indvars.iv, i32 2
  %tmp2 = load i32, i32* %z, align 4
  %add5 = add nsw i32 %sub, %tmp2
  %w = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %indvars.iv, i32 3
  %tmp3 = load i32, i32* %w, align 4
  %sub8 = sub i32 %add5, %tmp3
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1024
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !3

for.end:                                          ; preds = %middle.block, %for.body
  %sub8.lcssa = phi i32 [ %sub8, %for.body ], [ %12, %middle.block ]
  ret i32 %sub8.lcssa
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+avx,+avx2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.vectorize.width", i32 1}
!2 = !{!"llvm.loop.interleave.count", i32 1}
!3 = distinct !{!3, !4, !1, !2}
!4 = !{!"llvm.loop.unroll.runtime.disable"}
