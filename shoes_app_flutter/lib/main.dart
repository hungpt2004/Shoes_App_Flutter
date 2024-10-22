import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoes_shop/data/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_shoes_shop/screen/home/components/home_screen.dart';
import 'package:flutter_shoes_shop/screen/home/components/widgets/navbar_widget.dart';
import 'package:flutter_shoes_shop/screen/login/components/form_login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Database Test',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BottomNavbar(),
        ));
  }
}
