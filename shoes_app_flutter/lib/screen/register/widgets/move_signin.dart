import 'package:flutter/material.dart';

import '../../../theme/style_color.dart';
import '../../../theme/style_text.dart';

class MoveSignin extends StatelessWidget {
  final VoidCallback onTap;
  const MoveSignin({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already Have An Account?",
          style: StyleText.styleAirbnb(14, FontWeight.w400, StyleColor.blueGreyColor),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            " Sign in",
            style: StyleText.styleAirbnb(14, FontWeight.w500, StyleColor.darkBlueColor),
          ),
        ),
      ],
    );
  }
}
