import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoes_shop/data/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_shoes_shop/data/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:flutter_shoes_shop/screen/home/components/widgets/navbar_widget.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc()),
          BlocProvider(create: (_) => FavoriteBloc())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Database Test',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const BottomNavbar(),
        ));
  }
}
