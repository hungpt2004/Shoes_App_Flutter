import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../theme/style_text.dart';

class PopularShoesCard extends StatefulWidget {
  PopularShoesCard(
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
  State<PopularShoesCard> createState() => _PopularShoesCardState();
}

class _PopularShoesCardState extends State<PopularShoesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 130,
        height: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 100,
                  child: Image.asset(
                    "assets/images/${widget.urlImage}", // Thay đổi đường dẫn đến hình ảnh sản phẩm của bạn,
                  ),
                )
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Text(
                            'BEST SELLER',
                            style: StyleText.styleAirbnb(14, FontWeight.w400, Colors.blue)
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Text(
                            'Nike Jordan',
                            style: StyleText.styleAirbnb(12, FontWeight.w500, Colors.black)
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Text(
                            '\$493.00',
                            style: StyleText.styleAirbnb(12, FontWeight.w500, Colors.black)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
