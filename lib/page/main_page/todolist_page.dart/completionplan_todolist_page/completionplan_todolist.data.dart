import 'package:get/get.dart';
import 'package:second_have_to_do/classes/completion_plan.dart';

class CompletionPlanPageData extends GetxController {
  final RxList<CompletionPlan> planItems = <CompletionPlan>[].obs;
  final RxList<CompletionPlan> completedPlanItems = <CompletionPlan>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPlanDatas(1);
  }

  void loadPlanDatas(int memberId) async {
    planItems.add(CompletionPlan(completionPlanPlanId: 1));
    completedPlanItems.add(CompletionPlan(completionPlanPlanId: 1));
  }
}
