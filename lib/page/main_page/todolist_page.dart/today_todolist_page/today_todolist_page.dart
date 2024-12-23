import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:second_have_to_do/classes/plan.dart';

import 'today_todolist_page.data.dart';

class TodayTodoListPage extends StatefulWidget {
  const TodayTodoListPage({super.key});

  @override
  State<TodayTodoListPage> createState() => TodayTodoListPageState();
}

class TodayTodoListPageState extends State<TodayTodoListPage> {
  TodayTodoListPageData data = Get.put(TodayTodoListPageData());
  //초기값을 받아오기 위한 값
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          elevation: 20,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(
            Icons.add,
            size: 35,
          ),
          onPressed: () {
            RxBool bookMarkChecked = false.obs;
            //바텀 시트 관련 메서드
            addTodoPlan(context, bookMarkChecked);
            FocusManager.instance.primaryFocus!.unfocus();
          }),

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
                  onPressed: () {
                    if (data.planItems[0].planContent.value == "") {
                      print("같음");
                      _showBasicToast("같음");
                    } else {
                      print("다름");
                      _showBasicToast("같음");
                    }
                  },
                ),
                const SizedBox(width: 10),
                const Text('투두 리스트')
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

      //body 영역
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
            child: Column(
          children: [
            //오늘 추가한 리스트
            Obx(
              () => data.planItems.isEmpty && data.completedPlanItems.isEmpty
                  ? SizedBox(
                      height: screenSize.height - 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(LineIcons.comments,
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
            //추가한 계획들의 목록
            _buildTodayList(),
            Obx(
              () => data.planItems.isEmpty
                  ? Container()
                  : const SizedBox(height: 15),
            ),
            //완료한 계획들의 목록
            _buildCompletedTodayList(),
          ],
        )),
      ),
    );
  }

  //추가한 계획 목록
  Widget _buildTodayList() {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 25),
            Obx(
              () => data.planItems.isNotEmpty
                  ? Text('오늘',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white))
                  : Container(),
            ),
          ],
        ),
        //TodayPlanList 부분
        Container(
          width: screenSize.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Theme.of(context).colorScheme.tertiary,
          ),
          margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: Column(
            children: [
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.planItems.length,
                  itemBuilder: (context, index) {
                    int reversedIndex = data.planItems.length - index - 1;
                    return _buildTodayPlan(
                        key: ValueKey(data.planItems[reversedIndex]),
                        todayPlanItem: data.planItems[reversedIndex]);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //추가된  계획 (단일)
  Widget _buildTodayPlan({Key? key, required Plan todayPlanItem}) {
    Size screenSize = MediaQuery.of(context).size;

    return Slidable(
      key: key ?? const ValueKey(0),

      // endActionPane은 오른쪽이나 아래쪽에 있는 액션 패널입니다.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // 액션은 다른 것보다 크게 만들 수 있습니다.
            flex: 1,
            onPressed: (BuildContext context) async {
              int planId = await data.deletePlan(todayPlanItem.planId);
              if (planId != -1) {
                data.planItems.remove(todayPlanItem);
                _showBasicToast("삭제 되었습니다");
              } else {
                _showBasicToast("삭제에 실패하였습니다");
              }
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: LineIcons.trash,
          ),
          SlidableAction(
              onPressed: (BuildContext context) async {
                todayPlanItem.important.value =
                    await data.changeImportant(todayPlanItem.planId);
              },
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              icon: LineIcons.bookmark),
        ],
      ),

      child: SizedBox(
        width: screenSize.width,
        height: 47,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Theme.of(context).colorScheme.tertiary,
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => SizedBox(
                      width: 30,
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
                                if (value == true) {
                                  todayPlanItem.checked.value = await data
                                      .changeChecked(todayPlanItem.planId);

                                  // 0.35초 지연 후 완료 리스트에 추가
                                  await Future.delayed(
                                      const Duration(milliseconds: 350));

                                  data.completedPlanItems.add(todayPlanItem);
                                  data.planItems.remove(todayPlanItem);
                                }
                              }
                            : (null),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      updatePlan(context, todayPlanItem);
                    },
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.all(5),
                      width: screenSize.width - 130,
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
      ),
    );
  }

  //완료한 계획 목록
  Widget _buildCompletedTodayList() {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 25),
            Obx(() => data.completedPlanItems.isNotEmpty
                ? Text(
                    "완료",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  )
                : Container())
          ],
        ),
        //완료한 PlanList 부분
        Container(
          width: screenSize.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Theme.of(context).colorScheme.tertiary,
          ),
          margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: Column(
            children: [
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.completedPlanItems.length,
                  itemBuilder: (context, index) {
                    int reversedIndex =
                        data.completedPlanItems.length - index - 1;
                    return _buildCompletedTodayPlan(
                        completedPlanItem:
                            data.completedPlanItems[reversedIndex]);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //완료한 계획 (단일)
  Widget _buildCompletedTodayPlan({required Plan completedPlanItem}) {
    Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      width: screenSize.width,
      height: 45,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: Theme.of(context).colorScheme.tertiary,
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Obx(
                    () => Checkbox(
                      side: const BorderSide(
                          width: 1.5, color: Color(0xFF5D5D5D)),
                      activeColor: const Color(0xFF5D5D5D),
                      value: completedPlanItem.checked.value,
                      onChanged: completedPlanItem.checked.value == true
                          ? (bool? value) async {
                              if (value == false) {
                                // 체크박스 상태를 먼저 업데이트
                                completedPlanItem.checked.value = await data
                                    .changeChecked(completedPlanItem.planId);

                                // 0.35초 지연 후 완료 리스트에 추가
                                await Future.delayed(
                                    const Duration(milliseconds: 350));
                                data.planItems.add(completedPlanItem);
                                data.completedPlanItems
                                    .remove(completedPlanItem);
                              } else {
                                // 체크박스 상태 업데이트
                                completedPlanItem.checked.value = value!;
                              }
                            }
                          : (null),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Obx(
                  () => completedPlanItem.planContent.value != ""
                      ? Text(
                          completedPlanItem.planContent.value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      : Text(
                          "내용 없음",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey),
                        ),
                )
              ],
            ),
            //여기서 부터 해야함
            Obx(
              () => completedPlanItem.important.value == true
                  ? const Icon(
                      LineIcons.bookmark,
                      color: Colors.yellow,
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }

  //계획을 수정할 때의 바텀시트 로직
  Future<dynamic> updatePlan(BuildContext context, Plan todayPlan) {
    TextEditingController todayPlanController = TextEditingController();
    todayPlanController.text = todayPlan.planContent.value;

    RxBool importantChecked = false.obs;
    return showModalBottomSheet(
      isDismissible: true,
      context: context,
      isScrollControlled: true, // 이 부분을 추가하여 스크롤이 가능하게 설정
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets, // 키보드가 올라왔을 때의 패딩을 추가
          child: Container(
            padding: const EdgeInsets.all(5),
            height: 200, // 모달 높이 크기
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), // 모달 좌상단 라운딩 처리
                topRight: Radius.circular(25), // 모달 우상단 라운딩 처리
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(LineIcons.arrowLeft, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.grey),
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
                    Obx(
                      () => InkWell(
                        onTap: () {
                          importantChecked.value = !importantChecked.value;
                        },
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(Icons.bookmark_sharp,
                                color: importantChecked.value == true
                                    ? Colors.yellow
                                    : Colors.white)),
                      ),
                    ),
                    //수정하고 있는 부분
                    InkWell(
                      onTap: () async {
                        RxString contentUpdate = "".obs;
                        contentUpdate.value = todayPlanController.text;
                        todayPlan = await data.changePlan(todayPlan,
                            contentUpdate.value, importantChecked.value);
                        todayPlan.planContent.value = contentUpdate.value;

                        Get.back();
                        _showBasicToast("수정 되었습니다");
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
          ),
        );
      },
    );
  }

  //계획 추가 바텀시트 관련 메서드
  Future<dynamic> addTodoPlan(BuildContext context, RxBool bookMarkChecked) {
    TextEditingController todayPlanController = TextEditingController();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 이 부분을 추가하여 스크롤이 가능하게 설정
      builder: (BuildContext context) {
        // 모달이 열릴 때 TextField에 자동으로 포커스를 맞춤

        return Padding(
          padding: MediaQuery.of(context).viewInsets, // 키보드가 올라왔을 때의 패딩을 추가
          child: Container(
            padding: const EdgeInsets.all(5),
            height: 200, // 모달 높이 크기
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
                GestureDetector(
                  child: const Icon(LineIcons.arrowLeft),
                ),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                        bookMarkChecked.value = !bookMarkChecked.value;
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(20)),
                        child: Obx(() => Icon(
                              Icons.bookmark,
                              color: bookMarkChecked.value == true
                                  ? Colors.yellow
                                  : Colors.white,
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (todayPlanController.text.isEmpty) {
                          _showBasicToast("작업을 입력해 주세요");
                        } else {
                          Plan todayPlan = Plan(planId: -1);
                          todayPlan.planContent.value =
                              todayPlanController.text;
                          todayPlan.important.value = bookMarkChecked.value;
                          todayPlan.checked.value = false;
                          //계획을 추가하는 버튼
                          todayPlan.planId =
                              await data.createPlan(data.memberId, todayPlan);

                          data.planItems.add(todayPlan);

                          todayPlanController.text = '';
                          Get.back();
                          Get.back();
                        }
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
          ),
        );
      },
    );
  }

  void _showBasicToast(String msg) {
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
