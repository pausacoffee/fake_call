enum APP_PAGE { splash, home, error, address, permission, setting }

/// router 할 page의 path, name, title 을 정의함.
extension AppPageExtension on APP_PAGE {
  String get toPath {
    switch (this) {
      case APP_PAGE.home:
        return "/home";
      case APP_PAGE.splash:
        return "/splash";
      case APP_PAGE.error:
        return "/error";
      case APP_PAGE.permission:
        return "/permission";
      //sub
      case APP_PAGE.address:
        return "/address";
      case APP_PAGE.setting:
        return "/setting";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case APP_PAGE.home:
        return "HOME";
      case APP_PAGE.splash:
        return "SPLASH";
      case APP_PAGE.error:
        return "ERROR";
      case APP_PAGE.address:
        return "ADDRESS";
      case APP_PAGE.permission:
        return "PERMISSION";
      case APP_PAGE.setting:
        return "SETTING";
      default:
        return "HOME";
    }
  }

  String get toTitle {
    switch (this) {
      case APP_PAGE.home:
        return "My App";
      case APP_PAGE.splash:
        return "My App Splash";
      case APP_PAGE.error:
        return "My App Error";
      case APP_PAGE.address:
        return "My App GEO";
      case APP_PAGE.permission:
        return "My App Permission";
      case APP_PAGE.setting:
        return "My App Setting";
      default:
        return "My App";
    }
  }
}
