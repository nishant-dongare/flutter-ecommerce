import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/userCubit.dart';
import 'package:test/widgets/show_alert.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                style: const TextStyle(height: 1),
                keyboardType: TextInputType.emailAddress,
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
              Column(
                children: [
                  TextField(
                    style: const TextStyle(height: 1),
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    decoration: InputDecoration(
                      label: const Text("Password"),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if(usernameController.text.isEmpty||passwordController.text.isEmpty){
                        showAlert(context: context, message: "Please enter both username and password.");
                        return;
                      }
                      String response = await BlocProvider.of<UserCubit>(context).login(
                          username: usernameController.text,
                          password: passwordController.text);

                      if(response.isNotEmpty){
                          showAlert(context: context, message: response);
                      }
                      if (BlocProvider.of<UserCubit>(context).state.token !=
                          null) {
                        //print(BlocProvider.of<UserCubit>(context).state.token);
                        Navigator.pushReplacementNamed(context, '/');
                      }
                    },
                    child: const Text('Sign In'),
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
                      Navigator.pushReplacementNamed(context, 'register'),
                  child: const Text('Not a user? Register Here'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
