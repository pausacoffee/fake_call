import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color.dart';
import '../utils/text.dart';

/// 글로벌 버튼 위젯
///
/// text : 버튼 내용
///
/// onClick : 클릭시 행위
///
/// isPrimary:
///
/// color: 배경컬러
///
/// isDisable: 버튼 사용 가능여부
///
/// duration : 밀리초
///
/// child : 자식 체크
class GlobalButton extends StatelessWidget {
  final String? title;
  final Function onClick;
  final Color? color;
  final TextStyle? style;
  final bool isPrimary;
  final bool isDisable;
  final int duration;
  final bool isHaptic;
  final Widget? child;
  const GlobalButton({
    super.key,
    this.title,
    required this.onClick,
    this.color,
    this.style,
    this.isHaptic = true,
    this.isPrimary = true,
    this.isDisable = false,
    this.duration = 200,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: Duration(milliseconds: duration),
      onPressed: () {
        onClick();
        // if (!isDisable) {
        //   if (isHaptic) ConfigService.to.handleOnHapticFeedback();
        //   onClick();
        // }
      },
      child: child != null
          ? child!
          : isPrimary
              ? Container(
                  width: double.infinity,
                  height: 48.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: isDisable
                        ? ColorPath.stateDisableColor2
                        : color ?? ColorPath.primaryColor,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    title!,
                    style: (style ?? TextStylePath.base16w600),
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: 48.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      border: Border.all(
                        width: 1,
                        color: color ?? ColorPath.primaryColor,
                      )),
                  alignment: Alignment.center,
                  child: Text(
                    title!,
                    style: (style ?? TextStylePath.base16w600)
                        .copyWith(color: color ?? ColorPath.primaryColor),
                  ),
                ),
    );
  }
}
