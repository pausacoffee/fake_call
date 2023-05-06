import 'package:fake_call/routes/app_refresh.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../routes/app_router.dart';
import '../views/home/home_view_model.dart';

class ProviderConfig {
  ProviderConfig._();

  static List<SingleChildWidget> providers() {
    return [
      ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel()),
      ChangeNotifierProvider<AppRefresh>(create: (_) => AppRefresh()),
      Provider<AppRouter>(create: (_) => AppRouter()),
    ];
  }
}
