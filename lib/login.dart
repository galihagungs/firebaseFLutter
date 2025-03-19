import 'package:firebaseflutterppkd/register.dart';
import 'package:firebaseflutterppkd/service/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String e = "";
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
            decoration: InputDecoration(hintText: "Password"),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () {
              AuthService().signIn(
                email: email.text,
                password: password.text,
                context: context,
              );
            },
            child: Text("Login"),
          ),
          ElevatedButton(
            onPressed: () {
              AuthService().signInWithGoogle(context: context);
            },
            child: Text("Google"),
          ),
          Text(e),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return RegisterPage();
                  },
                ),
              );
            },
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}
