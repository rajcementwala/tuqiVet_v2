import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../cache/preference_store.dart';
import 'colors.dart';

class AppTheme {
  AppTheme(this._preferenceStore);

  final PreferenceStore _preferenceStore;

  late Brightness brightness;

  ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary2,
      primaryColorDark: AppColors.primary2,
      primaryColorLight: AppColors.primary2,
      highlightColor: AppColors.white,
      colorScheme: const ColorScheme.light(
        background: AppColors.scaffoldBackgroundColor,
      ),
      //background: AppColors.scaffoldBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      unselectedWidgetColor: Colors.white,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: AppColors.primary2,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary2,
      primaryColorDark: AppColors.primary2,
      primaryColorLight: AppColors.primary2,
      highlightColor: AppColors.white,
      colorScheme: const ColorScheme.dark(
        background: AppColors.scaffoldBackgroundColor,
      ),
      //backgroundColor: AppColors.scaffoldBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      unselectedWidgetColor: Colors.white,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: AppColors.primary2,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
      ),
    );
  }

  ThemeData get theme {
    AppColors.isLightTheme = _preferenceStore.isAppThemeLight();
    return AppColors.isLightTheme ? lightTheme : darkTheme;
  }

  bool get isLight {
    AppColors.isLightTheme = _preferenceStore.isAppThemeLight();
    return AppColors.isLightTheme;
  }

  bool changeTheme() {
    _preferenceStore.setAppThemeLight(!isLight);
    AppColors.isLightTheme = isLight;
    return AppColors.isLightTheme;
  }
}
