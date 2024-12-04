import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

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
              Container(
                padding: const EdgeInsets.all(10),
                // color: Colors.green,/
                width: screenSize.width - 30,
                // height: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            
                            SizedBox(
                                width: 25,
                                child:
                                    Image.asset('assets/images/redlogo.png')),
                            const SizedBox(width: 10),
                            Text('정보처리기사 합격하기',
                                style: Theme.of(context).textTheme.titleMedium)
                          ],
                        ),
                        Text(
                          'D-40',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        )
                      ],
                    ),
                    Slidable(
                        key: const ValueKey(0),

                        // endActionPane은 오른쪽이나 아래쪽에 있는 액션 패널입니다.
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              // 액션은 다른 것보다 크게 만들 수 있습니다.
                              flex: 2,
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
                        child: Container(
                          width: screenSize.width,
                          height: 130,
                          color: Colors.green,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
