import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/userCubit.dart';
import 'package:test/widgets/show_alert.dart';

class Register extends StatelessWidget {


  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: SizedBox(
          height: 400,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                style: const TextStyle(height: 1),
                controller: usernameController,
                decoration: InputDecoration(
                  label: const Text("Username"),
                  border: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.redAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              TextField(
                style: const TextStyle(height: 1),
                controller: passwordController,
                decoration: InputDecoration(
                  label: const Text("Password"),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async{
                      if(usernameController.text.isEmpty||passwordController.text.isEmpty){
                        showAlert(context: context, message: "Please enter both username and password.");
                        return;
                      }
                      String response = await BlocProvider.of<UserCubit>(context).register(username: usernameController.text, password: passwordController.text);
                      if(response.isNotEmpty){
                        showAlert(context: context, message: response);
                      }
                      if(BlocProvider.of<UserCubit>(context).state.user?.id != null){
                        Navigator.pushNamed(context, '/');
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/'),
                    child: const Text('Guest '),
                  ),
                ],
              ),
              Center(
                //alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, 'login'),
                  child: const Text('Already a user? Sign In'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
