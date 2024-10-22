import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoes_shop/data/sql_helper.dart';
import 'package:flutter_shoes_shop/screen/home/components/widgets/shoes_card_detail_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'new_arrivals_widget.dart';

class PopularCardWidget extends StatefulWidget {
  PopularCardWidget({super.key, required this.sizeWidget,required this.isPopular});

  final double sizeWidget;
  bool isPopular;

  @override
  State<PopularCardWidget> createState() => _PopularCardWidgetState();
}

class _PopularCardWidgetState extends State<PopularCardWidget> {

  List<Map<String, dynamic>> _shoes = [];
  int activeIndex = 0;

  @override
  void initState(){
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final data = await DBHelper.instance.getProductDetails();
    setState(() {
      _shoes = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_shoes.toString());
    return SizedBox(
      height: widget.sizeWidget,
      child:CarouselSlider.builder(
        itemCount: _shoes.isEmpty ? 1 : _shoes.length,
        itemBuilder: (context, index, realIndex) {
          if (_shoes.isEmpty) {
            return const Center(
              child: Text("No products available", style: TextStyle(fontSize: 18)),
            );  // Hiển thị thông báo nếu danh sách trống
          } else {
            final productIndex = _shoes[index];
            return widget.isPopular
                ? PopularShoesCard(
              urlImage: productIndex['Product_Image'] ?? '',
              name: productIndex['Product_Name'] ?? 'Unknown',
              price: productIndex['Price'] ?? 0,
              function: () {},
            )
                : NewsArrivalShoesCard(
              urlImage: productIndex['Product_Image'] ?? '',
              name: productIndex['Product_Name'] ?? 'Unknown',
              price: productIndex['Price'] ?? 0,
              function: () {},
            );
          }
        },
        options: CarouselOptions(
          onPageChanged: (index, reason) {
            setState(() {
              activeIndex = index;
            });
          },
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.antiAlias,
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 2),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          aspectRatio: 16 / 9,
          viewportFraction: widget.isPopular ? 0.35 : 1,
        ),
      ),
    );
  }
}

