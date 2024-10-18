import 'package:flutter/material.dart';

import '../../../theme/style_color.dart';
import '../../../theme/style_text.dart';

class OnboardTitle extends StatelessWidget {
  final int currentOnboard;
  const OnboardTitle({super.key, required this.currentOnboard});

  @override
  Widget build(BuildContext context) {
    late String title;
    late String description;

    if(currentOnboard == 0){
      title = "Start Journey With Nike";
      description = "Smart, Gorgeous & Fashionable Collection";
    }else if(currentOnboard == 1){
      title = "Follow Latest Style Shoes";
      description = "There Are Many Beautiful And Attractive Plants To Your Room";
    }else if(currentOnboard == 2){
      title = "Summer Shoes Nike 2022";
      description = "Amet Minim Lit Nodeseru Saku Nandu sit Alique Dolor";
    }
    return Expanded(
      flex: 13,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Text(
              title,
              style: StyleText.styleAirbnb(46, FontWeight.w500, StyleColor.darkBlueColor),
            ),
            const SizedBox(height: 10,),
            Text(
              description,
              style: StyleText.styleAirbnb(20, FontWeight.w400, StyleColor.blueGreyColor),
            ),
          ],
        ),
      ),
    );
  }
}
