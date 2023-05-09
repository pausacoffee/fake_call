import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../routes/app_refresh.dart';

class GlobalThemeButton extends StatefulWidget {
  const GlobalThemeButton({super.key});

  @override
  State<GlobalThemeButton> createState() => _GlobalThemeButtonState();
}

class _GlobalThemeButtonState extends State<GlobalThemeButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppRefresh>(
      builder: (ctx, themeNotifier, _) {
        return IconButton(
          icon: themeNotifier.themeMode == ThemeMode.light
              ? Icon(
                  Icons.light_mode_rounded,
                  size: 30.sp,
                  color: Colors.white,
                )
              : Icon(
                  Icons.dark_mode_rounded,
                  size: 30.sp,
                  color: Colors.white,
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
    );
  }
}
