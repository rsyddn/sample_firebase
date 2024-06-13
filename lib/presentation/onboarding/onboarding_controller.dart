import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_firebase/config/routes.dart';

class OnBoardingController extends GetxController {
  final db = FirebaseFirestore.instance;
  RxString docData = ''.obs;

  late TextEditingController emailTEC;
  late FocusNode emailFN;

  late TextEditingController passwordTEC;
  late FocusNode passwordFN;

  @override
  void onInit() {
    super.onInit();
    initializeEmailTextField();
    initializePasswordTextField();
  }

  void initializeEmailTextField() {
    emailTEC = TextEditingController();
    emailFN = FocusNode();
  }

  void initializePasswordTextField() {
    passwordTEC = TextEditingController();
    passwordFN = FocusNode();
  }

  void loginApp() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTEC.text,
        password: passwordTEC.text,
      );
      await credential.user!.getIdToken();
      if (credential.user != null) {
        Get.offNamed(Routes.HOME);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void registerApp() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTEC.text,
        password: passwordTEC.text,
      );
      await credential.user!.getIdToken();
      if (credential.user != null) {
        Get.offNamed(Routes.HOME);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
