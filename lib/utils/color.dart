import 'package:flutter/material.dart';

/// 색상표
/// https://material.io/resources/color/#!/?view.left=0&view.right=0&secondary.color=C5CAE9&primary.color=7d63fd&secondary.text.color=FAFAFA
abstract class ColorPath {
  static Color primaryColor = const Color(0xff3F4E4F);
  static Color pointColor = const Color(0xffA27B5C);

  //  텍스트 컬러
  static Color titleColor = const Color(0xff303030);
  static Color textBlack = const Color(0xff000000);
  static Color textColor1 = const Color(0xff676767);
  static Color textColor2 = const Color(0xffA0A0A0);
  static Color textColor3 = const Color(0xffffffff);
  static Color textDisableColor1 = const Color(0xffB1B1B1);
  static Color textDisableColor2 = const Color(0xffB8A89C);
  static Color textDisableColor3 = const Color(0xffA4988F);
  static Color textErrorColor = const Color(0xffCD3F3F);

  //배경
  static Color bgColor = const Color(0xffFCFCFC);
  static Color bgColor2 = const Color(0xffF2F0EC);

  //선
  static Color lineDisableColor = const Color(0xffCDC7C2);
  static Color lineTypingColor = const Color(0xffA27B5C);
  static Color lineDoneColor = const Color(0xffA4988F);
  static Color lineErrorColor = const Color(0xffDB6262);

  // 상태
  static Color stateDisableColor = const Color(0xffDCD7C9);
  static Color stateDisableColor2 = const Color(0xffDCDCDC);
}
