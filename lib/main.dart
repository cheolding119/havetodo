import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottom_navigaton_page.dart/bottom_navigation_page.dart';
import 'main.theme.dart';

void main() async {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: setDefaultTheme(),

      // home: const LoginPage(), // 시작 페이지 설정
      //안녕
      home: const BottomNavigationPage(), // 시작 페이지 설정
    ),
  );
}
