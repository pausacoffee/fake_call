import 'package:fake_call/views/contact/contact_picker_view.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../global/global_error_page.dart';
import '../views/call/add_call_view.dart';
import '../views/home/home_view.dart';
import '../views/permission/permission_view.dart';
import '../views/settings/settings_view.dart';
import '../views/splash/splash_view.dart';
import 'app_page.dart';
import 'app_refresh.dart';

class AppRouter {
  GoRouter get router => _goRouter;

  AppRouter();

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: AppRefresh(),
    initialLocation: APP_PAGE.splash.toPath,
    debugLogDiagnostics: true,
    errorBuilder: (BuildContext context, GoRouterState state) =>
        const GlobalErrorPage(),
    routes: <GoRoute>[
      GoRoute(
        path: APP_PAGE.home.toPath,
        name: APP_PAGE.home.toName,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();
        },
        routes: <GoRoute>[
          GoRoute(
            path: APP_PAGE.addCall.toPath,
            name: APP_PAGE.addCall.toName,
            builder: (BuildContext context, GoRouterState state) {
              return const AddCallView();
            },
            routes: <GoRoute>[
              GoRoute(
                path: APP_PAGE.addCantact.toPath,
                name: APP_PAGE.addCantact.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const ContactPickerView();
                },
              ),
            ],
          ),
          GoRoute(
            path: APP_PAGE.setting.toPath,
            name: APP_PAGE.setting.toName,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const SettingsView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                final tween = Tween(begin: begin, end: end);
                final curvedAnimation =
                    CurvedAnimation(parent: animation, curve: curve);

                return SlideTransition(
                  position: tween.animate(curvedAnimation),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      GoRoute(
        path: APP_PAGE.splash.toPath,
        name: APP_PAGE.splash.toName,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: APP_PAGE.permission.toPath,
        name: APP_PAGE.permission.toName,
        builder: (BuildContext context, GoRouterState state) {
          return PermissionView();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final homeLocation = APP_PAGE.home.toPath;
      final splashLocation = APP_PAGE.splash.toPath;
      final permissionLocation = APP_PAGE.permission.toPath;

      final isInitialized = AppRefresh().initialized;
      final isPermitted = AppRefresh().permitted;

      final isGoingToSplash = state.subloc == splashLocation;
      final isGoingToPermission = state.subloc == permissionLocation;
      //final isGoingToHome = state.subloc == homeLocation;

      /// 앱 시작전 권한, 로그인 여부, 세팅 등을 체크하고 route 한다.
      if (!isInitialized && !isGoingToSplash) {
        return splashLocation;
      } else if (isInitialized && !isPermitted && !isGoingToPermission) {
        return permissionLocation;
      } else if ((isInitialized && isGoingToSplash) ||
          (isPermitted && isGoingToPermission)) {
        return homeLocation; //위 체크가 끝나면 home으로!
      } else {
        // Else Don't do anything
        return null;
      }
    },
  );
}
