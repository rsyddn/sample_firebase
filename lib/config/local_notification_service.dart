import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService._();

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  static const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('launch_background');

  static const DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
    onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  );

  static const InitializationSettings initializationSettings =
  InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void onDidReceiveLocalNotification(
      int id,
      String? title,
      String? body,
      String? payload,
      ) async {}

  static Future<void> show({
    required int id,
    required String title,
    required String desc,
  }) async {
    return LocalNotificationService.flutterLocalNotificationsPlugin.show(
      id,
      title,
      desc,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'chanelId',
          'chanelName',
          importance: Importance.max,
          priority: Priority.high,
          category: AndroidNotificationCategory.message,
        ),
        iOS: DarwinNotificationDetails(
          presentBadge: true,
          presentAlert: true,
          presentBanner: true,
          presentList: true,
          presentSound: true,
          interruptionLevel: InterruptionLevel.critical,
        ),
      ),
      payload: "",
    );
  }
}