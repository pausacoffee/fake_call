import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../routes/app_refresh.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        children: [
          Text('테마 : '),
          Consumer<AppRefresh>(
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
          ),
        ],
      ),
    );
  }

  // Override ▼ ========================================
  @override
  void initState() {
    super.initState();
  }
}
