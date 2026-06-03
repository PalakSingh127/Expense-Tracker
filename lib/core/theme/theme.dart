import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';

class AppTheme{
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 3,
    ),
        borderRadius: BorderRadius.circular(10),
  );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(20.0),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      hintStyle: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 1)
      ),
    ),
  );
}