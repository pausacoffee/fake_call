import 'dart:io';

import 'package:fake_call/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_page.dart';
import '../../routes/app_refresh.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  /// 현재 시간
  DateTime currentDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => handlePrevBack(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return CustomScrollView(
      slivers: [
        _IncomingCall(),
        _buttonCRUD(),
        //_listCall(),
      ],
    );
  }

  /// 가짜 전화가 몇분후 울릴지 알려줌.
  Widget _IncomingCall() {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          margin: EdgeInsets.only(
            top: 100.h,
            right: 56.w,
            left: 56.w,
            bottom: 20.h,
          ),
          //height: 70.h,
          child: Column(
            children: [
              Text(
                '4시간 27분 후에 알람이 울립니다.',
                style: TextStylePath.title24w800,
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                '5월 7일 (일) 오전 7:00',
                style: TextStylePath.small14w400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonCRUD() {
    return SliverToBoxAdapter(
      child: Container(
        height: 20.h,
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// 전화 추가
            IconButton(
              onPressed: () {
                context.pushNamed(APP_PAGE.addCall.toName);
              },
              icon: Icon(Icons.add),
            ),

            /// 더 보기
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert_rounded),
            ),

            ///Theme 토글버튼
            Consumer<AppRefresh>(
              builder: (ctx, themeNotifier, _) {
                return IconButton(
                  icon: themeNotifier.themeMode == ThemeMode.light
                      ? Icon(
                          Icons.light_mode_rounded,
                          size: 30.sp,
                        )
                      : Icon(
                          Icons.dark_mode_rounded,
                          size: 30.sp,
                        ),
                  onPressed: () {
                    if (themeNotifier.themeMode == ThemeMode.light) {
                      themeNotifier.themeMode = ThemeMode.dark;
                    } else {
                      themeNotifier.themeMode = ThemeMode.light;
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _listCall() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          SingleChildScrollView(),
        ],
      ),
    );
  }

  // Override ▼ ========================================
  @override
  void initState() {
    super.initState();
  }

  // Function ▼ ==========================================
  /// 뒤로가기로 앱 종료 막기
  Future<bool> handlePrevBack(BuildContext context) async {
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
