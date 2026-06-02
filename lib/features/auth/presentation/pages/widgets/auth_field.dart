import 'package:flutter/material.dart';
class AuthField extends StatelessWidget {
  final String hintText;
  final bool isObsecureText;
  const AuthField({super.key,
  required this.hintText,
    this.isObsecureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is missing';
        }
        return null;
      },
      obscureText: isObsecureText,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
