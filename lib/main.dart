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
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              color: Colors.white,
            )
          ),
          elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.black),
              foregroundColor: MaterialStatePropertyAll(Colors.white),
            )
          ),
          textSelectionTheme: const TextSelectionThemeData( cursorColor: Colors.blueGrey),
          useMaterial3: true,
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.black,
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: Colors.black,
            error: Colors.red,
            onError: Colors.white,
            background: Colors.white,
            onBackground: Colors.black,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
        ),

        initialRoute: 'login',
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
