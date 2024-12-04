import 'package:flutter/material.dart';

ThemeData setDefaultTheme() {
  ColorScheme colorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF18171C),
    primaryFixed: Color(0xFF18171C),
    onPrimary: Colors.white,
    secondary: Color(0xFF1170F9),
    // secondary: Colors.yellow,
    tertiary: Color(0xFF2C2C34),
    onSecondary: Colors.white,
    error: Color(0xFFff5449),
    onError: Colors.white,
    surface: Color(0xFFF5F5F5),
    onSurface: Colors.black54,
  );

  return ThemeData(
      highlightColor: const Color(0xFF2C2C34),
      splashColor: const Color(0xFF2C2C34),
      cardColor: Colors.white,
      textTheme: const TextTheme(
        //부제목이며 헤드라인 스타일보다 작으며 더 짧고 중간 강조 텍스트에 사용 해야함 .
        titleLarge: TextStyle(
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w500,
          color: Color(0xFF777C89),
          fontSize: 22,
          letterSpacing: 0.0,
        ),
        titleMedium: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
            color: Color(0xFF777C89),
            fontSize: 16,
            letterSpacing: 0.0),
        titleSmall: TextStyle(
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w500,
          color: Color(0xFF777C89),
          fontSize: 12,
          letterSpacing: 0.0,
        ),

        // 본문 스타일은 더 긴 텍스트 구절에 사용됩니다. Material 의 기본 텍스트 스타일입니다.
        bodyLarge: TextStyle(
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontSize: 17,
          letterSpacing: 0.0,
        ),
        bodyMedium: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: 15,
            letterSpacing: 0.5,
            height: 0.0),
        bodySmall: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: 12,
            letterSpacing: 0.0),

        //구성 요소 내부의 텍스트 또는 캡션과 같은 콘텐츠 본문의 매우 작은 지원 텍스트와 같은 UI 영역에 사용되는 더 작고 실용적인 스타일입니다
        labelLarge: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: 14,
            letterSpacing: 0.0),
        labelMedium: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: 12,
            letterSpacing: 0.0),
        labelSmall: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: 11,
            letterSpacing: 0.0),

        //제목 스타일은 표시 스타일보다 작습니다. 작은 화면에서 짧고 강조되는 텍스트에 가장 적합합니다.
        headlineLarge: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 28,
            letterSpacing: 0.0,
            height: 1.3),
        headlineMedium: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 26,
            letterSpacing: 0.0,
            height: 1.3),
        headlineSmall: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 24,
            letterSpacing: 0.0,
            height: 1.3),

        //화면에서 가장 큰 텍스트인 디스플레이 스타일은 짧고 중요한 텍스트나 숫자용으로 예약되어 있습니다. 대형 화면에서 가장 잘 작동합니다.
        displayLarge: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 48,
            letterSpacing: 0.0,
            height: 1.3),
        displayMedium: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 40,
            letterSpacing: 0.0,
            height: 1.3),
        displaySmall: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 36,
            letterSpacing: 0.0,
            height: 1.3),
      ),
      colorScheme: colorScheme,
      cardTheme: CardTheme(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        elevation: 8.0,
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
            letterSpacing: 0.0,
            height: 1.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(8.0),
          ),
        ),
        backgroundColor: Color(0xFF23ead4),
        elevation: 0,
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: Color(0xFF00bdab),
        inactiveTrackColor: Color(0xFF8affed),
        thumbColor: Color(0xFF00bdab),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(colorScheme.primary))),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorColor: colorScheme.primary,
        labelStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 14,
            letterSpacing: 0.0),
      ),
      checkboxTheme: CheckboxThemeData(
        side: BorderSide(
            width: 1.5, color: colorScheme.tertiary, strokeAlign: -2),
      ));
}
