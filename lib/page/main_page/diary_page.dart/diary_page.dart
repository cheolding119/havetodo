import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:second_have_to_do/classes/diary.dart';
import 'package:second_have_to_do/global_definition.dart';
import 'package:second_have_to_do/page/main_page/diary_page.dart/addpage/add_diary_page.dart';

import 'diary_page.data.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => DiaryPageState();
}

class DiaryPageState extends State<DiaryPage> {
  DiaryData data = Get.put(DiaryData());
  //
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  highlightColor: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(
                    LineIcons.bars,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                const SizedBox(width: 10),
                const Text('일기')
              ],
            ),
            IconButton(
              highlightColor: Theme.of(context).colorScheme.secondary,
              onPressed: () {},
              icon: const Icon(LineIcons.verticalEllipsis,
                  color: Colors.white, size: 30),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          elevation: 20,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(
            Icons.add,
            size: 35,
          ),
          onPressed: () {
            Get.to(const AddDiaryPage());
            FocusManager.instance.primaryFocus!.unfocus();
          }),
      //본문 영역
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                _buildDiary(data.diaryItems[0]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiary(Diary diaryData) {
    Size screenSize = MediaQuery.of(context).size;
    RxBool fullScreen = false.obs;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: screenSize.width - 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.tertiary),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                diaryData.diaryTitle.value,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Row(
                children: [
                  Icon(LineIcons.horizontalEllipsis),
                  SizedBox(
                    width: 7,
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Flexible(
                child: Text(
                  diaryData.diaryContent.value,
                  maxLines: 3, // 최대 3줄까지만 표시
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFeelView(diaryData.feel.value),
              Row(
                children: [
                  Text(
                    DateFormat('yyyy-MM-dd HH:mm')
                        .format(diaryData.startTime.value),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 14),
                  ),
                  const SizedBox(width: 10)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  //감정의 표현 컴포넌트
  Widget _buildFeelView(FeelLevel feel) {
    //감정의 아이콘
    Rx<Icon> icon = const Icon(Icons.abc).obs;
    //감정 아이콘,텍스트 색상
    Rx<Color> feelColor = Colors.black.obs;
    //감정의 텍스트
    RxString feelText = ''.obs;

    if (feel == FeelLevel.love) {
      feelColor.value = Colors.pink;
      icon.value = const Icon(LineIcons.grinningFace, color: Colors.pink);
      feelText.value = "사랑";
    } else if (feel == FeelLevel.happiness) {
      feelColor.value = Colors.orange;
      icon.value =
          const Icon(LineIcons.laughFaceWithBeamingEyes, color: Colors.orange);
      feelText.value = "행복";
    } else if (feel == FeelLevel.calmness) {
      feelColor.value = Colors.yellow;
      icon.value =
          const Icon(LineIcons.rollingOnTheFloorLaughing, color: Colors.yellow);
      feelText.value = "평온";
    } else if (feel == FeelLevel.anger) {
      feelColor.value = Colors.red;
      icon.value = const Icon(LineIcons.angryFace, color: Colors.red);
      feelText.value = "화남";
    } else if (feel == FeelLevel.confusion) {
      feelColor.value = Colors.purple;
      icon.value = const Icon(LineIcons.flushedFace, color: Colors.purple);
      feelText.value = "혼란";
    } else if (feel == FeelLevel.sadness) {
      feelColor.value = Colors.blue;
      icon.value = const Icon(LineIcons.cryingFace, color: Colors.blue);
      feelText.value = "슬픔";
    }
    return Row(
      children: [
        icon.value,
        const SizedBox(width: 10),
        Text(
          feelText.value,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: feelColor.value, height: 1.2, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
