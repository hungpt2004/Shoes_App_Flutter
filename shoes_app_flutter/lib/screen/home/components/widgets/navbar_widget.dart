import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoes_shop/constant.dart';
import 'package:flutter_shoes_shop/screen/home/components/home_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int currentIndex = 0;
  bool isClick = false;

  List<Widget> body = [
    const HomeScreen(),
    const Scaffold(
      body: Center(
        child: Text("Favorite"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Cart"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Notification"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Profile"),
      ),
    ),
  ];

  void _onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: body[currentIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: EdgeInsets.only(top: 20),
          width: 70,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: 60,
              height: 80,
              child: FloatingActionButton(
                backgroundColor: StyleColor.lightBlueColor,
                shape: CircleBorder(),
                elevation: 4,
                onPressed: () {},
                child: Image.asset(
                  "assets/images/icons/shopping.png",
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 4,
          height: 70,
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          padding: EdgeInsets.all(2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    _onTapped(0);
                  },
                  child: Image.asset(currentIndex == 0 ? "assets/images/icons/home_click.png" : "assets/images/icons/home.png",
                      width: 22, height: 22)),
              TextButton(
                  onPressed: () {
                    _onTapped(1);
                  },
                  child: Image.asset(currentIndex == 1 ? "assets/images/icons/heart_click.png"  : "assets/images/icons/heart.png",
                      width: 25, height: 25)),
              SizedBox(width: 30,),
              TextButton(
                  onPressed: () {
                    _onTapped(2);
                  },
                  child: Image.asset(currentIndex == 2 ? "assets/images/icons/notification_click.png"  : "assets/images/icons/notification.png",
                      width: 25, height: 25)),
              TextButton(
                  onPressed: () {
                    _onTapped(3);
                  },
                  child: Image.asset(currentIndex == 3 ? "assets/images/icons/profile_click.png" : "assets/images/icons/profile.png",
                      width: 25, height: 25)),
            ],
          ),
        ));
  }
}
