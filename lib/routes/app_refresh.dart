import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/app_config.dart';

class AppRefresh with ChangeNotifier {
  // Singleton ▼ ========================================
  static final AppRefresh _singleton = AppRefresh._();

  ///router redirect listener : permission, auth, Data 초기화, 앱 설정 등..
  factory AppRefresh() {
    return _singleton;
  }

  AppRefresh._();

  // Variable ▼ ========================================
  ///앱에 대한 init 여부
  bool _initialized = false;
  bool get initialized => _initialized;

  ///허용 여부(permission_service)
  bool _permissionState = false;
  bool get permitted => _permissionState;
  set permitted(bool value) {
    _permissionState = value;

    notifyListeners();
  }

  ///Theme 관련
  ///다크모드
  ///true : 다크
  ///false: 라이트
  ///기본 : 라이트
  ThemeMode get themeMode => AppConfig().themeMode;

  set themeMode(ThemeMode value) {
    AppConfig().themeMode = value;

    notifyListeners();
  }

  //Fucntion  ▼ ========================================
  ///onAppStart가 완료되면 route redirect됨.
  Future<void> onAppStart() async {
    await initialize();

    await Future.delayed(const Duration(seconds: 2));

    _initialized = true;

    notifyListeners();
  }

  /// 앱을 시작하기 위해 필요한 데이터와 세팅 로딩(오래 걸리는 것)
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    // 최초 permission 체크 한번
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _permissionState = prefs.getBool('initialize_permission') ?? false;

    // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
    WidgetsFlutterBinding.ensureInitialized();
  }
}
