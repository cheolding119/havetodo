import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:second_have_to_do/classes/completion_plan.dart';
import 'package:second_have_to_do/classes/plan.dart';
import 'package:second_have_to_do/global_definition.dart';
import 'package:table_calendar/table_calendar.dart';

import 'completionplan_todolist.data.dart';

class CompletionPlanPage extends StatefulWidget {
  const CompletionPlanPage({super.key});

  @override
  State<CompletionPlanPage> createState() => CompletionPlanPageState();
}

class CompletionPlanPageState extends State<CompletionPlanPage> {
  CompletionPlanPageData data = Get.put(CompletionPlanPageData());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          elevation: 20,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(
            Icons.add,
            size: 35,
          ),
          onPressed: () {
            addTodoPlan(context);
            FocusManager.instance.primaryFocus!.unfocus();
          }),
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
                const Text('완료 목표')
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => data.planItems.isEmpty
                    ? SizedBox(
                        width: screenSize.width,
                        height: screenSize.height - 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(LineIcons.fontAwesomeFlag,
                                size: 60, color: Colors.blue),
                            const SizedBox(height: 5),
                            Text('계획을 추가해 보세요 !',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.blue)),
                          ],
                        ),
                      )
                    : Container(),
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.planItems.length,
                  itemBuilder: (context, index) {
                    return _buildCompletionPlan(data.planItems[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //완료목표 로직
  Widget _buildCompletionPlan(CompletionPlan completionPlan) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(10),
      width: screenSize.width - 30,
      child: Column(
        children: [
          SizedBox(
            width: screenSize.width - 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                        width: 25,
                        child: Image.asset('assets/images/redlogo.png')),
                    const SizedBox(width: 10),
                    Text(completionPlan.planContent.value,
                        style: Theme.of(context).textTheme.titleMedium)
                  ],
                ),
                Text(
                  'D-40',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: screenSize.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: Theme.of(context).colorScheme.tertiary,
            ),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: completionPlan.plans.length,
                  itemBuilder: (context, index) {
                    return _buildBasicPlan(
                        key: ValueKey(completionPlan.plans[index]),
                        todayPlanItem: completionPlan.plans[index]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //완료목표를 이루기 위한 단일 계획
  Widget _buildBasicPlan({Key? key, required Plan todayPlanItem}) {
    Size screenSize = MediaQuery.of(context).size;
    return Slidable(
        key: key,
        // endActionPane은 오른쪽이나 아래쪽에 있는 액션 패널입니다.
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              // 액션은 다른 것보다 크게 만들 수 있습니다.
              flex: 1,
              onPressed: (BuildContext context) async {},
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: LineIcons.trash,
            ),
            SlidableAction(
                onPressed: (BuildContext context) async {},
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                icon: LineIcons.bookmark),
          ],
        ),
        child: SizedBox(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            width: screenSize.width - 30,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: Theme.of(context).colorScheme.tertiary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      () => SizedBox(
                        width: 20,
                        height: 30,
                        child: Checkbox(
                          side: const BorderSide(
                            width: 1.5,
                            color: Color(0xFF5D5D5D),
                          ),
                          activeColor: const Color(0xFF5D5D5D),
                          value: todayPlanItem.checked.value,
                          onChanged: todayPlanItem.checked.value == false
                              ? (bool? value) async {}
                              : (null),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        padding: const EdgeInsets.all(5),
                        width: screenSize.width - 150,
                        child: todayPlanItem.planContent.value != ""
                            ? Text(todayPlanItem.planContent.value)
                            : Text(
                                "내용 없음",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.grey),
                              ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => todayPlanItem.important.value == true
                      ? const Icon(
                          LineIcons.bookmark,
                          color: Colors.yellow,
                        )
                      : Container(),
                )
              ],
            ),
          ),
        ));
  }

  //완료목표 추가하는 로직
  Future<dynamic> addTodoPlan(BuildContext context) {
    TextEditingController todayPlanController = TextEditingController();
    Rx<DateTime> selectedEndDay = DateTime.now().obs;
    Rx<ImportanceLevel> selectImportant = ImportanceLevel.middleImportance.obs;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 이 부분을 추가하여 스크롤이 가능하게 설정
      builder: (BuildContext context) {
        // 모달이 열릴 때 TextField에 자동으로 포커스를 맞춤

        return Padding(
            padding: MediaQuery.of(context).viewInsets, // 키보드가 올라왔을 때의 패딩을 추가
            child: Container(
              padding: const EdgeInsets.all(5),
              height: 150, // 모달 높이 크기
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), // 모달 좌상단 라운딩 처리
                  topRight: Radius.circular(5), // 모달 우상단 라운딩 처리
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(LineIcons.arrowLeft),
                      ),
                      Row(
                        children: [
                          DateFormat('yyyy-MM-dd').format(DateTime.now()) ==
                                  DateFormat('yyyy-MM-dd')
                                      .format(selectedEndDay.value)
                              ? Container()
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  child: Text(
                                    DateFormat('yyyy-MM-dd')
                                        .format(selectedEndDay.value),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                          const SizedBox(width: 15),
                          Obx(
                            () => SizedBox(
                              height: 25,
                              width: 25,
                              child: selectImportant.value ==
                                      ImportanceLevel.highImportance
                                  ? Image.asset('assets/images/redlogo.png')
                                  : (selectImportant.value ==
                                          ImportanceLevel.middleImportance)
                                      ? Image.asset(
                                          'assets/images/yellowlogo.png')
                                      : Image.asset(
                                          'assets/images/greenlogo.png'),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Obx(
                            () => Text(
                                selectImportant.value ==
                                        ImportanceLevel.highImportance
                                    ? '중요'
                                    : (selectImportant.value ==
                                            ImportanceLevel.middleImportance)
                                        ? '보통'
                                        : '조금중요',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.white)),
                          ),
                          const SizedBox(width: 15),
                        ],
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.bodySmall,
                          hintStyle: Theme.of(context).textTheme.titleMedium,
                          hintText: '작업을 입력하세요. . .',
                          border: InputBorder.none,
                        ),
                        autofocus: true,
                        controller: todayPlanController,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          data.selectEndDateTime.value = DateTime.now();
                          FocusScope.of(context).unfocus();
                          showCalendarDialog(context, selectedEndDay);
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Icon(LineIcons.calendar),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showImportantDialog(context, selectImportant);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(7),
                            margin: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(20)),
                            child: SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.asset(
                                    'assets/images/whitelogo.png'))),
                      ),
                      InkWell(
                        onTap: () {
                          CompletionPlan plan =
                              CompletionPlan(completionPlanPlanId: 1);
                          plan.planContent.value = todayPlanController.text;
                          plan.importanceLevel = selectImportant.value;
                          plan.endDateTime = selectedEndDay.value;
                          plan.startDateTime = DateTime.now();
                          final duration =
                              plan.endDateTime.difference(plan.startDateTime);
                          plan.remainingDays.value = '${duration.inDays}';
                          data.planItems.add(plan);
                          Get.back();
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Icon(Icons.check),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ));
      },
    ).then((value) {
      // 바텀시트가 닫힌 뒤 실행되는 로직
      Future.delayed(const Duration(milliseconds: 500), () {
        selectImportant.value = ImportanceLevel.highImportance;
        print("1초 후 중요도 설정 완료.");
      });
    });
  }

  //완료목표 지정날짜를 선택하기 위한 달력
  void showCalendarDialog(BuildContext context, Rx<DateTime> selectedEndDay) {
    Rx<DateTime> selectedDay = DateTime.now().obs;
    Rx<DateTime> focusedDay = DateTime.now().obs;
    //선택된 날짜
    selectedEndDay.value = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: SizedBox(
          height: 400,
          width: 300,
          child: Column(
            children: [
              Obx(
                () => TableCalendar(
                  //헤더 스타일 지정
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    titleTextFormatter: (date, locale) =>
                        DateFormat.yMMMMd(locale).format(date),
                    formatButtonVisible: false,
                    titleTextStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                    headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
                    leftChevronIcon: const Icon(
                      Icons.arrow_left,
                      size: 40.0,
                    ),
                    rightChevronIcon: const Icon(
                      Icons.arrow_right,
                      size: 40.0,
                    ),
                  ),
                  //캘린더 스타일 지정
                  calendarStyle: CalendarStyle(
                      todayTextStyle: Theme.of(context).textTheme.bodySmall!,
                      weekendTextStyle: Theme.of(context).textTheme.bodySmall!,
                      selectedTextStyle: Theme.of(context).textTheme.bodySmall!,
                      selectedDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        shape: BoxShape.circle,
                      )),

                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),

                  locale: 'ko-KR',
                  focusedDay: focusedDay.value,
                  onDaySelected: (DateTime selectedDay2, DateTime focusedDay2) {
                    // 선택된 날짜의 상태를 갱신합니다.
                    setState(() {
                      selectedDay.value = selectedDay2;
                      focusedDay.value = focusedDay2;
                    });
                  },

                  selectedDayPredicate: (DateTime day) {
                    // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                    return isSameDay(selectedDay.value, day);
                  },
                ),
                //
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      selectedEndDay.value = selectedDay.value;
                      Get.back();
                    },
                    child: Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).colorScheme.secondary),
                      child: const Icon(
                        LineIcons.check,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //중요도를 선택하는 다이얼로그
  void showImportantDialog(
      BuildContext context, Rx<ImportanceLevel> selectImportant) {
    //선택된 중요도

    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
            ),
            height: 300,
            width: 20,
            child: Column(
              children: [
                _buildImportantCheckList(
                    Image.asset('assets/images/redlogo.png'),
                    '중요',
                    ImportanceLevel.highImportance, () {
                  selectImportant.value = ImportanceLevel.highImportance;
                }, selectImportant),
                _buildImportantCheckList(
                    Image.asset('assets/images/yellowlogo.png'),
                    '보통',
                    ImportanceLevel.middleImportance, () {
                  selectImportant.value = ImportanceLevel.middleImportance;
                }, selectImportant),
                _buildImportantCheckList(
                    Image.asset('assets/images/greenlogo.png'),
                    '조금 중요',
                    ImportanceLevel.lowImportance, () {
                  selectImportant.value = ImportanceLevel.lowImportance;
                }, selectImportant),
              ],
            ),
          )),
    );
  }

  //중요도 체크 컴포넌트
  Widget _buildImportantCheckList(
      Image image,
      String content,
      ImportanceLevel importantLevel,
      VoidCallback onTap,
      Rx<ImportanceLevel> selectImportant) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => Container(
          margin: const EdgeInsets.symmetric(vertical: 3),
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            color: selectImportant.value == importantLevel
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 30, height: 30, child: image),
              const SizedBox(width: 30),
              Text(content,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  void showBasicToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
