import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_firebase/model/user.dart';

class HomeController extends GetxController {
  final db = FirebaseFirestore.instance;
  RxString docData = ''.obs;

  late TextEditingController nameTEC;
  late FocusNode nameFN;

  late TextEditingController ageTEC;
  late FocusNode ageFN;

  late TextEditingController addressTEC;
  late FocusNode addressFN;

  @override
  void onInit() {
    super.onInit();
    initializeNameTextField();
    initializeAgeTextField();
    initializeAddressTextField();
    readData();
  }

  void initializeNameTextField() {
    nameTEC = TextEditingController();
    nameFN = FocusNode();
  }

  void initializeAgeTextField() {
    ageTEC = TextEditingController();
    ageFN = FocusNode();
  }

  void initializeAddressTextField() {
    addressTEC = TextEditingController();
    addressFN = FocusNode();
  }

  void readData() async {
    await db.collection("user").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
        docData.value = doc.data().toString();
      }
    });
  }

  void addData() async {
// Add a new document with a generated ID
    final newUser = UserModel(
      first: "Muhammad",
      middle: "Rasyiddin",
      last: "",
      born: 1998,
    );
    db.collection("users").add(newUser.toJson()).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }
}
