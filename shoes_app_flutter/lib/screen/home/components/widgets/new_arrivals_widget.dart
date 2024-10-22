import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../theme/style_text.dart';

class NewsArrivalShoesCard extends StatefulWidget {

  NewsArrivalShoesCard(
      {super.key,
        required this.urlImage,
        required this.name,
        required this.price,
        required this.function,
      });
  String urlImage;
  String name;
  int price;
  VoidCallback? function;
  @override

  State<NewsArrivalShoesCard> createState() => _NewsArrivalShoesCardState();
}

class _NewsArrivalShoesCardState extends State<NewsArrivalShoesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            'BEST CHOICE',
                            style: StyleText.styleAirbnb(14, FontWeight.w400, Colors.blue)
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            'Nike Jordan',
                            style: StyleText.styleAirbnb(20, FontWeight.w500, Colors.black)
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            '\$493.00',
                            style: StyleText.styleAirbnb(16, FontWeight.w500, Colors.black)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/images/${widget.urlImage}"),
                ),
              )
            )
          ],
        ));
  }
}
