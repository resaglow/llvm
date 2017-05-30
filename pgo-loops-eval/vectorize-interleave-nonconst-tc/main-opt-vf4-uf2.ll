; ModuleID = 'main-opt-vf4-uf2.bc'
source_filename = "main.ll"

%struct.ST4 = type { i32, i32, i32, i32 }

define i32 @test_struct_load4(%struct.ST4* nocapture readonly %S) {
entry:
  br i1 false, label %scalar.ph, label %min.iters.checked

min.iters.checked:                                ; preds = %entry
  br i1 false, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %min.iters.checked
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <4 x i32> [ zeroinitializer, %vector.ph ], [ %110, %vector.body ]
  %vec.phi2 = phi <4 x i32> [ zeroinitializer, %vector.ph ], [ %111, %vector.body ]
  %broadcast.splatinsert = insertelement <4 x i64> undef, i64 %index, i32 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> undef, <4 x i32> zeroinitializer
  %induction = add <4 x i64> %broadcast.splat, <i64 0, i64 1, i64 2, i64 3>
  %induction1 = add <4 x i64> %broadcast.splat, <i64 4, i64 5, i64 6, i64 7>
  %0 = add i64 %index, 0
  %1 = add i64 %index, 1
  %2 = add i64 %index, 2
  %3 = add i64 %index, 3
  %4 = add i64 %index, 4
  %5 = add i64 %index, 5
  %6 = add i64 %index, 6
  %7 = add i64 %index, 7
  %8 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 0
  %9 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 0
  %10 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 0
  %11 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 0
  %12 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %4, i32 0
  %13 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %5, i32 0
  %14 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %6, i32 0
  %15 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %7, i32 0
  %16 = load i32, i32* %8, align 4
  %17 = load i32, i32* %9, align 4
  %18 = load i32, i32* %10, align 4
  %19 = load i32, i32* %11, align 4
  %20 = load i32, i32* %12, align 4
  %21 = load i32, i32* %13, align 4
  %22 = load i32, i32* %14, align 4
  %23 = load i32, i32* %15, align 4
  %24 = insertelement <4 x i32> undef, i32 %16, i32 0
  %25 = insertelement <4 x i32> %24, i32 %17, i32 1
  %26 = insertelement <4 x i32> %25, i32 %18, i32 2
  %27 = insertelement <4 x i32> %26, i32 %19, i32 3
  %28 = insertelement <4 x i32> undef, i32 %20, i32 0
  %29 = insertelement <4 x i32> %28, i32 %21, i32 1
  %30 = insertelement <4 x i32> %29, i32 %22, i32 2
  %31 = insertelement <4 x i32> %30, i32 %23, i32 3
  %32 = add nsw <4 x i32> %27, %vec.phi
  %33 = add nsw <4 x i32> %31, %vec.phi2
  %34 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 1
  %35 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 1
  %36 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 1
  %37 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 1
  %38 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %4, i32 1
  %39 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %5, i32 1
  %40 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %6, i32 1
  %41 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %7, i32 1
  %42 = load i32, i32* %34, align 4
  %43 = load i32, i32* %35, align 4
  %44 = load i32, i32* %36, align 4
  %45 = load i32, i32* %37, align 4
  %46 = load i32, i32* %38, align 4
  %47 = load i32, i32* %39, align 4
  %48 = load i32, i32* %40, align 4
  %49 = load i32, i32* %41, align 4
  %50 = insertelement <4 x i32> undef, i32 %42, i32 0
  %51 = insertelement <4 x i32> %50, i32 %43, i32 1
  %52 = insertelement <4 x i32> %51, i32 %44, i32 2
  %53 = insertelement <4 x i32> %52, i32 %45, i32 3
  %54 = insertelement <4 x i32> undef, i32 %46, i32 0
  %55 = insertelement <4 x i32> %54, i32 %47, i32 1
  %56 = insertelement <4 x i32> %55, i32 %48, i32 2
  %57 = insertelement <4 x i32> %56, i32 %49, i32 3
  %58 = sub <4 x i32> %32, %53
  %59 = sub <4 x i32> %33, %57
  %60 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 2
  %61 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 2
  %62 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 2
  %63 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 2
  %64 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %4, i32 2
  %65 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %5, i32 2
  %66 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %6, i32 2
  %67 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %7, i32 2
  %68 = load i32, i32* %60, align 4
  %69 = load i32, i32* %61, align 4
  %70 = load i32, i32* %62, align 4
  %71 = load i32, i32* %63, align 4
  %72 = load i32, i32* %64, align 4
  %73 = load i32, i32* %65, align 4
  %74 = load i32, i32* %66, align 4
  %75 = load i32, i32* %67, align 4
  %76 = insertelement <4 x i32> undef, i32 %68, i32 0
  %77 = insertelement <4 x i32> %76, i32 %69, i32 1
  %78 = insertelement <4 x i32> %77, i32 %70, i32 2
  %79 = insertelement <4 x i32> %78, i32 %71, i32 3
  %80 = insertelement <4 x i32> undef, i32 %72, i32 0
  %81 = insertelement <4 x i32> %80, i32 %73, i32 1
  %82 = insertelement <4 x i32> %81, i32 %74, i32 2
  %83 = insertelement <4 x i32> %82, i32 %75, i32 3
  %84 = add nsw <4 x i32> %58, %79
  %85 = add nsw <4 x i32> %59, %83
  %86 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 3
  %87 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 3
  %88 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 3
  %89 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 3
  %90 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %4, i32 3
  %91 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %5, i32 3
  %92 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %6, i32 3
  %93 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %7, i32 3
  %94 = load i32, i32* %86, align 4
  %95 = load i32, i32* %87, align 4
  %96 = load i32, i32* %88, align 4
  %97 = load i32, i32* %89, align 4
  %98 = load i32, i32* %90, align 4
  %99 = load i32, i32* %91, align 4
  %100 = load i32, i32* %92, align 4
  %101 = load i32, i32* %93, align 4
  %102 = insertelement <4 x i32> undef, i32 %94, i32 0
  %103 = insertelement <4 x i32> %102, i32 %95, i32 1
  %104 = insertelement <4 x i32> %103, i32 %96, i32 2
  %105 = insertelement <4 x i32> %104, i32 %97, i32 3
  %106 = insertelement <4 x i32> undef, i32 %98, i32 0
  %107 = insertelement <4 x i32> %106, i32 %99, i32 1
  %108 = insertelement <4 x i32> %107, i32 %100, i32 2
  %109 = insertelement <4 x i32> %108, i32 %101, i32 3
  %110 = sub <4 x i32> %84, %105
  %111 = sub <4 x i32> %85, %109
  %index.next = add i64 %index, 8
  %112 = icmp eq i64 %index.next, 1024
  br i1 %112, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <4 x i32> %111, %110
  %rdx.shuf = shufflevector <4 x i32> %bin.rdx, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx3 = add <4 x i32> %bin.rdx, %rdx.shuf
  %rdx.shuf4 = shufflevector <4 x i32> %bin.rdx3, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx5 = add <4 x i32> %bin.rdx3, %rdx.shuf4
  %113 = extractelement <4 x i32> %bin.rdx5, i32 0
  %cmp.n = icmp eq i64 1024, 1024
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %min.iters.checked, %entry
  %bc.resume.val = phi i64 [ 1024, %middle.block ], [ 0, %entry ], [ 0, %min.iters.checked ]
  %bc.merge.rdx = phi i32 [ 0, %entry ], [ 0, %min.iters.checked ], [ %113, %middle.block ]
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
  %sub8.lcssa = phi i32 [ %sub8, %for.body ], [ %113, %middle.block ]
  ret i32 %sub8.lcssa
}

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.vectorize.width", i32 1}
!2 = !{!"llvm.loop.interleave.count", i32 1}
!3 = distinct !{!3, !4, !1, !2}
!4 = !{!"llvm.loop.unroll.runtime.disable"}
