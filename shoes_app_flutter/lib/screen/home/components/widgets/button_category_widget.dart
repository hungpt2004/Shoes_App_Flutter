import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'button_subtitle.dart';

class ButtonCategoryWidget extends StatefulWidget {
  const ButtonCategoryWidget({super.key});

  @override
  State<ButtonCategoryWidget> createState() => _ButtonCategoryWidgetState();
}

class _ButtonCategoryWidgetState extends State<ButtonCategoryWidget> {

  bool isSelected = false;

  final List<Map<String, dynamic>> _brands = [
    {
      "name":"Nike",
      "url":"assets/images/nike/nike.png",
    },
    {
      "name":"Puma",
      "url":"assets/images/puma/puma.png",
    },
    {
      "name":"Under",
      "url":"assets/images/under/under_amour.png",
    },
    {
      "name":"Adidas",
      "url":"assets/images/adidas/adidas.png",
    },
    {
      "name":"Conver",
      "url":"assets/images/converse/converse_logo.png",
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: _brands.length,
          itemBuilder: (context,index){
            final brandIndex = _brands[index];
            return SingleChildScrollView(scrollDirection: Axis.horizontal,child: ButtonSubtitle(name: brandIndex['name'],url: brandIndex['url'],function: (){},));
          },
        ),
      ),
    );
  }
}

