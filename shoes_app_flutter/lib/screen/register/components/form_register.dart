import 'package:flutter/material.dart';
import 'package:flutter_shoes_shop/screen/register/widgets/move_signin.dart';
import 'package:flutter_shoes_shop/screen/register/widgets/signin_google.dart';
import 'package:flutter_shoes_shop/screen/register/widgets/signin_input.dart';
import 'package:flutter_shoes_shop/theme/scaffold_messenger.dart';
import 'package:flutter_shoes_shop/theme/style_color.dart';
import 'package:flutter_shoes_shop/theme/style_text.dart';

import '../../../data/sql_helper.dart';
import '../../../models/account.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                "Create Account",
                style: StyleText.styleAirbnb(28, FontWeight.w500, StyleColor.darkBlueColor),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Let's Create Account Together",
                style: StyleText.styleAirbnb(16, FontWeight.w400, StyleColor.blueGreyColor),
              ),
              const SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Name",
                        style:  StyleText.styleAirbnb(16, FontWeight.w500, StyleColor.darkBlueColor),
                      ),
                      const SizedBox(height: 5,),
                      TextFormField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Please input your name';
                          } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return 'Please enter a valid name (letters only)';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: (" Enter your name..."),
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
                      const SizedBox(height: 30,),
                      Text(
                        "Email Address",
                        style: StyleText.styleAirbnb(16, FontWeight.w500, StyleColor.darkBlueColor),
                      ),
                      const SizedBox(height: 5,),
                      TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Please input email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
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
                      const SizedBox(height: 30,),
                      Text(
                        "Password",
                        style: StyleText.styleAirbnb(16, FontWeight.w500, StyleColor.darkBlueColor),
                      ),
                      const SizedBox(height: 5,),
                      TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        obscureText: hiddenPassword,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please input password';
                          }else if(value.length < 8){
                            return 'Password must be at least 8 characters long';
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hiddenPassword = !hiddenPassword;
                                });
                              },
                              icon: hiddenPassword
                                  ? const Icon(Icons.visibility_off_outlined)
                                  : const Icon(Icons.visibility_outlined)),
                          hintText: (" Enter your password..."),
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
                      const SizedBox(height: 30,),
                      SigninInput(onTap: onTapSigninInput),
                      const SizedBox(height: 30,),
                      SigninGoogle(onTap: (){}),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50,),
              MoveSignin(
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void onTapSigninInput() async {
    if (_formKey.currentState!.validate()) {
      try {
        Account account = Account.signin(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text
        );
        // Lưu tài khoản vào cơ sở dữ liệu
        int id = await DBHelper.createAccount(account.toMap());
        ShowScaffoldMessenger.showScaffoldMessengerSuccessfully(context, "Create account successfully!");
        if (id > 0) {
          print('Account created successfully with ID: $id');
          nameController.clear();
          emailController.clear();
          passwordController.clear();
        } else {
          print('Failed to create account');
        }
      } catch (e) {
        print('Error creating account: $e');
      }
    } else {
      print('Form is not valid');
    }
  }
}
