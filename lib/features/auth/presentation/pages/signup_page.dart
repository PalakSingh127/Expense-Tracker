import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/login_page.dart';

import '../../../../../core/theme/app_pallete.dart';
import '../bloc/bloc/auth_bloc.dart';
import '../bloc/events/auth_event.dart';
import '../bloc/states/auth_state.dart';

class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => SignupPage());
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose(){
    nameController.dispose();
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
                SizedBox(height: 250,),
                Text('Sign Up', style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppPallete.gradient2
                ),
                ),
                SizedBox(height: 30,),
                AuthField(
                  hintText: 'Name',
                  controller: nameController,
                ),
                SizedBox(height: 15,),
                AuthField(
                  hintText: 'Email',
                  controller: emailController,
                ),
                SizedBox(height: 15,),
                AuthField(
                  hintText: 'Password',
                  controller: passwordController,
                 isObsecureText: true,),
                SizedBox(height: 20,),
                AuthGradientButton(

                  buttonText: 'Sign Up',

                  onPressed: () {

                    if (formKey.currentState!.validate()) {

                      context.read<AuthBloc>().add(

                          SignupEvent(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          )
                      );
                    }
                  },
                ),
                GestureDetector(onTap: (){
                  Navigator.of(context).push(LoginPage.route());
                },

                  child: RichText(text: TextSpan(
                    text: 'Already have an account?',
                    style: Theme.of(context).textTheme.titleSmall,
                    children: [
                      TextSpan(
                        text: 'Sign In',
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
