import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/theme/theme.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/widgets/login_page.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/widgets/signup_page.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/widgets/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication',
      theme: AppTheme.darkThemeMode,
      home: SplashScreen(),
    );
  }
}


