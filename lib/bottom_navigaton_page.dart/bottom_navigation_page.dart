import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:second_have_to_do/page/main_page/diary_page.dart/diary_page.dart';
import 'package:second_have_to_do/page/main_page/todolist_page.dart/today_todolist_page/today_todolist_page.dart';
import 'package:second_have_to_do/page/main_page/todolist_page.dart/completionplan_todolist_page/completionplan_todolist_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => BottomNavigationPageState();
}

//바텀 네비게이션 관련
class BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0; // 선택된 페이지의 인덱스 넘버 초기화

  final List<Widget> _widgetOptions = <Widget>[
    const TodayTodoListPage(),
    const CompletionPlanPage(),
    const DiaryPage(),
    // const TodayTodoListPage(),
    const TodayTodoListPage(),
  ]; // 3개의 페이지를 연결할 예정이므로 3개의 페이지를 여기서 지정해준다. 탭 레이아웃은 3개.

  void _onItemTapped(int index) {
    // 탭을 클릭했을떄 지정한 페이지로 이동
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // bottom navigation 선언
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: const Icon(LineIcons.home),
            label: '왜',
          ),
          const BottomNavigationBarItem(
            icon: Icon(LineIcons.fontAwesomeFlag),
            label: '달성',
          ),
          const BottomNavigationBarItem(
            icon: Icon(LineIcons.bookOpen),
            label: '일기',
          ),
          const BottomNavigationBarItem(
            icon: Icon(LineIcons.user),
            label: '마이페이지',
          ),
        ],
        unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
        selectedLabelStyle: Theme.of(context).textTheme.bodySmall,
        currentIndex: _selectedIndex, // 지정 인덱스로 이동
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: false,
        showSelectedLabels: false,

        onTap: _onItemTapped, // 선언했던 onItemTapped
      ),
    );
  }
}
