import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sample_firebase/config/local_notification_service.dart';
import 'package:sample_firebase/config/notification_config.dart';
import 'package:sample_firebase/config/page.dart';
import 'package:sample_firebase/config/routes.dart';
import 'package:sample_firebase/firebase_options.dart';

bool shouldUseFirebaseEmulator = false;

late final FirebaseApp app;
late final FirebaseAuth auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseOption = DefaultFirebaseOptions.currentPlatform;
  app = await Firebase.initializeApp(
    options: firebaseOption,
  );
  auth = FirebaseAuth.instanceFor(app: app);

  if (shouldUseFirebaseEmulator) {
    await auth.useAuthEmulator('localhost', 8080);
  }

  await NotifConfig.initialize();

  await LocalNotificationService.flutterLocalNotificationsPlugin.initialize(
    LocalNotificationService.initializationSettings,
    onDidReceiveNotificationResponse: (details) {
      print(details);
    },
  );
  if (Platform.isAndroid) {
    await LocalNotificationService.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  } else if (Platform.isIOS) {
    await LocalNotificationService.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  } else {
    log('Platform is not registered');
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Dicoding Flutter Pemula",
      initialRoute: Routes.ONBOARDING,
      getPages: Pages.routes,
    );
  }
}
