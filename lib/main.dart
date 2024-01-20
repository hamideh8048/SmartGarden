import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:samrt_garden/screen/AddGardenScreen.dart';
import 'package:samrt_garden/screen/ChangePasswordScreen.dart';
import 'package:samrt_garden/screen/InsertNewGarden.dart';
import 'package:samrt_garden/screen/PlantDetailsScreen.dart';
import 'package:samrt_garden/screen/SplashScreen.dart';
import 'package:samrt_garden/screen/otpScreen.dart';
import 'package:samrt_garden/screen/testUI.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'my_foreground', // id
      'MY FOREGROUND SERVICE', // title
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  if (Platform.isIOS) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: IOSInitializationSettings(),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: false,
      isForegroundMode: false,
      autoStartOnBoot:false,

      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'سرویس مادالایتینگ',
      initialNotificationContent: '',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );

  service.startService();
}

@pragma('vm:entry-point')
bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.show(
    1,
    'Hello',
    'From Background',
    const NotificationDetails(
      iOS: IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    ),
  );

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // AudioPlayer audioPlayer = AudioPlayer();
  // var tServer = TServer(audioPlayer,AssetSource('sound/alarm.wav'));
  // tServer.startServer();
  // tServer.timerUDP();
  // WidgetsFlutterBinding.ensureInitialized();
  // globals.service = FlutterBackgroundService();

  // service.on('stopService').listen((event) {
  //   tServer.stopServer();
  // });
  //
  // service.on('startService').listen((event) {
  //   print('action : startService');
  //   tServer.startServer();
  // });


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        fontFamily: 'myFont',
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.green),
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.green),
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
        ),
      ),
      home:
      //PlantDetailsScreen()
     // AddGardenScreen()
   //ChangePasswordScreen()
     // InsertNewGarden()
 SplashScreen(),
     // OTPScreen()
    );
  }
}


