import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'text.dart';

//TODO: TextStylePath 말고 Theme 사용하기

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  //textTheme: darkTextScheme,
  appBarTheme: darkAppBarTheme,
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  dividerColor: Colors.white24,
  fontFamily: GoogleFonts.openSans().fontFamily,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 2.0),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.white12, // 테두리 색상을 지정합니다.
    thickness: 1.0, // 테두리 두께를 지정합니다.
  ),
);

final lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  appBarTheme: lightAppBarTheme,
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  dividerColor: Colors.black26,
  fontFamily: GoogleFonts.openSans().fontFamily,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 2.0),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.black26, // 테두리 색상을 지정합니다.
    thickness: 1.0, // 테두리 두께를 지정합니다.
    indent: 12, //divider의 시작점을 얼마나 띄울것인지
    endIndent: 12, //divider의 끝점을 얼마나 띄울것인지
  ),
);

//const darkTextScheme = TextTheme();

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  background: Colors.black,
  onBackground: Colors.black87,
  error: Colors.red,
  onError: Colors.redAccent,
  primary: Colors.white,
  onPrimary: Colors.white12,
  secondary: Colors.white,
  onSecondary: Colors.white12,
  surface: Color.fromARGB(255, 245, 245, 245),
  onSurface: Colors.white12,
);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  background: Colors.white,
  onBackground: Colors.black87,
  error: Colors.red,
  onError: Colors.redAccent,
  primary: Colors.black,
  onPrimary: Colors.black,
  secondary: Colors.black,
  onSecondary: Colors.black,
  surface: Colors.black12,
  onSurface: Colors.black12,
);

AppBarTheme darkAppBarTheme = AppBarTheme(
  backgroundColor: Colors.transparent,
  titleTextStyle: TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  elevation: 0,
  toolbarTextStyle: TextStylePath.title18w800,
  iconTheme: const IconThemeData(color: Colors.white),
  actionsIconTheme: const IconThemeData(color: Colors.white),
);

AppBarTheme lightAppBarTheme = AppBarTheme(
  backgroundColor: Colors.transparent,
  titleTextStyle: TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  elevation: 0,
  toolbarTextStyle: TextStylePath.title18w800,
  iconTheme: const IconThemeData(color: Colors.black),
  actionsIconTheme: const IconThemeData(color: Colors.white),
);
