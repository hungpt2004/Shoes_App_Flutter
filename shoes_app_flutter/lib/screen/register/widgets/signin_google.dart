import 'package:flutter/material.dart';

import '../../../theme/style_color.dart';
import '../../../theme/style_text.dart';

class SigninGoogle extends StatelessWidget {
  final VoidCallback onTap;
  const SigninGoogle({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: StyleColor.darkBlueColor,
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/icons/google.png",),
                const SizedBox(width: 10,),
                Text(
                  "Sign in with google",
                  style: StyleText.styleAirbnb(18, FontWeight.w500, StyleColor.darkBlueColor),
                ),
              ]),
        ),
      ),
    );
  }
}
