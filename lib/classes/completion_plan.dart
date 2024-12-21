import 'package:get/get.dart';

import 'package:second_have_to_do/global_definition.dart';

import 'plan.dart';

//책 oneThing 에서 영감을 받은 완료목표
//쓸데없는 계획은 빼고 우선순위가 높은계획들만 추려서 넣어야 하는 조건이 있음 .
//완료 계획 클래스

class CompletionPlan {
  int completionPlanPlanId;

  //계획의 내용

  RxString planContent = ''.obs;

  // 중요도 체크

  Rx<ImportanceLevel> importanceLevel = ImportanceLevel.none.obs;

  // 시작날짜
  Rx<DateTime> startDateTime = DateTime.now().obs;

  // 종료날짜
  Rx<DateTime> endDateTime = DateTime.now().obs;

  //남은날짜를 볼수있는 String 클래스

  RxString remainingDays = ''.obs;

  //목표를 해결 하였는지 여부를 위한 Bool 클래스

  RxBool checked = false.obs;

  // //완료목표안에 들어갈 목표
  RxList<Plan> plans = <Plan>[].obs;

  //생성자

  int getId() {
    return completionPlanPlanId;
  }

  void setId(int id) {
    completionPlanPlanId = id;
  }

  //기본 생성자
  CompletionPlan(
      {required this.completionPlanPlanId,
      required this.planContent,
      required this.checked,
      required this.startDateTime,
      required this.endDateTime,
      required this.importanceLevel,
      required this.plans});

  factory CompletionPlan.fromJson(Map<String, dynamic> json) {
    return CompletionPlan(
      completionPlanPlanId: json['completionPlanId'] ?? 0,
      planContent: json['planContent']?.toString().obs ??
          ''.obs, // String -> RxString 변환
      checked: RxBool(json['checked'] ?? false), // Null-safe 처리
      startDateTime: DateTime.parse(json['startDate']).obs, // Rx<DateTime> 변환
      endDateTime: DateTime.parse(json['endDate']).obs, // Rx<DateTime> 변환
      importanceLevel:
          ImportanceLevel.values.byName(json['important']).obs, // Enum 변환
      plans: RxList<Plan>((json['plans'] as List)
          .map((planJson) => Plan.fromJson(planJson))
          .toList()),
    );
  }
}
