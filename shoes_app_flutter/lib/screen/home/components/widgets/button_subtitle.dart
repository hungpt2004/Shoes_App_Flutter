import 'package:flutter/material.dart';
import '../../../../constant.dart';
import '../../../../theme/style_space.dart';
import '../../../../theme/style_text.dart';

class ButtonSubtitle extends StatefulWidget {
  final VoidCallback? function;
  final String url;
  final String name;

  ButtonSubtitle(
      {super.key, this.function, required this.name, required this.url});

  @override
  State<ButtonSubtitle> createState() => _ButtonState();
}

class _ButtonState extends State<ButtonSubtitle> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 2, bottom: 5, top: 5),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(isSelected ? StyleColor.lightBlueColor : Colors.white),
            elevation: const WidgetStatePropertyAll(4),
            animationDuration: const Duration(milliseconds: 500),
            shape: WidgetStatePropertyAll(isSelected ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)) : const CircleBorder())
          ),
            onPressed: (){
              setState(() {
                isSelected = !isSelected;
              });
            },
            child: isSelected ?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              AnimatedContainer(
                duration: const Duration(seconds: 2),
                  curve: Curves.fastOutSlowIn,
                  width: 45,height: 100, margin: const EdgeInsets.only(right: 10), decoration:  const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(widget.url,fit: BoxFit.contain,),
              )),
              Text(widget.name,style: StyleText.styleAirbnb(16, FontWeight.w600, Colors.white),)
            ],) : SizedBox(width: 30,height: 30,child: Image.asset(widget.url),)
        ),
      )
    );
  }
}


