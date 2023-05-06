// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 글로벌 토스트 위젯
/// [message] 메세지
/// [bottom]: 바닥 마진
/// [duration]: 유지 시간 (초)
Future<dynamic> GlobalToastWidget({
  /// 메세지
  required String message,

  /// 유지 시간
  int duration = 3,
}) async {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: duration,
    backgroundColor: Colors.black.withOpacity(0.7),
    textColor: Colors.white,
  );
}
