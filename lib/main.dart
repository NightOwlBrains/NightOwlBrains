import 'package:audioplayers/audioplayers.dart';
import 'package:catch_the_monkey/Services/music_service.dart';
import 'package:catch_the_monkey/Utils/constants.dart';
import 'package:catch_the_monkey/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Screens/onboarding.dart';

late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late final AudioCache musicCache;
late final AudioPlayer instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await setLocalNotification();
  await MobileAds.instance.initialize();
  MusicService().stopAllAudio();
  MusicService().playMonkeyMusic();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => MaterialApp(
          theme: ThemeData(fontFamily: "BrownStd"),
          title: K_App_Name,
          debugShowCheckedModeBanner: false,
          home: SplashScreen()),
    ),
  );
}

Future<void> setLocalNotification() async {
  tz.initializeTimeZones();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: _initializationSettingsAndroid(),
      iOS: _initializationSettingsIOS(),
      macOS: null);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await scheduleNotification();
}

Future<void> scheduleNotification() async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'channel id',
    'channel name',
    'channel description',
    icon: '@drawable/icon',
    largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
  );
  var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      K_Have_Fun,
      K_Notification_Body,
      tz.TZDateTime.now(tz.local).add(const Duration(days: 7)),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true);
}

IOSInitializationSettings _initializationSettingsIOS() {
  return const IOSInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );
}

AndroidInitializationSettings _initializationSettingsAndroid() {
  return const AndroidInitializationSettings('@mipmap/ic_launcher');
}
