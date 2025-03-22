import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoes_shop/data/sql_helper.dart';
import 'package:flutter_shoes_shop/screen/detail_shop/components/detail_shop_screen.dart';
import 'package:flutter_shoes_shop/screen/home/components/widgets/shoes_card_detail_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'new_arrivals_widget.dart';

class PopularCardWidget extends StatefulWidget {
  PopularCardWidget({super.key,required this.shoes, required this.sizeWidget,required this.isPopular,required this.selectBrand});

  final double sizeWidget;
  bool isPopular;
  String selectBrand;
  List<Map<String, dynamic>> shoes;

  @override
  State<PopularCardWidget> createState() => _PopularCardWidgetState();
}

class _PopularCardWidgetState extends State<PopularCardWidget> {
  int activeIndex = 0;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.sizeWidget,
      child:CarouselSlider.builder(
        itemCount: widget.shoes.isEmpty ? 1 : widget.shoes.length,
        itemBuilder: (context, index, realIndex) {
          if (widget.shoes.isEmpty) {
            return const Center(
              child: Text("No products available", style: TextStyle(fontSize: 18)),
            );  // Hiển thị thông báo nếu danh sách trống
          } else {
            final productIndex = widget.shoes[index];
            return widget.isPopular
                ? PopularShoesCard(
              urlImage: productIndex['Product_Image'] ?? '',
              name: productIndex['Product_Name'] ?? 'Unknown',
              price: productIndex['Price'] ?? 0,
              function: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailShopScreen(productId: productIndex['Product_ID'])));
              },
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

