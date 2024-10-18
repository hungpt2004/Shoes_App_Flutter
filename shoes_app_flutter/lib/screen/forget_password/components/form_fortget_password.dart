import 'package:flutter/material.dart';

import 'package:flutter_shoes_shop/theme/style_color.dart';
import 'package:flutter_shoes_shop/theme/style_text.dart';


class FormFortgetPassword extends StatefulWidget {
  const FormFortgetPassword({super.key});

  @override
  State<FormFortgetPassword> createState() => _FormFortgetPasswordState();
}

class _FormFortgetPasswordState extends State<FormFortgetPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool hiddenPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: StyleColor.backgroundColor,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Image.asset(
                "assets/images/icons/apps-circle.png",
                width: double.infinity,
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Recovery Password",
                style: StyleText.styleAirbnb(
                    28, FontWeight.w500, StyleColor.darkBlueColor),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Please Enter Your Email Address To",
                style: StyleText.styleAirbnb(
                    16, FontWeight.w400, StyleColor.blueGreyColor),
              ),
              Text(
                "Recieve a Verification Code",
                style: StyleText.styleAirbnb(
                    16, FontWeight.w400, StyleColor.blueGreyColor),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email Address",
                        style: StyleText.styleAirbnb(
                            16, FontWeight.w500, StyleColor.darkBlueColor),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please input email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: (" Enter your email..."),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: TextButton.styleFrom(
                              backgroundColor: StyleColor.lightBlueColor,
                            ),
                            onPressed: onTapForgetPasswordInput,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "Continue",
                                style: StyleText.styleAirbnb(
                                    18, FontWeight.w500, Colors.white),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapForgetPasswordInput() async {
    if (_formKey.currentState!.validate()) {

    } else {
      print('Form is not valid');
    }
  }
}
