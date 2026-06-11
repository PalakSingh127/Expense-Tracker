import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_clean_architecture/features/dashboard/presentation/pages/dashboard_screen.dart';

import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {

    super.initState();

    checkLogin();
  }

  void checkLogin() {

    Timer(

      const Duration(seconds: 5),

          () {

        // ✅ CHECK IF USER IS ALREADY LOGGED IN
        final user =
            FirebaseAuth.instance.currentUser;

        if (user != null) {

          // ✅ USER ALREADY LOGGED IN
          Navigator.of(context).pushReplacement(

            MaterialPageRoute(

              builder: (_) =>
              const DashboardScreen(),
            ),
          );

        } else {

          // ✅ USER NOT LOGGED IN
          Navigator.of(context).pushReplacement(

            MaterialPageRoute(

              builder: (_) =>
              const LoginPage(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      AppPallete.borderColor,

      body: Center(

        child: Lottie.asset(
          "assets/lottie/expense.json",
        ),
      ),
    );
  }
}