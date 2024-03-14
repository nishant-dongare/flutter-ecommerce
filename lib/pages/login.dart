import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/userCubit.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    
    TextEditingController usernameController = TextEditingController();
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
                keyboardType: TextInputType.emailAddress,
                controller: usernameController,
                decoration: const InputDecoration(label: Text('Email')),
              ),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                decoration: const InputDecoration(label: Text('Password')),
              ),
              ElevatedButton(
                onPressed: () async {
                  //log(emailController.text+passwordController.text);
                  await BlocProvider.of<UserCubit>(context).login(username: usernameController.text, password: passwordController.text);
                  if(BlocProvider.of<UserCubit>(context).state.token != null){
                    //print(BlocProvider.of<UserCubit>(context).state.token);
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
