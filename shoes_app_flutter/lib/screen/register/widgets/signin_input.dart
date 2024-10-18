import 'package:flutter/material.dart';

import '../../../theme/style_color.dart';
import '../../../theme/style_text.dart';

class SigninInput extends StatelessWidget {
  final VoidCallback onTap;
  const SigninInput({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: TextButton.styleFrom(
            backgroundColor: StyleColor.lightBlueColor,
          ),
          onPressed: onTap,
          child:  Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Sign Up",
              style: StyleText.styleAirbnb(18, FontWeight.w500, Colors.white),
            ),
          )),
    );
  }
}
