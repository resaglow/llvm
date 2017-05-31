; ModuleID = 'main-using.bc'
source_filename = "main.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = local_unnamed_addr global [67108864 x i32] zeroinitializer, align 16
@b = local_unnamed_addr global [67108864 x i32] zeroinitializer, align 16
@c = local_unnamed_addr global [67108864 x i32] zeroinitializer, align 16
@.str = private unnamed_addr constant [4 x i8] c"%ld\00", align 1

; Function Attrs: inlinehint norecurse nounwind uwtable
define i32 @main() local_unnamed_addr #0 !prof !28 {
entry:
  %n = alloca i64, align 8
  %0 = bitcast i64* %n to i8*
  call void @llvm.lifetime.start(i64 8, i8* nonnull %0) #3
  %call = call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i64* nonnull %n)
  %1 = load i64, i64* %n, align 8, !tbaa !29
  %cmp10 = icmp sgt i64 %1, 0
  br i1 %cmp10, label %for.body.lr.ph, label %for.cond.cleanup, !prof !33

for.body.lr.ph:                                   ; preds = %entry
  %2 = load i64, i64* %n, align 8, !tbaa !29
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  call void @llvm.lifetime.end(i64 8, i8* nonnull %0) #3
  ret i32 0

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %for.body.for.body_crit_edge ]
  %arrayidx = getelementptr inbounds [67108864 x i32], [67108864 x i32]* @b, i64 0, i64 %indvars.iv
  %3 = load i32, i32* %arrayidx, align 4, !tbaa !34
  %arrayidx2 = getelementptr inbounds [67108864 x i32], [67108864 x i32]* @c, i64 0, i64 %indvars.iv
  %4 = load i32, i32* %arrayidx2, align 4, !tbaa !34
  %add = add nsw i32 %4, %3
  %arrayidx4 = getelementptr inbounds [67108864 x i32], [67108864 x i32]* @a, i64 0, i64 %indvars.iv
  store i32 %add, i32* %arrayidx4, align 4, !tbaa !34
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %cmp = icmp slt i64 %indvars.iv.next, %2
  br i1 %cmp, label %for.body.for.body_crit_edge, label %for.cond.cleanup.loopexit, !prof !36

for.body.for.body_crit_edge:                      ; preds = %for.body
  br label %for.body
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare i32 @scanf(i8* nocapture readonly, ...) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { inlinehint norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"clang version 4.0.1 (tags/RELEASE_400/final)"}
!1 = !{i32 1, !"ProfileSummary", !2}
!2 = !{!3, !4, !5, !6, !7, !8, !9, !10}
!3 = !{!"ProfileFormat", !"InstrProf"}
!4 = !{!"TotalCount", i64 98}
!5 = !{!"MaxCount", i64 48}
!6 = !{!"MaxInternalCount", i64 1}
!7 = !{!"MaxFunctionCount", i64 48}
!8 = !{!"NumCounts", i64 5}
!9 = !{!"NumFunctions", i64 2}
!10 = !{!"DetailedSummary", !11}
!11 = !{!12, !13, !14, !15, !16, !17, !17, !18, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27}
!12 = !{i32 10000, i64 0, i32 0}
!13 = !{i32 100000, i64 48, i32 1}
!14 = !{i32 200000, i64 48, i32 1}
!15 = !{i32 300000, i64 48, i32 1}
!16 = !{i32 400000, i64 48, i32 1}
!17 = !{i32 500000, i64 47, i32 2}
!18 = !{i32 600000, i64 47, i32 2}
!19 = !{i32 700000, i64 47, i32 2}
!20 = !{i32 800000, i64 47, i32 2}
!21 = !{i32 900000, i64 47, i32 2}
!22 = !{i32 950000, i64 47, i32 2}
!23 = !{i32 990000, i64 1, i32 5}
!24 = !{i32 999000, i64 1, i32 5}
!25 = !{i32 999900, i64 1, i32 5}
!26 = !{i32 999990, i64 1, i32 5}
!27 = !{i32 999999, i64 1, i32 5}
!28 = !{!"function_entry_count", i64 1}
!29 = !{!30, !30, i64 0}
!30 = !{!"long", !31, i64 0}
!31 = !{!"omnipotent char", !32, i64 0}
!32 = !{!"Simple C++ TBAA"}
!33 = !{!"branch_weights", i32 1, i32 0}
!34 = !{!35, !35, i64 0}
!35 = !{!"int", !31, i64 0}
!36 = !{!"branch_weights", i32 47, i32 1}
