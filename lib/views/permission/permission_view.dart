import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../global/global_button.dart';
import '../../../utils/color.dart';
import '../../../utils/locale_util.dart';
import '../../../utils/text.dart';
import '../../services/permission_service.dart';

/// 권한 요청 화면
///
/// description : 앱에 대한 전반적인 권한을 요청하는 화면
///
/// action : 허용하기 클릭시 [알림, 사진, 미디어 소리,]에 관한 권한 요청
///
class PermissionView extends StatelessWidget {
  PermissionView({super.key});

  /// 현재 시간
  DateTime currentDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => handlePrevBack(context),
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(translation(context).guide_permission),
            ),
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: ColorPath.bgColor,
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.w),

                ///타이틀
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    translation(context).guide_msg_permission,
                    textAlign: TextAlign.center,
                    style: TextStylePath.title18w600,
                  ),
                ),
                SizedBox(height: 32.w),

                ///permission 목록
                ...List.generate(PermissionService.to.permissionData.length,
                    (index) {
                  return Container(
                    padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22.w,
                          backgroundColor: ColorPath.stateDisableColor2,
                          child: Icon(
                            PermissionService.to.permissionData[index].icon,
                            size: 24.w,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              PermissionService.to.permissionData[index].title,
                              style: TextStylePath.title18w800.copyWith(
                                color: ColorPath.titleColor,
                              ),
                            ),
                            SizedBox(height: 4.w),
                            Text(
                              PermissionService
                                  .to.permissionData[index].description,
                              style: TextStylePath.small14w400.copyWith(
                                color: ColorPath.textColor1,
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                  );
                }).toList(),
                const Spacer(),
                GlobalButton(
                    title: translation(context).confirm,
                    onClick: () => PermissionService.to
                        .handlePermissionOnPressed(context)),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> handlePrevBack(BuildContext context) async {
    // 메인 화면에서 뒤로가기 막기
    final DateTime now = DateTime.now();

    if (now.difference(currentDateTime) > const Duration(milliseconds: 1000)) {
      currentDateTime = now;
      Fluttertoast.showToast(
        msg: translation(context).click_one_more_to_close,
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
