import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'locale_util.dart';

// UI 표시 관련 ▼ ========================================

/// 숫자를 원단위로 표기
///
/// price : 가격
String parseNumberFormat(int price) {
  var t = NumberFormat('###,###,###,###원');
  return t.format(price);
}

/// 숫자를 콤마 단위로 표기
///
/// price : 가격
String parseNumberCommmaFormat(int num) {
  var t = NumberFormat('###,###,###,###');
  return t.format(num);
}

/// 초를 분:초로 나타내는 함수
///
/// [time] int : 초
String intToTimeString(time) {
  String min = "0${time ~/ 60}";
  String secode = time % 60 < 10 ? "0${time % 60}" : "${time % 60}";
  return "${min}:${secode}";
}

/// yyyy-MM-dd hh:mm 을 PM, AM 으로 바꾸어 주는 함수
String formatWeatherTime(String timeStr) {
  final hour = int.parse(timeStr.substring(11, 13));
  final amPm = hour >= 12 ? 'PM' : 'AM';
  final displayHour = hour % 12 == 0 ? 12 : hour % 12;
  return '$displayHour $amPm';
}

/// 영어로된 풍향 약어를 한국어로 바꾸어줌
String convertWindDirection(String direction, BuildContext context) {
  switch (direction) {
    case 'N':
      return translation(context).direction_n;
    case 'NNE':
      return translation(context).direction_nne;
    case 'NE':
      return translation(context).direction_ne;
    case 'ENE':
      return translation(context).direction_ene;
    case 'E':
      return translation(context).direction_e;
    case 'ESE':
      return translation(context).direction_ese;
    case 'SE':
      return translation(context).direction_se;
    case 'SSE':
      return translation(context).direction_sse;
    case 'S':
      return translation(context).direction_s;
    case 'SSW':
      return translation(context).direction_ssw;
    case 'SW':
      return translation(context).direction_s;
    case 'WSW':
      return translation(context).direction_wsw;
    case 'W':
      return translation(context).direction_w;
    case 'WNW':
      return translation(context).direction_wnw;
    case 'NW':
      return translation(context).direction_nw;
    case 'NNW':
      return translation(context).direction_nnw;
    default:
      return '';
  }
}

// UV 관련 ▼ ========================================
//[https://www.weatheri.co.kr/forecast/forecast09.php] 참고

///uv 지수에 따른 색상
Color getUvColor(double uv) {
  Color color = Colors.white;

  if (uv <= 2) {
    color = Colors.green;
  } else if (uv <= 5) {
    color = Colors.yellow;
  } else if (uv <= 7) {
    color = Colors.orange;
  } else if (uv <= 10) {
    color = Colors.red;
  } else {
    color = Colors.purple;
  }

  return color;
}

///uv 지수에 따른 레벨
String getUvLevel(double uv, BuildContext context) {
  String result = '';

  if (uv <= 2) {
    result = translation(context).danger_low;
  } else if (uv <= 5) {
    result = translation(context).danger_moderate;
  } else if (uv <= 7) {
    result = translation(context).danger_high;
  } else if (uv <= 10) {
    result = translation(context).danger_very_high;
  } else {
    result = translation(context).danger_extreme;
  }

  return result;
}

///uv 지수에 따른 안내 문구
String getUvMsg(double uv, BuildContext context) {
  String result = '';

  if (uv <= 2) {
    result = translation(context).danger_msg_low;
  } else if (uv <= 5) {
    result = translation(context).danger_msg_moderate;
  } else if (uv <= 7) {
    result = translation(context).danger_msg_high;
  } else if (uv <= 10) {
    result = translation(context).danger_msg_very_high;
  } else {
    result = translation(context).danger_msg_extreme;
  }

  return result;
}

//  ▼ ========================================
