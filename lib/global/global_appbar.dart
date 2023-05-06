import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isWhiteTheme;
  final List<Widget>? actions;
  final Function? onBack;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool centerTitle;
  final bool isBack;
  const GlobalAppBar(
    this.title, {
    Key? key,
    this.actions,
    this.systemOverlayStyle,
    this.isBack = false,
    this.isWhiteTheme = false,
    this.centerTitle = false,
    this.onBack,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isWhiteTheme ? Colors.black : ColorPath.bgColor,
      systemOverlayStyle: systemOverlayStyle,
      elevation: 0,
      leading: isBack
          ? IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: isWhiteTheme ? Colors.white : Colors.black,
                size: 32.sp,
              ))
          : null,
      title: !centerTitle
          ? Transform(
              transform: Matrix4.translationValues(-15.0.w, 0.0, 0.0),
              child: Text(
                title,
                style: TextStyle(
                  color: isWhiteTheme ? Colors.white : const Color(0xff212121),
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            )
          : Text(
              title,
              style: TextStyle(
                color: isWhiteTheme ? Colors.white : const Color(0xff212121),
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
      actions: actions,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// 글로벌 실버 앱바
class GlobalSliverAppBar extends StatelessWidget {
  final String title;
  final double expandedHeight;
  final Widget? flexibleSpace;
  final bool isWhiteTheme;
  final List<Widget>? actions;
  final Widget? leading;
  final Function? onBack;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool centerTitle;
  final bool isBack;
  final bool floating;
  final bool snap;

  GlobalSliverAppBar(
    this.title, {
    this.expandedHeight = 0,
    this.flexibleSpace,
    this.actions,
    this.systemOverlayStyle,
    this.isBack = false,
    this.isWhiteTheme = false,
    this.centerTitle = true,
    this.onBack,
    this.floating = false,
    this.snap = false,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: isWhiteTheme ? Colors.black : ColorPath.bgColor,
      systemOverlayStyle: systemOverlayStyle,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          color: isWhiteTheme ? Colors.white : const Color(0xff212121),
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
      ),
      leading: isBack
          ? IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: isWhiteTheme ? Colors.white : Colors.black,
                size: 32.sp,
              ))
          : leading,
      actions: actions,
      pinned: true,
      centerTitle: centerTitle,
      floating: floating,
      snap: snap,
      expandedHeight: expandedHeight,
      flexibleSpace: flexibleSpace,
    );
  }
}
