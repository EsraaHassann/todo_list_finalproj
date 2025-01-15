// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;


// class NotificationService {
//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService;
//   }

//   NotificationService._internal();

//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> initialize() async {
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('app_icon'); // Replace with your app icon asset name

//     const InitializationSettings initializationSettings =
//         InitializationSettings(android: androidInitializationSettings);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime scheduledTime,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'your_channel_id', // channel id
//       'your_channel_name', // channel name
//       importance: Importance.high,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);

//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.from(scheduledTime, tz.local), // Correct timezone handling
//       notificationDetails,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }

//   Future<void> cancelNotification(int id) async {
//     await flutterLocalNotificationsPlugin.cancel(id);
//   }
// }

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('app_icon'); // Replace with your app icon asset name

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your_channel_id', // channel id
      'your_channel_name', // channel name
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      // Use `priority` for handling idle notifications if necessary
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    // Correct timezone handling and add the required `androidScheduleMode`
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local), // Correct timezone handling
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact, // Add this if required
      matchDateTimeComponents: DateTimeComponents.time,
      // Removing androidAllowWhileIdle since it's causing issues
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}

