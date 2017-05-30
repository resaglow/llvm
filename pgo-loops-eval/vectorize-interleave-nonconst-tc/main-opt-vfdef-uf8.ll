; ModuleID = 'main-opt-vfdef-uf8.bc'
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
  %vec.phi = phi <8 x i32> [ zeroinitializer, %vector.ph ], [ %80, %vector.body ]
  %vec.phi8 = phi <8 x i32> [ zeroinitializer, %vector.ph ], [ %81, %vector.body ]
  %vec.phi9 = phi <8 x i32> [ zeroinitializer, %vector.ph ], [ %82, %vector.body ]
  %vec.phi10 = phi <8 x i32> [ zeroinitializer, %vector.ph ], [ %83, %vector.body ]
  %vec.phi11 = phi <8 x i32> [ zeroinitializer, %vector.ph ], [ %84, %vector.body ]
  %vec.phi12 = phi <8 x i32> [ zeroinitializer, %vector.ph ], [ %85, %vector.body ]
  %vec.phi13 = phi <8 x i32> [ zeroinitializer, %vector.ph ], [ %86, %vector.body ]
  %vec.phi14 = phi <8 x i32> [ zeroinitializer, %vector.ph ], [ %87, %vector.body ]
  %broadcast.splatinsert = insertelement <8 x i64> undef, i64 %index, i32 0
  %broadcast.splat = shufflevector <8 x i64> %broadcast.splatinsert, <8 x i64> undef, <8 x i32> zeroinitializer
  %induction = add <8 x i64> %broadcast.splat, <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7>
  %induction1 = add <8 x i64> %broadcast.splat, <i64 8, i64 9, i64 10, i64 11, i64 12, i64 13, i64 14, i64 15>
  %induction2 = add <8 x i64> %broadcast.splat, <i64 16, i64 17, i64 18, i64 19, i64 20, i64 21, i64 22, i64 23>
  %induction3 = add <8 x i64> %broadcast.splat, <i64 24, i64 25, i64 26, i64 27, i64 28, i64 29, i64 30, i64 31>
  %induction4 = add <8 x i64> %broadcast.splat, <i64 32, i64 33, i64 34, i64 35, i64 36, i64 37, i64 38, i64 39>
  %induction5 = add <8 x i64> %broadcast.splat, <i64 40, i64 41, i64 42, i64 43, i64 44, i64 45, i64 46, i64 47>
  %induction6 = add <8 x i64> %broadcast.splat, <i64 48, i64 49, i64 50, i64 51, i64 52, i64 53, i64 54, i64 55>
  %induction7 = add <8 x i64> %broadcast.splat, <i64 56, i64 57, i64 58, i64 59, i64 60, i64 61, i64 62, i64 63>
  %0 = add i64 %index, 0
  %1 = add i64 %index, 8
  %2 = add i64 %index, 16
  %3 = add i64 %index, 24
  %4 = add i64 %index, 32
  %5 = add i64 %index, 40
  %6 = add i64 %index, 48
  %7 = add i64 %index, 56
  %8 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 0
  %9 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 0
  %10 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 0
  %11 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 0
  %12 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %4, i32 0
  %13 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %5, i32 0
  %14 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %6, i32 0
  %15 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %7, i32 0
  %16 = getelementptr i32, i32* %8, i32 0
  %17 = bitcast i32* %16 to <32 x i32>*
  %18 = getelementptr i32, i32* %9, i32 0
  %19 = bitcast i32* %18 to <32 x i32>*
  %20 = getelementptr i32, i32* %10, i32 0
  %21 = bitcast i32* %20 to <32 x i32>*
  %22 = getelementptr i32, i32* %11, i32 0
  %23 = bitcast i32* %22 to <32 x i32>*
  %24 = getelementptr i32, i32* %12, i32 0
  %25 = bitcast i32* %24 to <32 x i32>*
  %26 = getelementptr i32, i32* %13, i32 0
  %27 = bitcast i32* %26 to <32 x i32>*
  %28 = getelementptr i32, i32* %14, i32 0
  %29 = bitcast i32* %28 to <32 x i32>*
  %30 = getelementptr i32, i32* %15, i32 0
  %31 = bitcast i32* %30 to <32 x i32>*
  %wide.vec = load <32 x i32>, <32 x i32>* %17, align 4
  %wide.vec15 = load <32 x i32>, <32 x i32>* %19, align 4
  %wide.vec16 = load <32 x i32>, <32 x i32>* %21, align 4
  %wide.vec17 = load <32 x i32>, <32 x i32>* %23, align 4
  %wide.vec18 = load <32 x i32>, <32 x i32>* %25, align 4
  %wide.vec19 = load <32 x i32>, <32 x i32>* %27, align 4
  %wide.vec20 = load <32 x i32>, <32 x i32>* %29, align 4
  %wide.vec21 = load <32 x i32>, <32 x i32>* %31, align 4
  %strided.vec = shufflevector <32 x i32> %wide.vec, <32 x i32> undef, <8 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28>
  %strided.vec22 = shufflevector <32 x i32> %wide.vec15, <32 x i32> undef, <8 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28>
  %strided.vec23 = shufflevector <32 x i32> %wide.vec16, <32 x i32> undef, <8 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28>
  %strided.vec24 = shufflevector <32 x i32> %wide.vec17, <32 x i32> undef, <8 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28>
  %strided.vec25 = shufflevector <32 x i32> %wide.vec18, <32 x i32> undef, <8 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28>
  %strided.vec26 = shufflevector <32 x i32> %wide.vec19, <32 x i32> undef, <8 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28>
  %strided.vec27 = shufflevector <32 x i32> %wide.vec20, <32 x i32> undef, <8 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28>
  %strided.vec28 = shufflevector <32 x i32> %wide.vec21, <32 x i32> undef, <8 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28>
  %strided.vec29 = shufflevector <32 x i32> %wide.vec, <32 x i32> undef, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  %strided.vec30 = shufflevector <32 x i32> %wide.vec15, <32 x i32> undef, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  %strided.vec31 = shufflevector <32 x i32> %wide.vec16, <32 x i32> undef, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  %strided.vec32 = shufflevector <32 x i32> %wide.vec17, <32 x i32> undef, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  %strided.vec33 = shufflevector <32 x i32> %wide.vec18, <32 x i32> undef, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  %strided.vec34 = shufflevector <32 x i32> %wide.vec19, <32 x i32> undef, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  %strided.vec35 = shufflevector <32 x i32> %wide.vec20, <32 x i32> undef, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  %strided.vec36 = shufflevector <32 x i32> %wide.vec21, <32 x i32> undef, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  %strided.vec37 = shufflevector <32 x i32> %wide.vec, <32 x i32> undef, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  %strided.vec38 = shufflevector <32 x i32> %wide.vec15, <32 x i32> undef, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  %strided.vec39 = shufflevector <32 x i32> %wide.vec16, <32 x i32> undef, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  %strided.vec40 = shufflevector <32 x i32> %wide.vec17, <32 x i32> undef, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  %strided.vec41 = shufflevector <32 x i32> %wide.vec18, <32 x i32> undef, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  %strided.vec42 = shufflevector <32 x i32> %wide.vec19, <32 x i32> undef, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  %strided.vec43 = shufflevector <32 x i32> %wide.vec20, <32 x i32> undef, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  %strided.vec44 = shufflevector <32 x i32> %wide.vec21, <32 x i32> undef, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  %strided.vec45 = shufflevector <32 x i32> %wide.vec, <32 x i32> undef, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>
  %strided.vec46 = shufflevector <32 x i32> %wide.vec15, <32 x i32> undef, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>
  %strided.vec47 = shufflevector <32 x i32> %wide.vec16, <32 x i32> undef, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>
  %strided.vec48 = shufflevector <32 x i32> %wide.vec17, <32 x i32> undef, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>
  %strided.vec49 = shufflevector <32 x i32> %wide.vec18, <32 x i32> undef, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>
  %strided.vec50 = shufflevector <32 x i32> %wide.vec19, <32 x i32> undef, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>
  %strided.vec51 = shufflevector <32 x i32> %wide.vec20, <32 x i32> undef, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>
  %strided.vec52 = shufflevector <32 x i32> %wide.vec21, <32 x i32> undef, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>
  %32 = add nsw <8 x i32> %strided.vec, %vec.phi
  %33 = add nsw <8 x i32> %strided.vec22, %vec.phi8
  %34 = add nsw <8 x i32> %strided.vec23, %vec.phi9
  %35 = add nsw <8 x i32> %strided.vec24, %vec.phi10
  %36 = add nsw <8 x i32> %strided.vec25, %vec.phi11
  %37 = add nsw <8 x i32> %strided.vec26, %vec.phi12
  %38 = add nsw <8 x i32> %strided.vec27, %vec.phi13
  %39 = add nsw <8 x i32> %strided.vec28, %vec.phi14
  %40 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 1
  %41 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 1
  %42 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 1
  %43 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 1
  %44 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %4, i32 1
  %45 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %5, i32 1
  %46 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %6, i32 1
  %47 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %7, i32 1
  %48 = sub <8 x i32> %32, %strided.vec29
  %49 = sub <8 x i32> %33, %strided.vec30
  %50 = sub <8 x i32> %34, %strided.vec31
  %51 = sub <8 x i32> %35, %strided.vec32
  %52 = sub <8 x i32> %36, %strided.vec33
  %53 = sub <8 x i32> %37, %strided.vec34
  %54 = sub <8 x i32> %38, %strided.vec35
  %55 = sub <8 x i32> %39, %strided.vec36
  %56 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 2
  %57 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 2
  %58 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 2
  %59 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 2
  %60 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %4, i32 2
  %61 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %5, i32 2
  %62 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %6, i32 2
  %63 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %7, i32 2
  %64 = add nsw <8 x i32> %48, %strided.vec37
  %65 = add nsw <8 x i32> %49, %strided.vec38
  %66 = add nsw <8 x i32> %50, %strided.vec39
  %67 = add nsw <8 x i32> %51, %strided.vec40
  %68 = add nsw <8 x i32> %52, %strided.vec41
  %69 = add nsw <8 x i32> %53, %strided.vec42
  %70 = add nsw <8 x i32> %54, %strided.vec43
  %71 = add nsw <8 x i32> %55, %strided.vec44
  %72 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 3
  %73 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 3
  %74 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 3
  %75 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 3
  %76 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %4, i32 3
  %77 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %5, i32 3
  %78 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %6, i32 3
  %79 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %7, i32 3
  %80 = sub <8 x i32> %64, %strided.vec45
  %81 = sub <8 x i32> %65, %strided.vec46
  %82 = sub <8 x i32> %66, %strided.vec47
  %83 = sub <8 x i32> %67, %strided.vec48
  %84 = sub <8 x i32> %68, %strided.vec49
  %85 = sub <8 x i32> %69, %strided.vec50
  %86 = sub <8 x i32> %70, %strided.vec51
  %87 = sub <8 x i32> %71, %strided.vec52
  %index.next = add i64 %index, 64
  %88 = icmp eq i64 %index.next, 1024
  br i1 %88, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <8 x i32> %81, %80
  %bin.rdx53 = add <8 x i32> %82, %bin.rdx
  %bin.rdx54 = add <8 x i32> %83, %bin.rdx53
  %bin.rdx55 = add <8 x i32> %84, %bin.rdx54
  %bin.rdx56 = add <8 x i32> %85, %bin.rdx55
  %bin.rdx57 = add <8 x i32> %86, %bin.rdx56
  %bin.rdx58 = add <8 x i32> %87, %bin.rdx57
  %rdx.shuf = shufflevector <8 x i32> %bin.rdx58, <8 x i32> undef, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx59 = add <8 x i32> %bin.rdx58, %rdx.shuf
  %rdx.shuf60 = shufflevector <8 x i32> %bin.rdx59, <8 x i32> undef, <8 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx61 = add <8 x i32> %bin.rdx59, %rdx.shuf60
  %rdx.shuf62 = shufflevector <8 x i32> %bin.rdx61, <8 x i32> undef, <8 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx63 = add <8 x i32> %bin.rdx61, %rdx.shuf62
  %89 = extractelement <8 x i32> %bin.rdx63, i32 0
  %cmp.n = icmp eq i64 1024, 1024
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %min.iters.checked, %entry
  %bc.resume.val = phi i64 [ 1024, %middle.block ], [ 0, %entry ], [ 0, %min.iters.checked ]
  %bc.merge.rdx = phi i32 [ 0, %entry ], [ 0, %min.iters.checked ], [ %89, %middle.block ]
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
  %sub8.lcssa = phi i32 [ %sub8, %for.body ], [ %89, %middle.block ]
  ret i32 %sub8.lcssa
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+avx,+avx2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.vectorize.width", i32 1}
!2 = !{!"llvm.loop.interleave.count", i32 1}
!3 = distinct !{!3, !4, !1, !2}
!4 = !{!"llvm.loop.unroll.runtime.disable"}
