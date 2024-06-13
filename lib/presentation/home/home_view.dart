import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_firebase/presentation/home/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          Obx(() {
            return Text(controller.docData.value);
          }),
          ElevatedButton(
            onPressed: () => controller.addData(),
            child: Text("Add Data"),
          )
        ],
      ),
    );
  }
}
