enum APP_PAGE {
  splash,
  home,
  error,
  addCall,
  permission,
  setting,
  addCantact,
}

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
      case APP_PAGE.addCall:
        return "addCall";
      case APP_PAGE.setting:
        return "setting";
      case APP_PAGE.addCantact:
        return "addCantact";
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
      case APP_PAGE.addCall:
        return "ADDCALL";
      case APP_PAGE.permission:
        return "PERMISSION";
      case APP_PAGE.setting:
        return "SETTING";
      case APP_PAGE.addCantact:
        return "ADDCANTACT";

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
      case APP_PAGE.addCall:
        return "My App Add Call";
      case APP_PAGE.permission:
        return "My App Permission";
      case APP_PAGE.setting:
        return "My App Setting";
      case APP_PAGE.addCantact:
        return "My App addCantact";

      default:
        return "My App";
    }
  }
}
