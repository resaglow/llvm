; ModuleID = 'main-gened-optgen.bc'
source_filename = "main.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

$__llvm_profile_raw_version = comdat any

$__llvm_profile_filename = comdat any

@a = local_unnamed_addr global [67108864 x i32] zeroinitializer, align 16
@b = local_unnamed_addr global [67108864 x i32] zeroinitializer, align 16
@c = local_unnamed_addr global [67108864 x i32] zeroinitializer, align 16
@.str = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@__llvm_profile_raw_version = constant i64 72057594037927940, comdat
@__profn_main = private constant [4 x i8] c"main"
@__profc_main = private global [2 x i64] zeroinitializer, section "__llvm_prf_cnts", align 8
@__profd_main = private global { i64, i64, i64*, i8*, i8*, i32, [1 x i16] } { i64 -2624081020897602054, i64 29212902728, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc_main, i32 0, i32 0), i8* bitcast (i32 ()* @main to i8*), i8* null, i32 2, [1 x i16] zeroinitializer }, section "__llvm_prf_data", align 8
@__llvm_prf_nm = private constant [14 x i8] c"\04\0Cx\DA\CBM\CC\CC\03\00\04\1B\01\A6", section "__llvm_prf_names"
@__llvm_profile_filename = constant [19 x i8] c"default_%m.profraw\00", comdat
@__llvm_profile_raw_version.1 = constant i64 72057594037927940, comdat($__llvm_profile_raw_version)
@__profn_main.2 = private constant [4 x i8] c"main"
@__profc_main.2 = private global [3 x i64] zeroinitializer, section "__llvm_prf_cnts", align 8
@__profd_main.2 = private global { i64, i64, i64*, i8*, i8*, i32, [1 x i16] } { i64 -2624081020897602054, i64 35342767269, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @__profc_main.2, i32 0, i32 0), i8* bitcast (i32 ()* @main to i8*), i8* null, i32 3, [1 x i16] zeroinitializer }, section "__llvm_prf_data", align 8
@__llvm_prf_nm.3 = private constant [14 x i8] c"\04\0Cx\DA\CBM\CC\CC\03\00\04\1B\01\A6", section "__llvm_prf_names"
@llvm.used = appending global [4 x i8*] [i8* bitcast ({ i64, i64, i64*, i8*, i8*, i32, [1 x i16] }* @__profd_main to i8*), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @__llvm_prf_nm, i32 0, i32 0), i8* bitcast ({ i64, i64, i64*, i8*, i8*, i32, [1 x i16] }* @__profd_main.2 to i8*), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @__llvm_prf_nm.3, i32 0, i32 0)], section "llvm.metadata"

; Function Attrs: norecurse nounwind uwtable
define i32 @main() local_unnamed_addr #0 {
entry:
  %n = alloca i64, align 8
  %0 = bitcast i64* %n to i8*
  call void @llvm.lifetime.start(i64 8, i8* nonnull %0) #3
  %call = call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i64* nonnull %n)
  %1 = load i64, i64* %n, align 8, !tbaa !1
  %cmp11 = icmp sgt i64 %1, 0
  br i1 %cmp11, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %2 = load i64, i64* %n, align 8, !tbaa !1
  %.promoted = load i64, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc_main, i64 0, i64 0), align 8
  br label %for.body

for.cond.for.cond.cleanup_crit_edge:              ; preds = %for.body
  %pgocount1 = load i64, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @__profc_main.2, i64 0, i64 2)
  %3 = add i64 %pgocount1, 1
  store i64 %3, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @__profc_main.2, i64 0, i64 2)
  store i64 %7, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc_main, i64 0, i64 0), align 8
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.for.cond.cleanup_crit_edge, %entry
  %pgocount2 = load i64, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @__profc_main.2, i64 0, i64 1)
  %4 = add i64 %pgocount2, 1
  store i64 %4, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @__profc_main.2, i64 0, i64 1)
  %pgocount = load i64, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc_main, i64 0, i64 1), align 8
  %5 = add i64 %pgocount, 1
  store i64 %5, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc_main, i64 0, i64 1), align 8
  call void @llvm.lifetime.end(i64 8, i8* nonnull %0) #3
  ret i32 0

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %for.body.for.body_crit_edge ]
  %6 = phi i64 [ %.promoted, %for.body.lr.ph ], [ %7, %for.body.for.body_crit_edge ]
  %7 = add i64 %6, 1
  %arrayidx = getelementptr inbounds [67108864 x i32], [67108864 x i32]* @b, i64 0, i64 %indvars.iv
  %8 = load i32, i32* %arrayidx, align 4, !tbaa !5
  %arrayidx2 = getelementptr inbounds [67108864 x i32], [67108864 x i32]* @c, i64 0, i64 %indvars.iv
  %9 = load i32, i32* %arrayidx2, align 4, !tbaa !5
  %add = add nsw i32 %9, %8
  %arrayidx4 = getelementptr inbounds [67108864 x i32], [67108864 x i32]* @a, i64 0, i64 %indvars.iv
  store i32 %add, i32* %arrayidx4, align 4, !tbaa !5
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %cmp = icmp slt i64 %indvars.iv.next, %2
  br i1 %cmp, label %for.body.for.body_crit_edge, label %for.cond.for.cond.cleanup_crit_edge

for.body.for.body_crit_edge:                      ; preds = %for.body
  %pgocount3 = load i64, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @__profc_main.2, i64 0, i64 0)
  %10 = add i64 %pgocount3, 1
  store i64 %10, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @__profc_main.2, i64 0, i64 0)
  br label %for.body
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare i32 @scanf(i8* nocapture readonly, ...) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.instrprof.increment(i8*, i64, i32, i32) #3

attributes #0 = { norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1 (tags/RELEASE_400/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"long", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C++ TBAA"}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !3, i64 0}
