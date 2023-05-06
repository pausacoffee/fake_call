import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/permission_service.dart';
import '../utils/locale_util.dart';

class GlobalPermissionDialog extends StatelessWidget {
  const GlobalPermissionDialog({Key? key, required this.controller})
      : super(key: key);
  final PermissionService controller;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: WillPopScope(
        onWillPop: () => Future(() => false),
        child: CupertinoAlertDialog(
          title: Text(translation(context).allow_permission_plz),
          content: Column(
            children: [
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: Text(
                  translation(context).allow_permission_for_app_plz,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(
                    8.r,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        translation(context).required_permission,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          translation(context).location_based,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: 21.w),
                        Text(
                          controller.isLocationPermissionsGranted
                              ? translation(context).allowed
                              : translation(context).not_allowed,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                translation(context).cancle,
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              onPressed: () {},
              //TODO: controller.handlePermissionDialogCancelOnPressed(),
            ),
            CupertinoDialogAction(
              child: Text(translation(context).setting),
              onPressed:
                  () {}, //TODO: controller.handlePermissionReOnPressed(),
            ),
          ],
        ),
      ),
    );
  }
}
