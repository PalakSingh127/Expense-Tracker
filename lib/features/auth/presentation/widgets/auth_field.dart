import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';

class AuthField extends StatefulWidget {

  final String hintText;
  final TextEditingController controller;
  final bool isObsecureText;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObsecureText = false,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {

    return TextFormField(

      style: const TextStyle(
        color: AppPallete.containerColor,
      ),

      controller: widget.controller,

      validator: (value) {

        if (value == null || value.isEmpty) {

          return '${widget.hintText} is missing';
        }

        return null;
      },

      // ✅ PASSWORD SHOW/HIDE
      obscureText: widget.isObsecureText
          ? !isPasswordVisible
          : false,

      decoration: InputDecoration(

        hintText: widget.hintText,

        hintStyle: const TextStyle(
          color: Colors.white70,
        ),

        enabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(15),

          borderSide: const BorderSide(
            color: Colors.white54,
          ),
        ),

        focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(15),

          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(15),

          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(15),

          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),

        // ✅ EYE ICON
        suffixIcon: widget.isObsecureText
            ? IconButton(

          icon: Icon(

            isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off,

            color: Colors.white,
          ),

          onPressed: () {

            setState(() {

              isPasswordVisible =
              !isPasswordVisible;
            });
          },
        )
            : null,
      ),
    );
  }
}