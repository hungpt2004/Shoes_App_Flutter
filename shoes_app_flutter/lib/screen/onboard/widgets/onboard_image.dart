import 'package:flutter/material.dart';
import 'package:flutter_shoes_shop/theme/style_color.dart';

class OnboardImage extends StatelessWidget {
  final int currentOnboard;
  const OnboardImage({super.key, required this.currentOnboard});

  @override
  Widget build(BuildContext context) {
    late String imageUrl;
    if(currentOnboard == 0){
      imageUrl = "onboard_1.png";
    }else if(currentOnboard == 1){
      imageUrl = "onboard_2.png";
    }else if(currentOnboard == 2){
      imageUrl = "onboard_3.png";
    }
    return Expanded(
      flex: 22,
      child: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/NIKE.png",
                width: double.infinity,
              ),
            ),
            Positioned(
              child: Image.asset(
                "assets/images/onboard/${imageUrl}",
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
            Positioned(
              bottom: 0,
                left: 5,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: StyleColor.lightBlueColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                )
            ),

            Positioned(
                top: 20,
                right: 50,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: StyleColor.lightBlueColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                )
            ),
            Positioned(
                top: 40,
                left: 30,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA4CDF6),
                    borderRadius: BorderRadius.circular(50),
                  ),
                )
            ),

            Positioned(
                bottom: 60,
                right: 50,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA4CDF6),
                    borderRadius: BorderRadius.circular(50),
                  ),
                )
            ),

          ],
        ),
      ),
    );
  }
}
