import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_firebase/presentation/onboarding/onboarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text('Email'),
              subtitle: TextField(
                controller: controller.emailTEC,
              ),
            ),
            ListTile(
              title: Text('Password'),
              subtitle: TextField(
                controller: controller.passwordTEC,
              ),
            ),
            ElevatedButton(
              onPressed: () => controller.loginApp(),
              child: Text("Login"),
            ),
            ElevatedButton(
              onPressed: () => controller.registerApp(),
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
