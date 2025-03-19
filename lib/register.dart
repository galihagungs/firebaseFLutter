import 'package:firebaseflutterppkd/service/auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: email,
            decoration: InputDecoration(hintText: "Email"),
          ),
          TextField(
            controller: password,
            obscureText: true,
            decoration: InputDecoration(hintText: "Password"),
          ),
          ElevatedButton(
            onPressed: () async {
              await AuthService().signUp(
                email: email.text,
                password: password.text,
                context: context,
              );
            },
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}
