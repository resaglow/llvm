; ModuleID = 'main-opt-default.bc'
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
  %vec.phi = phi <8 x i32> [ zeroinitializer, %vector.ph ], [ %40, %vector.body ]
  %vec.phi4 = phi <8 x i32> [ zeroinitializer, %vector.ph ], [ %41, %vector.body ]
  %vec.phi5 = phi <8 x i32> [ zeroinitializer, %vector.ph ], [ %42, %vector.body ]
  %vec.phi6 = phi <8 x i32> [ zeroinitializer, %vector.ph ], [ %43, %vector.body ]
  %broadcast.splatinsert = insertelement <8 x i64> undef, i64 %index, i32 0
  %broadcast.splat = shufflevector <8 x i64> %broadcast.splatinsert, <8 x i64> undef, <8 x i32> zeroinitializer
  %induction = add <8 x i64> %broadcast.splat, <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7>
  %induction1 = add <8 x i64> %broadcast.splat, <i64 8, i64 9, i64 10, i64 11, i64 12, i64 13, i64 14, i64 15>
  %induction2 = add <8 x i64> %broadcast.splat, <i64 16, i64 17, i64 18, i64 19, i64 20, i64 21, i64 22, i64 23>
  %induction3 = add <8 x i64> %broadcast.splat, <i64 24, i64 25, i64 26, i64 27, i64 28, i64 29, i64 30, i64 31>
  %0 = add i64 %index, 0
  %1 = add i64 %index, 8
  %2 = add i64 %index, 16
  %3 = add i64 %index, 24
  %4 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 0
  %5 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 0
  %6 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 0
  %7 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 0
  %8 = getelementptr i32, i32* %4, i32 0
  %9 = bitcast i32* %8 to <32 x i32>*
  %10 = getelementptr i32, i32* %5, i32 0
  %11 = bitcast i32* %10 to <32 x i32>*
  %12 = getelementptr i32, i32* %6, i32 0
  %13 = bitcast i32* %12 to <32 x i32>*
  %14 = getelementptr i32, i32* %7, i32 0
  %15 = bitcast i32* %14 to <32 x i32>*
  %wide.vec = load <32 x i32>, <32 x i32>* %9, align 4
  %wide.vec7 = load <32 x i32>, <32 x i32>* %11, align 4
  %wide.vec8 = load <32 x i32>, <32 x i32>* %13, align 4
  %wide.vec9 = load <32 x i32>, <32 x i32>* %15, align 4
  %strided.vec = shufflevector <32 x i32> %wide.vec, <32 x i32> undef, <8 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28>
  %strided.vec10 = shufflevector <32 x i32> %wide.vec7, <32 x i32> undef, <8 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28>
  %strided.vec11 = shufflevector <32 x i32> %wide.vec8, <32 x i32> undef, <8 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28>
  %strided.vec12 = shufflevector <32 x i32> %wide.vec9, <32 x i32> undef, <8 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28>
  %strided.vec13 = shufflevector <32 x i32> %wide.vec, <32 x i32> undef, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  %strided.vec14 = shufflevector <32 x i32> %wide.vec7, <32 x i32> undef, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  %strided.vec15 = shufflevector <32 x i32> %wide.vec8, <32 x i32> undef, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  %strided.vec16 = shufflevector <32 x i32> %wide.vec9, <32 x i32> undef, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  %strided.vec17 = shufflevector <32 x i32> %wide.vec, <32 x i32> undef, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  %strided.vec18 = shufflevector <32 x i32> %wide.vec7, <32 x i32> undef, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  %strided.vec19 = shufflevector <32 x i32> %wide.vec8, <32 x i32> undef, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  %strided.vec20 = shufflevector <32 x i32> %wide.vec9, <32 x i32> undef, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  %strided.vec21 = shufflevector <32 x i32> %wide.vec, <32 x i32> undef, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>
  %strided.vec22 = shufflevector <32 x i32> %wide.vec7, <32 x i32> undef, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>
  %strided.vec23 = shufflevector <32 x i32> %wide.vec8, <32 x i32> undef, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>
  %strided.vec24 = shufflevector <32 x i32> %wide.vec9, <32 x i32> undef, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>
  %16 = add nsw <8 x i32> %strided.vec, %vec.phi
  %17 = add nsw <8 x i32> %strided.vec10, %vec.phi4
  %18 = add nsw <8 x i32> %strided.vec11, %vec.phi5
  %19 = add nsw <8 x i32> %strided.vec12, %vec.phi6
  %20 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 1
  %21 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 1
  %22 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 1
  %23 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 1
  %24 = sub <8 x i32> %16, %strided.vec13
  %25 = sub <8 x i32> %17, %strided.vec14
  %26 = sub <8 x i32> %18, %strided.vec15
  %27 = sub <8 x i32> %19, %strided.vec16
  %28 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 2
  %29 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 2
  %30 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 2
  %31 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 2
  %32 = add nsw <8 x i32> %24, %strided.vec17
  %33 = add nsw <8 x i32> %25, %strided.vec18
  %34 = add nsw <8 x i32> %26, %strided.vec19
  %35 = add nsw <8 x i32> %27, %strided.vec20
  %36 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 3
  %37 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 3
  %38 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 3
  %39 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 3
  %40 = sub <8 x i32> %32, %strided.vec21
  %41 = sub <8 x i32> %33, %strided.vec22
  %42 = sub <8 x i32> %34, %strided.vec23
  %43 = sub <8 x i32> %35, %strided.vec24
  %index.next = add i64 %index, 32
  %44 = icmp eq i64 %index.next, 1024
  br i1 %44, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <8 x i32> %41, %40
  %bin.rdx25 = add <8 x i32> %42, %bin.rdx
  %bin.rdx26 = add <8 x i32> %43, %bin.rdx25
  %rdx.shuf = shufflevector <8 x i32> %bin.rdx26, <8 x i32> undef, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx27 = add <8 x i32> %bin.rdx26, %rdx.shuf
  %rdx.shuf28 = shufflevector <8 x i32> %bin.rdx27, <8 x i32> undef, <8 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx29 = add <8 x i32> %bin.rdx27, %rdx.shuf28
  %rdx.shuf30 = shufflevector <8 x i32> %bin.rdx29, <8 x i32> undef, <8 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx31 = add <8 x i32> %bin.rdx29, %rdx.shuf30
  %45 = extractelement <8 x i32> %bin.rdx31, i32 0
  %cmp.n = icmp eq i64 1024, 1024
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %min.iters.checked, %entry
  %bc.resume.val = phi i64 [ 1024, %middle.block ], [ 0, %entry ], [ 0, %min.iters.checked ]
  %bc.merge.rdx = phi i32 [ 0, %entry ], [ 0, %min.iters.checked ], [ %45, %middle.block ]
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
  %sub8.lcssa = phi i32 [ %sub8, %for.body ], [ %45, %middle.block ]
  ret i32 %sub8.lcssa
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+avx,+avx2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.vectorize.width", i32 1}
!2 = !{!"llvm.loop.interleave.count", i32 1}
!3 = distinct !{!3, !4, !1, !2}
!4 = !{!"llvm.loop.unroll.runtime.disable"}
