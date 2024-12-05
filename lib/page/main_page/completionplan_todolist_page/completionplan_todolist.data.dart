import 'package:get/get.dart';
import 'package:second_have_to_do/classes/completion_plan.dart';
import 'package:second_have_to_do/classes/plan.dart';
import 'package:second_have_to_do/global_definition.dart';

class CompletionPlanPageData extends GetxController {
  final RxList<CompletionPlan> planItems = <CompletionPlan>[].obs;
  final RxList<CompletionPlan> completedPlanItems = <CompletionPlan>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPlanDatas(1);
  }

  void loadPlanDatas(int memberId) async {
    completedPlanItems.add(CompletionPlan(completionPlanPlanId: 1));
    for (int i = 0; i < 3; i++) {
      CompletionPlan completionPlan = CompletionPlan(completionPlanPlanId: i);
      completionPlan.planContent.value = '정보처리기사 합격하기';
      completionPlan.importanceLevel = ImportanceLevel.highImportance;
      for (int j = 0; j < 3; j++) {
        Plan plan = Plan(planId: j);
        plan.planContent.value = "$j";
        completionPlan.plans.add(plan);
      }
      planItems.add(completionPlan);
    }
  }
}
