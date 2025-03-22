import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoes_shop/constant.dart';
import 'package:flutter_shoes_shop/screen/home/components/widgets/button_category_widget.dart';
import 'package:flutter_shoes_shop/screen/home/components/widgets/header_widget.dart';
import 'package:flutter_shoes_shop/screen/home/components/widgets/navbar_widget.dart';
import 'package:flutter_shoes_shop/screen/home/components/widgets/popular_shoes_widget.dart';
import 'package:flutter_shoes_shop/screen/home/components/widgets/search_widget.dart';
import 'package:flutter_shoes_shop/theme/style_space.dart';
import 'package:path/path.dart';
import '../../../data/sql_helper.dart';
import '../../../theme/style_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> shoes = [];
  int activeIndex = 0;
  bool isLoading = false;
  String selectedBrand = "ALL";

  @override
  void initState() {
    super.initState();
    _startLoad();
  }

  _startLoad() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
      fetchDataShoes();
    }); // Fetch all products initially
  }


  void chooseBrand(String brand){
    setState(() {
      selectedBrand = brand;
      refresh();
    });
  }

  Future<void> fetchDataShoes() async {
    final data = selectedBrand == "ALL" ? await DBHelper.instance.getProductDetails() : await DBHelper.instance.getProductByBrand(selectedBrand);
    setState((){
      print(selectedBrand);
      shoes = data;
    });
  }

  void refresh(){
    fetchDataShoes();
  }


  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            backgroundColor: StyleColor.backgroundColor,
            body: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
                StyleSpace.space(0, 20),
                Text(
                  "Wait a few second !",
                  style: StyleText.styleAirbnb(
                      18, FontWeight.w400, Colors.blueAccent),
                )
              ],
            )),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: StyleColor.backgroundColor,
            body: ListView(
              children: [
                const HeaderWidget(),
                StyleSpace.space(24, 0),
                const SearchWidget(),
                StyleSpace.space(32, 0),
                ButtonCategoryWidget(
                  onBrandSelected: chooseBrand,
                  selectedBrand: selectedBrand,
                ),
                StyleSpace.space(24, 0),
                _seeAll("Popular Shoes"),
                StyleSpace.space(16, 0),
                PopularCardWidget(
                  shoes: shoes,
                  selectBrand: selectedBrand,
                  sizeWidget: 201,
                  isPopular: true,
                ),
                StyleSpace.space(24, 0),
                _seeAll("New Arrivals Shoes"),
                StyleSpace.space(16, 0),
                PopularCardWidget(
                  shoes: shoes,
                  selectBrand: selectedBrand,
                  sizeWidget: 120,
                  isPopular: false,
                ),
              ],
            ),
          );
  }
}

Widget _seeAll(String title) {
  return Padding(
    padding: const EdgeInsets.only(left: 30, right: 20),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: StyleText.styleAirbnb(20, FontWeight.w500, Colors.black)),
        TextButton(
            onPressed: () {},
            child: Text("See All",
                style: StyleText.styleAirbnb(
                  12,
                  FontWeight.w400,
                  Colors.indigo,
                )))
      ],
    ),
  );
}
