import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/signup_page.dart';

import '../../../dashboard/presentation/pages/dashboard_screen.dart';

import '../bloc/bloc/auth_bloc.dart';
import '../bloc/events/auth_event.dart';
import '../bloc/states/auth_state.dart';

class LoginPage extends StatefulWidget {

  static route() =>
      MaterialPageRoute(
        builder: (context) =>
        const LoginPage(),
      );

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;
  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  final formKey =
  GlobalKey<FormState>();

  @override
  void dispose() {

    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: BlocListener<
          AuthBloc,
          AuthState>(

        listener: (context, state) {

          if (state is AuthSuccess) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (_) =>
                const DashboardScreen(),
              ),
            );
          }

          if (state is AuthFailure) {

            ScaffoldMessenger.of(context)
                .showSnackBar(

              SnackBar(
                content:
                Text(state.message),
              ),
            );
          }
        },

        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppPallete.gradient1,
                AppPallete.gradient2,
                Colors.black,
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                padding:
                const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.12),
                  borderRadius:
                  BorderRadius.circular(
                    30,
                  ),
                  border: Border.all(
                    color: Colors.white
                        .withOpacity(0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.2),
                      blurRadius: 15,
                      offset:
                      const Offset(0, 8),
                    ),
                  ],
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize:
                    MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.account_circle,
                        size: 90,
                        color: Colors.white,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight:
                          FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      const Text(

                        "Welcome Back",

                        style: TextStyle(

                          color:
                          Colors.white70,

                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(
                        height: 35,
                      ),

                      AuthField(

                        hintText: 'Email',

                        controller:
                        emailController,
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      AuthField(

                        hintText: 'Password',

                        controller:
                        passwordController,

                        isObsecureText: true,
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      AuthGradientButton(

                        buttonText:
                        'Sign In',

                        onPressed: () {

                          if (formKey
                              .currentState!
                              .validate()) {

                            context
                                .read<AuthBloc>()
                                .add(

                              LoginEvent(

                                emailController
                                    .text
                                    .trim(),

                                passwordController
                                    .text
                                    .trim(),
                              ),
                            );
                          }
                        },
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      GestureDetector(

                        onTap: () {

                          Navigator.of(context)
                              .push(

                            SignupPage.route(),
                          );
                        },

                        child: RichText(

                          text: TextSpan(

                            text:
                            'Don\'t have an account? ',

                            style:
                            const TextStyle(

                              color:
                              Colors.white70,

                              fontSize: 15,
                            ),

                            children: [

                              TextSpan(

                                text:
                                'Sign Up',

                                style:
                                const TextStyle(

                                  color:
                                  Colors.white,

                                  fontWeight:
                                  FontWeight.bold,

                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}