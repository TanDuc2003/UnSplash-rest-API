import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/utils/pref_manager.dart';

class ThemeState extends ChangeNotifier {
  int currentThemeIndex = 1;
  ThemeMode currentThemeMode = ThemeMode.light;

  final List<ThemeMode> _themeModes = [
    ThemeMode.light,
    ThemeMode.dark,
    ThemeMode.system,
  ];

  void getTheme() async {
    currentThemeIndex = await PrefManager().getThemeIndex();
    currentThemeMode = _themeModes[currentThemeIndex];
  }

  changeThemeMode(index) {
    currentThemeMode = _themeModes[index];
    currentThemeIndex = index;
    notifyListeners();
    PrefManager().saveThemeIndex(index);
  }

  ThemeData getDarkTheme() {
    return ThemeData(
      // scaffoldBackgroundColor: Colors.black45,
      appBarTheme: const AppBarTheme(
        // brightness: Brightness.dark,
        color: Colors.black45,
      ),
      primaryColor: Colors.black45,
      colorScheme: const ColorScheme.dark().copyWith(secondary: Colors.indigo),
    );
  }
}

class PageState extends ChangeNotifier {
  int currentPage = 0;
  bool select = false;
  changePage(index) {
    currentPage = index;
    notifyListeners();
  }
}
