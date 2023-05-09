import 'dart:io';

import 'package:fake_call/routes/app_refresh.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/text.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late AppRefresh _appRefresh;

  /// 현재 시간
  DateTime currentDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      '가짜 전화',
      textAlign: TextAlign.center,
      style: TextStylePath.title56w800.copyWith(
        letterSpacing: -5,
      ),
    );

    title = title
        .animate() //onPlay: (controller) => controller.repeat(reverse: true)
        .fadeIn(curve: Curves.easeIn, duration: 2.seconds)
        .saturate(duration: 2.seconds)
        .then() // set baseline time to previous effect's end time
        .tint(color: Colors.black);

    return WillPopScope(
      onWillPop: () => handlePrevBack(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: title,
          ),
        ),
      ),
    );
  }

  // Override ▼ ==========================================
  @override
  void initState() {
    _appRefresh = Provider.of<AppRefresh>(context, listen: false);
    onStartUp();

    super.initState();
  }

  // Function ▼ ==========================================
  ///appService init을 시작하고 완료되면  redirect됨.
  void onStartUp() async {
    await _appRefresh.onAppStart();
  }

  Future<bool> handlePrevBack(BuildContext context) async {
    // 메인 화면에서 뒤로가기 막기
    final DateTime now = DateTime.now();

    if (now.difference(currentDateTime) > const Duration(milliseconds: 1000)) {
      currentDateTime = now;
      Fluttertoast.showToast(
        msg: '한번 더 누르면 앱이 종료됩니다',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withOpacity(0.7),
        textColor: Colors.white,
      );
    } else {
      exit(0);
    }

    return false;
  }
}
