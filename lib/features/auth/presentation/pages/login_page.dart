import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/signup_page.dart';
import '../bloc/bloc/auth_bloc.dart';
import '../bloc/events/auth_event.dart';
import '../bloc/states/auth_state.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                ),
                Text('Sign In', style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppPallete.gradient2,
                ),
                ),
                SizedBox(height: 30,),
                AuthField(
                  hintText: 'Email',
                  controller: emailController,
                ),
                SizedBox(height: 15,),
            AuthField(
              hintText: 'Password',
              controller: emailController,
                isObsecureText: true,
                ),
                SizedBox(height: 20,),
                AuthGradientButton(

                  buttonText: 'Sign In',

                  onPressed: () {

                    if (formKey.currentState!.validate()) {

                      context.read<AuthBloc>().add(

                          LoginEvent(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          )
                      );
                    }
                  },
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(SignupPage.route());
                  },
                  child: RichText(text: TextSpan(
                    text: 'Don\'t have an account?',
                        style: Theme.of(context).textTheme.titleSmall,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppPallete.gradient2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                  ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
