import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {

  static int _notificationsCounter = 0;


  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Notifications() {
    _loadNotificationsSettings();
  }

  void _loadNotificationsSettings() {
    const androidInitialize =  AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOSInitialize = DarwinInitializationSettings(
      requestAlertPermission : false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initializationSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification({ required String title, required String body, String? subTitle}) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channelId',
      'Local Notification',
      channelDescription: 'This is a channel for local notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      subtitle: subTitle,
      threadIdentifier: 'thread_id',
    );
    await flutterLocalNotificationsPlugin.show(
      _notificationsCounter++,
      title,
      body,
      NotificationDetails(android: androidDetails, iOS: iosDetails),
    );
  }

}