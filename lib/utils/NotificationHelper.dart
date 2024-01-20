import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Initialize notification
  initializeNotification() async {
    _configureLocalTimeZone();
    const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("@mipmap/green_chall_logo");

    const InitializationSettings initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /// Set right date and time for notifications
  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    print('scheduleDate  :::  ${scheduleDate.year}   ${scheduleDate.month}  ${scheduleDate.day}  ${scheduleDate.hour}  ${scheduleDate.minute}');
    // if (scheduleDate.isBefore(now)) {
    //   scheduleDate = scheduleDate.add(Duration(days: 0, hours: 0, minutes: 1, seconds: 2, milliseconds: 30, microseconds: 10));
    // }
    return scheduleDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    print('timeZone ::: ${timeZone}');
    tz.setLocalLocation(tz.getLocation(timeZone));
    print('timeZone location ::: ${tz.getLocation(timeZone).name}   ${tz.getLocation(timeZone).currentTimeZone}');
  }

  /// Scheduled Notification
  scheduledNotification({
    required int hour,
    required int minutes,
    required int id,
    required String sound,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'به گلدان خود سر بزنید',
      'زمان تغییر آب گلدان است!',
      _convertTime(hour, minutes),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id $sound',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound(sound),
        ),
        iOS: IOSNotificationDetails(sound: '$sound.mp3'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'It could be anything you pass',
    );



    // await flutterLocalNotificationsPlugin.periodicallyShow(id, 'title', 'description', RepeatInterval.hourly, NotificationDetails(
    //   android: AndroidNotificationDetails(
    //     'your channel id $sound',
    //     'your channel name',
    //     channelDescription: 'your channel description',
    //     importance: Importance.max,
    //     priority: Priority.high,
    //     sound: RawResourceAndroidNotificationSound(sound),
    //   ),
    //   iOS: IOSNotificationDetails(sound: '$sound.mp3'),
    // ));

  }

  /// Request IOS permissions
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  cancelAll() async => await flutterLocalNotificationsPlugin.cancelAll();
  cancel(id) async => await flutterLocalNotificationsPlugin.cancel(id);
}