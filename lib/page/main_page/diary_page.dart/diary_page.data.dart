import 'package:get/get.dart';

import 'package:second_have_to_do/classes/diary.dart';
import 'package:second_have_to_do/global_definition.dart';

class DiaryData extends GetxController {
  RxList<Diary> diaryItems = <Diary>[].obs;

  @override
  void onInit() {
    loadDiarys();
    super.onInit();
  }

  void loadDiarys() {
    Diary diary = Diary();

    diary.diaryId = -1;
    diary.diaryTitle.value = "오늘의 하루";
    diary.diaryContent.value =
        "오늘은 너무너무 짜증나는 하루였고 아무것도 하기가 싫습니다오늘은 너무너무 짜증나는 하루였고 아무것도 하기가 싫습니다오늘은 너무너무 짜증나는 하루였고 아무것도 하기가 싫습니다오늘은 너무너무 짜증나는 하루였고 아무것도 하기가 싫습니다오늘은 너무너무 짜증나는 하루였고 아무것도 하기가 싫습니다";
    diary.startTime.value = DateTime.now();
    diary.feels.add(FeelLevel.anger);
    diary.feels.add(FeelLevel.happiness);
    diary.feels.add(FeelLevel.sadness);

    diaryItems.add(diary);
  }
}
