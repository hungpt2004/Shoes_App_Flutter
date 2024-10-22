import 'package:flutter/material.dart';
import 'package:flutter_shoes_shop/theme/style_text.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: _button(() {}, "menu.png")),
        Expanded(
            flex: 2,
            child: Column(
              children: [
                Text("Store Location", style: StyleText.styleAirbnb(14, FontWeight.w400, Colors.black)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on_rounded,color: Color(0xFFF87265),),
                    Text("Mondolibug, Sylhet",style: StyleText.styleAirbnb(16, FontWeight.w500, Colors.black),)
                  ],
                )
              ],
            )),
        Expanded(flex: 1, child: _button(() {}, "shopping_black.png")),
      ],
    );
  }
}

Widget _button(Function function, String url) {
  return Container(
      height: 45,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: TextButton(
        style: const ButtonStyle(
            shape: WidgetStatePropertyAll(CircleBorder()),
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            elevation: WidgetStatePropertyAll(5),
            fixedSize: WidgetStatePropertyAll(Size(100, 50))),
        onPressed: () {
          function();
        },
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset(
            "assets/images/icons/$url",
            fit: BoxFit.cover,
          ),
        ),
      ));
}
