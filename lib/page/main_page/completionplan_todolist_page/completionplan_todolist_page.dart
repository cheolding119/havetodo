import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:second_have_to_do/classes/completion_plan.dart';
import 'package:second_have_to_do/classes/plan.dart';

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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.planItems.length,
                itemBuilder: (context, index) {
                  return _buildCompletionPlan(data.planItems[index]);
                },
              )
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
                      onTap: () {},
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(20)),
                          child: Image.asset('assets/images/whitelogo.png')),
                    ),
                    InkWell(
                      onTap: () {},
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