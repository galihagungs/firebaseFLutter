import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutterppkd/service/auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              FirebaseAuth.instance.currentUser!.email!.toString(),
              style: TextStyle(fontSize: 25),
            ),
            // Text(
            //   FirebaseAuth.instance.currentUser!.emailVerified.toString(),
            //   style: TextStyle(fontSize: 25),
            // ),
            ElevatedButton(
              onPressed: () {
                AuthService().signout(context: context);
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
