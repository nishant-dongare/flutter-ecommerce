import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/pages/HomePage.dart';
import 'package:test/pages/cart.dart';
import 'package:test/pages/login.dart';
import 'package:test/pages/register.dart';

import 'cubit/userCubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>UserCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          'login': (context) => const Login(),
          'register': (context) => const Register(),
          'cart': (context) => const Cart(),
        },
      ),
    );
  }
}
