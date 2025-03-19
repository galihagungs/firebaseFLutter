import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutterppkd/homepage.dart';
import 'package:firebaseflutterppkd/login.dart';
import 'package:firebaseflutterppkd/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:fluttertoast/fluttertoast.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class AuthService {
  // Mapping error message dari Firebase ke pesan yang lebih jelas
  String _handleFirebaseError(String errorCode) {
    switch (errorCode) {
      case "invalid-email":
        return "Format email tidak valid!";
      case "user-not-found":
        return "Akun tidak ditemukan, silakan daftar terlebih dahulu!";
      case "wrong-password":
        return "Password salah, coba lagi!";
      case "email-already-in-use":
        return "Email ini sudah terdaftar, silakan login!";
      case "weak-password":
        return "Gunakan password minimal 6 karakter!";
      case "too-many-requests":
        return "Terlalu banyak percobaan login, coba lagi nanti!";
      default:
        return "Terjadi kesalahan, coba lagi nanti.";
    }
  }

  // Future <String> checkAlreadyhasUser(){
  //   try {
  //     final User user ;
  //     print(user.uid.toString());
  //   } catch (e) {

  //   }
  // }

  Future<String> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        showToast("Email dan password harus diisi!");
        return "empty_fields";
      }
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      String errorMessage = _handleFirebaseError(e.code);
      showToast(errorMessage);
      return e.code;
    } catch (e) {
      showToast("Terjadi kesalahan tak terduga!");
      return "unexpected_error";
    }
  }

  Future<String> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        showToast("Email dan password harus diisi!");
        return "empty_fields";
      }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      String errorMessage = _handleFirebaseError(e.code);
      showToast(errorMessage);
    } catch (e) {
      showToast("Terjadi kesalahan tak terduga!");
      return "unexpected_error";
    }
    return "";
  }

  Future<void> signout({required BuildContext context}) async {
    // await FirebaseAuth.instance.
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
    );
  }

  Future<String> signInWithGoogle({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      // ignore: unused_local_variable
      final User? user = userCredential.user;
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      String errorMessage = _handleFirebaseError(e.code);
      showToast(errorMessage);
    } catch (e) {
      showToast("Terjadi kesalahan tak terduga!");
      return "unexpected_error";
    }
    return "";
  }
}
