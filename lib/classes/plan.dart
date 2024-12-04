import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:second_have_to_do/classes/rx_string_converter.dart';
import 'package:second_have_to_do/classes/rx_bool_converter.dart';
part 'plan.g.dart';

@JsonSerializable()
class Plan {
  int planId;

  @RxStringConverter()
  RxString planContent = ''.obs;
  //중요도 체크
  @RxBoolConverter()
  RxBool important = false.obs;
  //체크박스 체크
  @RxBoolConverter()
  RxBool checked = false.obs;

  //시작날짜를 넣기위한 클래스
  DateTime startDate = DateTime.now();

  //종료날짜를 정하기 위한 클래스
  DateTime endDate = DateTime.now();

  //셍성자
  Plan({required this.planId});

  int getId() {
    return planId;
  }

  void setId(int id) {
    planId = id;
  }

  // Json 데이터를 가져오기
  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  // Plan 객체를 Json 형태로 변환
  Map<String, dynamic> toJson() => _$PlanToJson(this);
}
