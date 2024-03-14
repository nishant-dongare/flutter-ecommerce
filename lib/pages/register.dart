import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/userCubit.dart';

class Register extends StatelessWidget {


  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text('Sign In'),
      ),
      body: Center(
        child: SizedBox(
          height: 400,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(label: Text('Email')),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(label: Text('Password')),
              ),
              ElevatedButton(
                onPressed: () {
                  log("${emailController.text} ${passwordController.text}");
                  BlocProvider.of<UserCubit>(context).register(username: emailController.text, password: passwordController.text);
                  //Auth().postUser(username: emailController.text,password: passwordController.text);
                  if(BlocProvider.of<UserCubit>(context).state.user?.id != null){
                    Navigator.pushNamed(context, '/');
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
