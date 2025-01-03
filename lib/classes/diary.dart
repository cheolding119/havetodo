import 'package:get/get.dart';
import 'package:second_have_to_do/global_definition.dart';

class Diary {
  //일기의 고유의 ID
  int diaryId = -1;

  //일기 제목
  RxString diaryTitle = ''.obs;

  //일기 내용
  RxString diaryContent = ''.obs;

  //일기를 작성한 날짜
  Rx<DateTime> startTime = DateTime.now().obs;

  Rx<FeelLevel> feel = FeelLevel.happiness.obs;

  int getId() {
    return diaryId;
  }

  void setId(int id) {
    diaryId = id;
  }
}
