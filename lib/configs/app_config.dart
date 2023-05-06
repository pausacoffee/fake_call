import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  // Singleton ▼ ========================================
  static final AppConfig _singleton = AppConfig._();

  ///앱의 설정 값 : 언어, Theme etc
  factory AppConfig() {
    return _singleton;
  }

  AppConfig._();
  // Variable ▼ ========================================

  ///Theme 관련
  ///다크모드
  ///true : 다크
  ///false: 라이트
  ///기본 : 라이트
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode value) {
    _themeMode = value;

    saveThemeScale(value);
  }

  // Fucntion ▼ ========================================
  void init() async {
    try {
      bool result = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      result = prefs.getBool('theme_mode') ?? false;

      if (result) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    } catch (e) {
      Logger().d(e);
    }
  }

  ///theme mode 설정값 저장
  Future<void> saveThemeScale(ThemeMode value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (value) {
      case ThemeMode.dark:
        prefs.setBool('theme_mode', true);
        break;
      case ThemeMode.light:
        prefs.setBool('theme_mode', false);
        break;
      default:
        prefs.setBool('theme_mode', false);
        break;
    }

    return;
  }
}
