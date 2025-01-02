import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:second_have_to_do/classes/diary.dart';
import 'package:second_have_to_do/global_definition.dart';

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
              const Row(
                children: [],
              ),
              Row(
                children: [
                  Text(
                    DateFormat('yyyy-MM-dd').format(diaryData.startTime.value),
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

  Widget _buildFeelContainer(FeelLevel feelLevel) {
    return Container();
  }
}
