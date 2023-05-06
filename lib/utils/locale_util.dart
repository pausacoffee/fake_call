import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LAN_CODE = 'lanCode';
const String LAN_KOR = 'kr';

Future<Locale> setLocal(String lanCode) async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  await _pref.setString(LAN_CODE, lanCode);

  return _locale(lanCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String lanCode = _pref.getString(LAN_CODE) ?? LAN_KOR;

  return _locale(lanCode);
}

Locale _locale(String lanCode) {
  switch (lanCode) {
    case LAN_KOR:
      return Locale(LAN_KOR, 'KO');
    default:
      return Locale(LAN_KOR, 'KO');
  }
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}
