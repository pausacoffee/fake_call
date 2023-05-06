import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

///HomePage에서 필요한 데이터들은 불러오고, notify 함.
class HomeViewModel extends ChangeNotifier {
  HomeViewModel();
  // Variable ▼ ==========================================
  /// 데이터 로딩
  bool _isLoading = true;

  /// 현재 선택된 위치
  String userLocation = 'London';

  /// 즐겨찾기 location 리스트
  List<String> userLocationList = ['London', '+'];

  // Getter/Settter ▼ ==========================================
  /// 데이터 로딩
  bool get isLoading => _isLoading;

  void setIsLoding(bool data) {
    _isLoading = data;

    notifyListeners();
  }

  // Fucntion ▼ ==========================================

  /// Home 화면에 보여줄 데이터를 load 한다.
  Future<void> initialize() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userLocationList =
          prefs.getStringList('user_loacation_list') ?? userLocationList;

      userLocation = userLocationList[0];

      //await fetchViewModel();

      setIsLoding(false);
    } catch (e) {
      Logger().d(e);
    }
  }
}
