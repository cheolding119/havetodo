import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:second_have_to_do/classes/completion_plan.dart';
import 'package:second_have_to_do/classes/plan.dart';
import 'package:second_have_to_do/global_definition.dart';
import 'package:second_have_to_do/page/main_page/todolist_page.dart/today_todolist_page/today_todolist_page.data.dart';
import 'package:table_calendar/table_calendar.dart';

import 'completionplan_todolist.data.dart';

class CompletionPlanPage extends StatefulWidget {
  const CompletionPlanPage({super.key});

  @override
  State<CompletionPlanPage> createState() => CompletionPlanPageState();
}

class CompletionPlanPageState extends State<CompletionPlanPage> {
  CompletionPlanPageData data = Get.put(CompletionPlanPageData());
  TodayTodoListPageData todayData = Get.put(TodayTodoListPageData());
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
                  onPressed: () {
                    for (int i = 0;
                        i < data.completedPlanItems[0].plans.length;
                        i++) {
                      // print(data.completedPlanItems[0].plans[i].planContent);
                    }
                  },
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
                    int reversIndex = data.planItems.length - index - 1;
                    return _buildCompletionPlan(data.planItems[reversIndex]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //생성된 완료목표 컴포넌트
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
                      child: Obx(
                        () => Image.asset(
                          completionPlan.importanceLevel.value ==
                                  ImportanceLevel.highImportance
                              ? 'assets/images/redlogo.png'
                              : (completionPlan.importanceLevel.value ==
                                      ImportanceLevel.middleImportance
                                  ? 'assets/images/yellowlogo.png'
                                  : 'assets/images/greenlogo.png'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(completionPlan.planContent.value,
                        style: Theme.of(context).textTheme.titleMedium)
                  ],
                ),
                Row(
                  children: [
                    Obx(
                      () => Text(
                        completionPlan.remainingDays.value,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        completionPlanMenuBottomSheet(context, completionPlan);
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Icon(LineIcons.verticalEllipsis)),
                    )
                  ],
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
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: completionPlan.plans.length,
                    itemBuilder: (context, index) {
                      int reversIndex = completionPlan.plans.length - index - 1;
                      return _buildBasicPlan(
                          key: ValueKey(completionPlan.plans[reversIndex]),
                          todayPlanItem: completionPlan.plans[reversIndex],
                          completionPlan: completionPlan);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //완료목표를 이루기 위한 단일 계획
  Widget _buildBasicPlan(
      {Key? key,
      required Plan todayPlanItem,
      required CompletionPlan completionPlan}) {
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
              onPressed: (BuildContext context) async {
                completionPlan.plans.remove(todayPlanItem);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: LineIcons.trash,
            ),
            SlidableAction(
                onPressed: (BuildContext context) async {
                  todayPlanItem.important.value =
                      !todayPlanItem.important.value;
                },
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
                              ? (bool? value) async {
                                  todayPlanItem.checked.value =
                                      !todayPlanItem.checked.value;

                                  await Future.delayed(
                                      const Duration(milliseconds: 350));

                                  int planId = await data
                                      .deletePlan(todayPlanItem.getId());
                                  if (planId != 1) {
                                    completionPlan.plans.remove(todayPlanItem);
                                  }
                                }
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

  //완료목표를 수정할 수 있는 메뉴목록이 있는 바텀시트
  Future<dynamic> completionPlanMenuBottomSheet(
      BuildContext context, CompletionPlan completionPlan) {
    Size screenSize = MediaQuery.of(context).size;
    return showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.primary,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40), // 상단 라운딩 처리
        ),
      ),
      isScrollControlled: true, // 이 부분을 추가하여 스크롤이 가능하게 설정
      builder: (BuildContext context) {
        // 모달이 열릴 때 TextField에 자동으로 포커스를 맞춤

        return Container(
          padding: const EdgeInsets.all(10),
          height: 290, // 모달 높이 크기
          width: screenSize.width - 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), // 모달 좌상단 라운딩 처리
              topRight: Radius.circular(40), // 모달 우상단 라운딩 처리
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 150,
                height: 5,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(16)),
              ),
              const SizedBox(height: 5),
              buildBottomSheetMenuItem("목표 달성", () async {
                if (completionPlan.plans.isNotEmpty) {
                  for (int i = 0; i < completionPlan.plans.length; i++) {
                    await data.deletePlan(completionPlan.plans[i].planId);
                    await data.changeCpChecked(completionPlan.getId());
                  }
                }
                data.completedPlanItems.add(completionPlan);
                data.planItems.remove(completionPlan);
                showBasicToast('목표를 달성하였습니다');
                Get.back();
              }),
              _buildDividingLine(),
              //단일계획 부분
              buildBottomSheetMenuItem("단일 계획 추가하기", () {
                showCompletionOperationDialog(
                    context, completionPlan, OperationType.add);
              }),
              _buildDividingLine(),
              buildBottomSheetMenuItem("계획 수정하기", () {
                showCompletionOperationDialog(
                    context, completionPlan, OperationType.edit);
              }),
              _buildDividingLine(),
              buildBottomSheetMenuItem("계획 삭제하기", () async {
                int completionPlanId =
                    await data.deleteCompletionPlan(completionPlan.getId());
                if (completionPlanId != 1) {
                  data.planItems.remove(completionPlan);
                  showBasicToast('목표를 삭제하였습니다');
                  Get.back();
                } else {
                  showBasicToast('목표를 삭제에 실패 하였습니다');
                }
              }),
              _buildDividingLine(),
            ],
          ),
        );
      },
    );
  }

  //완료목표의 당일계획 추가,수정 하기
  void showCompletionOperationDialog(BuildContext context,
      CompletionPlan completionPlan, OperationType operationType) {
    TextEditingController textController = TextEditingController();
    Rx<DateTime> selectedEndDay = DateTime.now().obs;
    Rx<ImportanceLevel> selectImportant = ImportanceLevel.middleImportance.obs;
    if (operationType == OperationType.edit) {
      textController.text = completionPlan.planContent.value;
      selectedEndDay.value = completionPlan.endDateTime.value;
      selectImportant.value = completionPlan.importanceLevel.value;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Container(
          padding: const EdgeInsets.all(15),
          height: 195,
          width: 200,
          child: Column(
            children: [
              TextField(
                autofocus: true,
                controller: textController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelStyle: Theme.of(context).textTheme.bodySmall,
                  hintStyle: Theme.of(context).textTheme.titleMedium,
                  hintText: '작업을 입력하세요. . .',
                  border: InputBorder.none,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  operationType == OperationType.edit
                      ? Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showCalendarDialog(context, selectedEndDay);
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 5, 10),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
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
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 5, 10),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(
                                          'assets/images/whitelogo.png'))),
                            ),
                          ],
                        )
                      : Container(),
                  GestureDetector(
                    onTap: () async {
                      //단일계획을 추가할때 실행되는 로직
                      if (operationType == OperationType.add) {
                        Plan plan = Plan(planId: -1);
                        plan.planContent.value = textController.text;
                        int planId =
                            await data.createPlan(completionPlan.getId(), plan);
                        plan.setId(planId);
                        if (planId != -1) {
                          completionPlan.plans.add(plan);
                        } else {
                          showBasicToast('계획추가에 실패 하였습니다');
                        }
                        Get.back();
                        Get.back();
                        //dddddddd
                      } //완료목표를 수정할때 실행되는 로직
                      else if (operationType == OperationType.edit) {
                        bool pass = await data.changeCp(
                            completionPlan.getId(),
                            textController.text,
                            selectedEndDay.value,
                            selectImportant.value);
                        if (pass == true) {
                          completionPlan.planContent.value =
                              textController.text;
                          completionPlan.importanceLevel.value =
                              selectImportant.value;
                          completionPlan.endDateTime.value =
                              selectedEndDay.value;
                          final duration = completionPlan.endDateTime.value
                              .difference(completionPlan.startDateTime.value);
                          completionPlan.remainingDays.value =
                              'D-${duration.inDays}';
                        } else {
                          showBasicToast('완료목표 변경에 실패 하였습니다');
                        }
                        Get.back();
                        Get.back();
                      }
                    },
                    child: Container(
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(buttonRadius),
                          color: Theme.of(context).colorScheme.secondary),
                      child: const Icon(
                        LineIcons.check,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBottomSheetMenuItem(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: title == "계획 삭제하기"
                    ? Colors.red
                    : (title == "목표 달성")
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.white),
          ),
        ),
      ),
    );
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
                        onTap: () async {
                          RxList<Plan> plans = <Plan>[].obs;
                          CompletionPlan plan = CompletionPlan(
                              completionPlanPlanId: 1,
                              planContent: '완료 계획 내용'.obs,
                              checked: false.obs,
                              startDateTime: DateTime.now().obs,
                              endDateTime: DateTime.now()
                                  .add(const Duration(days: 7))
                                  .obs,
                              importanceLevel:
                                  ImportanceLevel.highImportance.obs,
                              plans: plans);
                          plan.planContent.value = todayPlanController.text;
                          plan.importanceLevel.value = selectImportant.value;
                          plan.endDateTime.value = selectedEndDay.value;
                          plan.startDateTime.value = DateTime.now();
                          final duration =
                              plan.endDateTime.value.difference(DateTime.now());
                          plan.remainingDays.value = 'D-${duration.inDays}';
                          //추가하는 부분
                          int completionPlanId =
                              await data.createCompletionPlan(1, plan);
                          if (completionPlanId != 1) {
                            data.planItems.add(plan);
                          }

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

  //가로 선 컨테이너 위젯
  Widget _buildDividingLine() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 1,
        width: double.infinity,
        color: Theme.of(context).colorScheme.tertiary);
  }
}
