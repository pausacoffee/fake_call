import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color.dart';
import 'text.dart';

class APPINPUTDECORATION {
  static InputDecoration base(String hintText,
          {Widget? suffix, Widget? suffixIcon}) =>
      InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 10.w,
          horizontal: 14.w,
        ),
        isCollapsed: true,
        suffix: suffix ?? null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorPath.textDisableColor1,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorPath.textDisableColor1,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorPath.textDisableColor3,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        hintText: hintText,
        hintStyle: TextStylePath.small14w400
            .copyWith(color: ColorPath.textDisableColor3),
      );
}
