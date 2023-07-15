import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  SettingProvider({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  // theme control
  ThemeMode themeMode = ThemeMode.light;
  setThemeMode(BuildContext context) {
    themeMode = useLightMode(context) ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  useLightMode(BuildContext context) {
    switch (themeMode) {
      case ThemeMode.system:
        return View.of(context).platformDispatcher.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }
}
