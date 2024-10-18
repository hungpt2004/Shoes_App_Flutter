import 'package:flutter/material.dart';
import 'package:flutter_shoes_shop/screen/login/components/form_login.dart';
import 'package:flutter_shoes_shop/screen/onboard/widgets/onboard_title.dart';
import 'package:flutter_shoes_shop/screen/register/components/form_register.dart';
import 'package:flutter_shoes_shop/theme/style_color.dart';
import 'package:flutter_shoes_shop/utils/slide_page_route_widget.dart';

import '../widgets/onboard_image.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardOneState();
}

class _OnboardOneState extends State<Onboard> {

  int currentOnboard = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: StyleColor.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(flex: 1, child: Text(""),),
            OnboardImage(currentOnboard: currentOnboard,),
            OnboardTitle(currentOnboard: currentOnboard,),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Nếu bạn muốn căn giữa
                    children: List.generate(3, (index) {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            currentOnboard = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300), // Thay đổi sang milliseconds
                          width: index == currentOnboard ? 40 : 8,
                          height: 8,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index == currentOnboard
                                ? StyleColor.lightBlueColor
                                : StyleColor.paleBlueColor, // Cập nhật lại để dùng index
                          ),
                        ),
                      );
                    }),
                  ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200), // Thay đổi thời gian phù hợp
                      curve: Curves.bounceInOut, // Chọn kiểu hoạt hình
                      height: currentOnboard == 0 ? 60 : 60, // Thay đổi chiều cao tùy vào currentOnboard
                      width: currentOnboard == 0 ? 185 : 115, // Thay đổi chiều rộng tùy vào currentOnboard
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: StyleColor.lightBlueColor,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (currentOnboard < 2) {
                              setState(() {
                                currentOnboard++;
                              });
                          }else{
                            Navigator.push(context,
                                createSlideTransitions(
                                    newPage: const FormLogin(),
                                    x: 1.0,
                                    y: 0.0,
                                ),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Text(
                            currentOnboard == 0 ? "Get Started" : "Next",
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "Airbnb",
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
