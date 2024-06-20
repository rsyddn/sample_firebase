import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sample_firebase/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await setupFlutterNotifications();
  showFlutterNotification(message);
  log('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  ///initialize the local notifications & set onDidReceiveNotificationResponse handler
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('launch_background');

  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    ),
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
  );

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  isFlutterLocalNotificationsInitialized = true;

  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    showFlutterNotification(event);
  });
}

void onDidReceiveNotificationResponse(
  NotificationResponse notificationResponse,
) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    log('notification payload: $payload');
  }
  /*Do something when notification received*/
}

void showFlutterNotification(RemoteMessage message) {
  log('A new showFlutterNotification event was published!');
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class NotifConfig {
  static String? fcmToken = 'install ID';

  static BuildContext? _context;

  static void setContext(BuildContext context) =>
      NotifConfig._context = context;

  static checkPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
  }

  static initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // check apns for ios
    await _APNSTokenCheck();
    fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint("fcm token $fcmToken");

    if (!kIsWeb) {
      await setupFlutterNotifications();
    }
  }

  static messageHandler() {
    // from terminate state
    FirebaseMessaging.instance.getInitialMessage().then(
      (value) {
        log('A new getInitialMessage event was published!');
      },
    );

    // on foreground message
    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    // on notification tapped from background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      log('A new onMessageOpenedApp event was published!');
      try {
        /*Do something when notification received*/
      } catch (e) {
        log("failed to navigate $e");
      }
    });
  }

  static Future<void> _APNSTokenCheck() async {
    if (Platform.isIOS) {
      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        // await _firebaseMessaging.subscribeToTopic("notificationChannel");
      } else {
        await Future<void>.delayed(const Duration(seconds: 3));
        apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken != null) {}
      }
    }
  }
}
