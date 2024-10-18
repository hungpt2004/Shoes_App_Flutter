import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoes_shop/screen/login/components/form_login.dart';
import 'package:flutter_shoes_shop/screen/onboard/components/onboard.dart';
import 'package:flutter_shoes_shop/utils/slide_page_route_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final List<String> _url = [
    "assets/images/nike/nike.png",
    "assets/images/puma/puma.jpg",
    "assets/images/converse/converse_logo.png",
    "assets/images/adidas/adidas.jpg",
    "assets/images/under/under_amour.png"
  ];

  bool isLoad = false;
  bool isSelected = false;
  int activeIndex = 0;
  int dotSize = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () => setState(() {
                isSelected = !isSelected;
              }),
              child: Container(
                width: 300,
                height: 400,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/images/logo_app.png"),
                      fit: BoxFit.cover),
                ),
                child: AnimatedAlign(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  alignment: isSelected
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight, //bool default is true
                  child: Container(
                    width: 130,
                    height: 250,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images/onboard2.png"),
                            fit: BoxFit.contain)),
                  ),
                ),
              ),
            ),
            CarouselSlider.builder(
                itemCount: _url.length,
                itemBuilder: (context, index, realIndex) {
                  final urlIndex = _url[index];
                  return _cardBrand(urlIndex);
                },
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  viewportFraction:
                  0.5, // Điều chỉnh này có thể thay đổi để phù hợp với thiết kế của bạn
                  enlargeCenterPage: true, // Tắt phóng to trang ở giữa
                )),
            //DOT
            AnimatedSmoothIndicator(
              duration: const Duration(milliseconds: 800),
              activeIndex: activeIndex,
              count: dotSize,
              effect: const WormEffect(
                activeDotColor: Colors.black,
                dotHeight: 5,
                dotWidth: 10,
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll(Colors.white),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                          color: isLoad
                              ? Colors.indigo.withOpacity(0.5)
                              : Colors.black))),
                  fixedSize: const WidgetStatePropertyAll(Size(200.0, 50.0)),
                ),
                onPressed: isLoad ? null : _startLoad,
                child: isLoad
                    ? SizedBox(
                    width: double.infinity,
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: LoadingAnimationWidget.inkDrop(
                              color: Colors.black, size: 25),
                        ),
                        const Text(
                          "Please wait...",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ))
                    : const Text(
                  "Get Started",
                  style: TextStyle(color: Colors.black,fontSize: 16),
                ))


          ],
        ),
      ),
    );
  }
  //Loading function
  _startLoad() async {
    setState(() {
      isLoad = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isLoad = false;
    });
    Navigator.push(context, createSlideTransitions(newPage: const Onboard(), x: 1.0, y: 0.0));
  }

}

Widget _cardBrand(String urlImage) {
  return Container(
    width: 120,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(urlImage))),
  );
}