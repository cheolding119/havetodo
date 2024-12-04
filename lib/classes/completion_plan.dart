import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:second_have_to_do/classes/rx_bool_converter.dart';
import 'package:second_have_to_do/classes/rx_string_converter.dart';
import 'package:second_have_to_do/global_definition.dart';

import 'plan.dart';
part 'completion_plan.g.dart';

//책 oneThing 에서 영감을 받은 완료목표
//쓸데없는 계획은 빼고 우선순위가 높은계획들만 추려서 넣어야 하는 조건이 있음 .
//완료 계획 클래스
@JsonSerializable()
class CompletionPlan {
  int completionPlanPlanId;

  //계획의 내용
  @RxStringConverter()
  RxString planContent = ''.obs;

  //중요도 체크
  ImportanceLevel importanceLevel = ImportanceLevel.none;

  //시작날짜를 넣기위한 클래스
  DateTime startDateTime = DateTime.now();

  //종료날짜를 정하기 위한 클래스
  DateTime endDateTime = DateTime.now();

  //남은날짜를 볼수있는 String 클래스
  @RxStringConverter()
  RxString remainingDays = ''.obs;

  //목표를 해결 하였는지 여부를 위한 Bool 클래스
  @RxBoolConverter()
  RxBool checked = false.obs;

  // //완료목표안에 들어갈 목표
  List<Plan> plans = List.empty();

  //생성자
  CompletionPlan({required this.completionPlanPlanId});

  int getId() {
    return completionPlanPlanId;
  }

  void setId(int id) {
    completionPlanPlanId = id;
  }

  // Json 데이터를 가져오기
  factory CompletionPlan.fromJson(Map<String, dynamic> json) =>
      _$CompletionPlanFromJson(json);

  // Plan 객체를 Json 형태로 변환
  Map<String, dynamic> toJson() => _$CompletionPlanToJson(this);
}
