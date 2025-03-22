import 'package:flutter/material.dart';
import '../../../../constant.dart';
import '../../../../theme/style_space.dart';
import '../../../../theme/style_text.dart';

class ButtonSubtitle extends StatefulWidget {
  final String url;
  final String name;
  bool isSelectedBrand;
  final ValueChanged<String> onSelectedBrand;

  ButtonSubtitle({super.key,required this.onSelectedBrand, required this.name, required this.url, required this.isSelectedBrand});

  @override
  State<ButtonSubtitle> createState() => _ButtonState();
}

class _ButtonState extends State<ButtonSubtitle> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap:(){
          widget.onSelectedBrand(widget.name);
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 5, top: 5),
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      widget.isSelectedBrand ? StyleColor.lightBlueColor : Colors.white),
                  elevation: const WidgetStatePropertyAll(4),
                  animationDuration: const Duration(milliseconds: 300),
                  shape: WidgetStatePropertyAll( widget.isSelectedBrand
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))
                      : const CircleBorder(side: BorderSide.none)),
                padding: const WidgetStatePropertyAll(EdgeInsets.all(6)), // Ensure no internal padding
              ),
              onPressed: () {
                setState(() {
                  widget.isSelectedBrand = !widget.isSelectedBrand;
                });
                widget.onSelectedBrand(widget.name); // Truyền tên thương hiệu được chọn
              },
              child:  widget.isSelectedBrand
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                            width: 50,
                            height: 100,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Image.asset(
                                widget.url,
                                fit: BoxFit.contain,
                              ),
                            )),
                        Text(
                          widget.name,
                          style: StyleText.styleAirbnb(
                              16, FontWeight.w600, Colors.white),
                        )
                      ],
                    )
                  : SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(widget.url),
                    )),
        ));
  }
}
