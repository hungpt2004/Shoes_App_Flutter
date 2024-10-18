import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoes_shop/data/bloc/auth_bloc/auth_state.dart';
import 'package:flutter_shoes_shop/screen/forget_password/components/form_fortget_password.dart';
import 'package:flutter_shoes_shop/screen/register/components/form_register.dart';
import 'package:flutter_shoes_shop/theme/scaffold_messenger.dart';
import 'package:flutter_shoes_shop/utils/slide_page_route_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../data/bloc/auth_bloc/auth_bloc.dart';
import '../../../theme/style_color.dart';
import '../../../theme/style_text.dart';
import '../../register/widgets/signin_google.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); //Form management
  bool isObsecure = true;
  bool isLoadButton = false;
  final USERNAME_HINT = 'Enter your email...';
  final PASSWORD_HINT = 'Enter your password...';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: StyleColor.backgroundColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is LoginSuccess) {
            // LoginBloc.login(context, _usernameController.text, _passwordController.text);
            ShowScaffoldMessenger.showScaffoldMessengerSuccessfully(
                context, "Login Successfully");
          } else if (state is LoginFailure) {
            print("LOGIN FAILD");
            ShowScaffoldMessenger.showScaffoldMessengerUnsuccessfully(
                context, "Login Failed! Can you login again");
          }
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _space(10, 0),
                  _backButton(context),
                  _space(30, 0),
                  _textTitle(),
                  _textSubTitle(),
                  _space(50, 0),
                  //FORM USERNAME
                  _textLabel("Email Address"),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white60),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Please enter username';
                          } else if (value.length < 3) {
                            return 'Username can not less than 3 characters';
                          } else {
                            return null;
                          }
                        },
                        controller: _usernameController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none),
                          hintText: USERNAME_HINT,
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  _space(20, 0),
                  //FORM PASSWORD
                  _textLabel("Password"),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        } else if (value.length < 8) {
                          return 'Password can not less than 8 characters';
                        } else {
                          return null;
                        }
                      },
                      controller: _passwordController,
                      obscureText: isObsecure,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 16, top: 10, bottom: 10),
                        border: OutlineInputBorder(
                            gapPadding: 50,
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                        hintText: PASSWORD_HINT,
                        suffixIcon: IconButton(
                            onPressed: () {
                              print(isObsecure);
                              setState(() {
                                isObsecure = !isObsecure;
                              });
                            },
                            icon: Icon(
                              isObsecure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            )),
                        filled: true,
                        fillColor: Colors.white, // Màu nền của TextFormField
                      ),
                    ),
                  ),
                  _forgotPassword(context),
                  //PASSWORD FIELD
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _startLoad(context);
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(StyleColor.lightBlueColor),
                        fixedSize: WidgetStatePropertyAll(Size(200.0, 50.0)),
                        elevation: WidgetStatePropertyAll(4),
                      ),
                      child: isLoadButton
                          ? SizedBox(
                              width: double.infinity,
                              height: 20,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    child: LoadingAnimationWidget.inkDrop(
                                        color: Colors.white, size: 20),
                                  ),
                                   Text(
                                    "Please wait...",
                                    style: StyleText.styleAirbnb(18, FontWeight.w500, Colors.white),
                                  ),
                                ],
                              ))
                          :  Text(
                              "Sign In",
                              style: StyleText.styleAirbnb(18, FontWeight.w500, Colors.white),
                            ),
                    ),
                  ),
                  _space(30, 0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SigninGoogle(onTap: () {}),
                  ),
                  _space(80, 0),
                  _signUpQuestion(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Loading function
  _startLoad(BuildContext context) async {
    setState(() {
      isLoadButton = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isLoadButton = false;
    });
    AuthBloc.login(context, _usernameController.text, _passwordController.text);
  }
}

Widget _space(double? height, double? width) {
  return SizedBox(
    height: height,
    width: width,
  );
}

Widget _textLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Text(
      text,
      style:
          StyleText.styleAirbnb(16, FontWeight.w500, StyleColor.darkBlueColor),
    ),
  );
}

Widget _signUpQuestion(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Don't Have An Account?",
        style: StyleText.styleAirbnb(
            14, FontWeight.w400, StyleColor.blueGreyColor),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(context,
              createSlideTransitions(newPage: FormRegister(), x: 1.0, y: 0.0));
        },
        child: Text(
          " Sign Up For Free",
          style: StyleText.styleAirbnb(
              14, FontWeight.w500, StyleColor.darkBlueColor),
        ),
      ),
    ],
  );
}

Widget _textTitle() {
  return Center(
    child: Text("Hello Again!",
        style: StyleText.styleAirbnb(
            28, FontWeight.w500, StyleColor.darkBlueColor)),
  );
}

Widget _textSubTitle() {
  return Center(
      child: Text(
    "Welcome Back You've Been Missed!",
    style: StyleText.styleAirbnb(16, FontWeight.w400, StyleColor.blueGreyColor),
  ));
}

Widget _backButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 25,
              offset: const Offset(0, 1))
        ]),
        child: ElevatedButton(
            style: const ButtonStyle(
                shape:
                    WidgetStatePropertyAll(CircleBorder(side: BorderSide.none)),
                backgroundColor: WidgetStatePropertyAll(Colors.white),
                visualDensity: VisualDensity(horizontal: 1, vertical: 1)),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                Icons.arrow_back_ios,
                size: 13,
                color: Colors.black,
              ),
            )),
      ),
    ],
  );
}

Widget _forgotPassword(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
            onPressed: () {
              Navigator.push(context, createSlideTransitions(newPage: FormFortgetPassword(), x: 1.0, y: 0.0));
            },
            child: Text(
              "Recovery password",
              style: StyleText.styleAirbnb(14, FontWeight.w500, StyleColor.blueGreyColor),),
            ),
      ],
    ),
  );
}
