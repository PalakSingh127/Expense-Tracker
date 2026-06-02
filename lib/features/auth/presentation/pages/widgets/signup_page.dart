import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/widgets/auth_field.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/widgets/auth_gradient_button.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/widgets/login_page.dart';

import '../../../../../core/theme/app_pallete.dart';

class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => SignupPage());
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final NameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose(){
    NameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 150,),
                Text('Sign Up', style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(height: 30,),
                AuthField(hintText: 'Name',),
                SizedBox(height: 15,),
                AuthField(hintText: 'Email',),
                SizedBox(height: 15,),
                AuthField(hintText: 'Password', isObsecureText: true,),
                SizedBox(height: 20,),
                AuthGradientButton(),
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
