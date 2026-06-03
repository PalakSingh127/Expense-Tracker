import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';

class AuthGradientButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String buttonText;

  const AuthGradientButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),

        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,

          colors: [
            AppPallete.gradient1,
            AppPallete.gradient2,
          ],
        ),
      ),

      child: ElevatedButton(

        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),

          backgroundColor:
          AppPallete.transparentColor,

          shadowColor:
          AppPallete.transparentColor,
        ),

        onPressed: onPressed,

        child: Text(
          buttonText,

          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}