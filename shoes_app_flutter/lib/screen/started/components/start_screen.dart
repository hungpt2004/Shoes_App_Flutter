import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../login/components/login_screen.dart';

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
    // Lấy kích thước màn hình hiện tại
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () => setState(() {
                  isSelected = !isSelected;
                }),
                child: Container(
                  width: screenWidth * 0.8, // Chiếm 80% chiều rộng màn hình
                  height: screenHeight * 0.5, // Chiếm 40% chiều cao màn hình
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
                      width: screenWidth * 0.4, // Chiếm 40% chiều rộng màn hình
                      height: screenHeight * 0.25, // Chiếm 25% chiều cao màn hình
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/images/onboard2.png"),
                              fit: BoxFit.contain)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: CarouselSlider.builder(
                  itemCount: _url.length,
                  itemBuilder: (context, index, realIndex) {
                    final urlIndex = _url[index];
                    return _cardBrand(urlIndex, screenWidth);
                  },
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                  )),
            ),
            // DOT indicator
            Expanded(
              flex: 1,
              child: AnimatedSmoothIndicator(
                duration: const Duration(milliseconds: 800),
                activeIndex: activeIndex,
                count: _url.length,
                effect: const WormEffect(
                  activeDotColor: Colors.black,
                  dotHeight: 5,
                  dotWidth: 10,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1, vertical: screenHeight * 0.1), // padding 10% của chiều rộng
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    const WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                            color: isLoad
                                ? Colors.black
                                : Colors.black))),
                    fixedSize: WidgetStatePropertyAll(Size(
                        screenWidth * 0.5, 50)), // Chiếm 50% chiều rộng màn hình
                  ),
                  onPressed: isLoad ? null : _startLoad,
                  child: isLoad
                      ? const SizedBox(
                      width: double.infinity,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            )
                          ),
                          Text(
                            "Please wait...",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )
                        ],
                      ))
                      : const Text(
                    "Get Started",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )),
            ),

          ],
        ),
      ),
    );
  }

  // Loading function
  _startLoad() async {
    setState(() {
      isLoad = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isLoad = false;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}

Widget _cardBrand(String urlImage, double screenWidth) {
  return Container(
    width: screenWidth * 0.3, // Chiếm 30% chiều rộng màn hình
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(urlImage), fit: BoxFit.contain)),
  );
}
