/// GOAL: 가짜전화

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'configs/app_config.dart';
import 'configs/provider_config.dart';
import 'routes/app_refresh.dart';
import 'routes/app_router.dart';
import 'utils/scroll_behavior.dart';
import 'utils/theme.dart';

void main() async {
  await initialize();

  return runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorRenderObjectOfType();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  /// 현재 시간
  DateTime currentDateTime = DateTime.now();

  ///언어
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        /// MultiProvider
        return MultiProvider(
          providers: ProviderConfig.providers(),
          child: Builder(builder: (context) {
            final GoRouter goRouter =
                Provider.of<AppRouter>(context, listen: false).router;
            final AppRefresh themeNotifier =
                Provider.of<AppRefresh>(context, listen: true);

            /// MaterialApp
            return MaterialApp.router(
              routeInformationProvider: goRouter.routeInformationProvider,
              routeInformationParser: goRouter.routeInformationParser,
              routerDelegate: goRouter.routerDelegate,
              locale: _locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              builder: (context, widget) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeNotifier.themeMode,
              debugShowCheckedModeBanner: false,
              scrollBehavior: AppScrollBehavior(),
              backButtonDispatcher: RootBackButtonDispatcher(),
            );
          }),
        );
      },
    );
  }

  /// '뒤로가기'로 앱 종료 막기
  Future<bool> handlePrevBack(BuildContext context) async {
    final DateTime now = DateTime.now();

    if (now.difference(currentDateTime) > const Duration(milliseconds: 1000)) {
      currentDateTime = now;
      Fluttertoast.showToast(
        msg: '한번 더 누르면 앱이 종료됩니다',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withOpacity(0.7),
        textColor: Colors.white,
      );
    } else {
      exit(0);
    }

    return false;
  }
}

///initialize before runApp
Future<void> initialize() async {
  /// Widget Binding 초기화
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    SchedulerBinding.instance.scheduleWarmUpFrame();
  });

  /// SystemChrome Color 초기화
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));

  /// 가로모드 방지
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// Config 초기화
  AppConfig().init();

  /// .env 초기화
  await dotenv.load();

  ///hive 초기화
  await Hive.initFlutter();
  // Hive.registerAdapter(FavAddressModelAdapter());
}
