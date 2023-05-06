import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/global_dialog_widget.dart';
import '../models/permission/permission_model.dart';
import '../routes/app_refresh.dart';

class PermissionService {
  static PermissionService to = PermissionService();

  // Variable ▼ ========================================

  /// 현재 시간
  final DateTime currentDateTime = DateTime.now();

  List<PermissionModel> permissionData = [
    PermissionModel(
      title: '알림',
      icon: Icons.access_alarm_rounded,
      description: '전화가 왔을 때 알림이 뜹니다.',
      isRequired: false,
      isExpanded: true,
    ),
    PermissionModel(
      title: '사진/미디어/파일',
      icon: Icons.camera_alt_rounded,
      description: '전화 벨소리를 설정해보세요.',
      isRequired: false,
      isExpanded: true,
    ),
  ];

  /// 권한 프로세스 종료 체크
  bool isPermissionSuccess = false;

  /// 위치기반 허용 여부
  bool isLocationPermissionsGranted = false;

  // Funcion ▼ ========================================

  /// 권한 허용 버튼
  Future<dynamic> handlePermissionOnPressed(BuildContext context) async {
    Map<Permission, PermissionStatus> permissionStatus = await [
      Permission.storage,
    ].request();

    for (var index = 0; index < permissionStatus.length; index++) {
      if (index == permissionStatus.length - 1) {
        isPermissionSuccess = true;
      }

      switch (permissionStatus[index]) {
        case PermissionStatus.denied:
          Logger().d('사용자가 요청한 기능에 대한 액세스를 거부한 경우');

          isLocationPermissionsGranted = false;
          await GlobalPermissionDialog(controller: this);
          break;
        case PermissionStatus.granted:
          Logger().d('사용자가 요청한 기능에 대한 액세스 권한을 부여한 경우');

          handlePermissionGranted();
          break;
        case PermissionStatus.limited:
          Logger().d('사용자가 제한된 액세스를 위해 이 애플리케이션을 승인했습니다. iOS(iOS14+)에서만 지원됨');

          isLocationPermissionsGranted = false;
          break;
        case PermissionStatus.permanentlyDenied:
          Logger().d(
              '요청된 기능에 대한 권한이 영구적으로 거부되면 이 권한을 요청할 때 권한 대화 상자가 표시되지 않습니다. 사용자는 여전히 설정에서 권한 상태를 변경할 수 있습니다. Android에서만 지원됩니다');

          isLocationPermissionsGranted = false;
          //Navigator.pop(context);
          await GlobalPermissionDialog(controller: this);
          break;
        case PermissionStatus.restricted:
          Logger().d(
              'OS가 요청한 기능에 대한 액세스를 거부했습니다. 사용자는 자녀 보호 기능과 같은 활성 제한으로 인해 이 앱의 상태를 변경할 수 없습니다. iOS에서만 지원됩니다');

          isLocationPermissionsGranted = false;
          await GlobalPermissionDialog(controller: this);
          break;
        default:
          // * 여러 권한이 있는 경우에는 해당되지 않을 경우 넘긴다.
          handlePermissionGranted();
          break;
      }
    }

    // handlePermissionGranted();
  }

  /// 모달 취소 버튼
  Future<dynamic> handlePermissionDialogCancelOnPressed(
      BuildContext context) async {
    context.pop();
  }

  /// 권한 재요청
  Future<dynamic> handlePermissionReOnPressed(BuildContext context) async {
    context.pop();
    openAppSettings();
  }

  /// 권한 허용
  Future<dynamic> handlePermissionGranted() async {
    if (isPermissionSuccess) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('initialize_permission', true);

      ///call redirect in app router
      AppRefresh().permitted = true;
    }
  }
}
