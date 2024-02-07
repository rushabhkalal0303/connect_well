import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../localization/preferences.dart';
import '../utils/commonMethods.dart';
import '../utils/constant.dart';


RemoteMessage? globalRemoteMessage;
String orderID = "";
bool isForNotification = false;

class PushNotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print("user granted the permission");
    }
    else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print("user granted the provisional permission");
    }
    else {
      print("user denided the permission");
    }
  }

  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();
    FirebaseMessaging.instance.getToken().then((value) {
      FirebaseMessaging.instance.getToken().then((value) {
        preferences.setPreference(PreferenceKey.DEVICE_TOKEN, value);
        print("-----Token");
        print("Device Token is this $value");
        log(value!);
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("FROMSIMPLENOTI====BACKGROUND");
      // UserModel? userModel;
      // var temp = await preferences.getPreference(PreferenceKey.USER_DATA, '');
      // if (temp != null && temp.toString().isNotEmpty) {
      //   userModel = UserModel.fromJson(json.decode(temp));
      // }
      //
      Future.delayed(const Duration(milliseconds: 500), () {
        // CallNextScreenAndClearStack(
        //     GlobalVariable.navState.currentContext!,
        //     NotificationView(
        //       CommonValues != null &&
        //           CommonValues.loginUserData != null &&
        //           CommonValues.loginUserData!.id != null
        //           ? CommonValues.loginUserData!.id
        //           : 0,
        //       isFromNotification: true,
        //     ));
      });
    });

    await enableIOSNotifications();
    await registerNotificationListeners();
  }


  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    print(channel.id.toString());
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var androidSettings =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSSettings = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    var initSetttings =
    InitializationSettings(android: androidSettings, iOS: iOSSettings);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: (messagee) async {
          print("FROMSIMPLENOTI====FOREGROUNF");
          // UserModel? userModel;
          // var temp = await preferences.getPreference(PreferenceKey.USER_DATA, '');
          // if (temp != null && temp.toString().isNotEmpty) {
          //   userModel = UserModel.fromJson(json.decode(temp));
          // }
          //
          Future.delayed(const Duration(milliseconds: 500), () {
            // CallNextScreenAndClearStack(
            //     GlobalVariable.navState.currentContext!,
            //     NotificationView(
            //       CommonValues != null &&
            //           CommonValues.loginUserData != null &&
            //           CommonValues.loginUserData!.id != null
            //           ? CommonValues.loginUserData!.id
            //           : 0,
            //       isFromNotification: true,
            //     ));
          });
        });

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      showNotification(message!, channel, flutterLocalNotificationsPlugin);
    });
  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message");
  AndroidNotificationChannel channel = androidNotificationChannel();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  return Future<void>.value();
}

androidNotificationChannel() => const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  importance: Importance.max,
);

void showNotification(RemoteMessage message, AndroidNotificationChannel channel,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  print("OLDNOTIFICATION");
  globalRemoteMessage = message;
  notificationCount.value = true;
  setNotificationPre();
  if (message.notification != null) {
    print("Notify Message===${message.toMap()}");
    dynamic notify = message.notification;
    if (notify != null) {
      String title = notify.title;
      String body = notify.body;
      print("Notify BODY $body");
      if (Platform.isAndroid) {
        _demoNotification(title, body, json.encode(message.data), channel,
            flutterLocalNotificationsPlugin, message);
      }
    } else if (message.data != null) {
      final dynamic data = message.data;
      print("Notification Data , $data}");
      if (data.containsKey('body')) {
        String title = data['title'];
        final dynamic msg = data['body'];
        orderID = msg.split("#").last;
        // message.notification!.android!.sound == NotificationTypes.ORDER
        //     ? isForNotification = true
        //     : null;
        ///???
        if (title == null || title.isEmpty) {
          title = "RoyaleTouche";
        }
        print("Message $message");
        _demoNotification(title, msg, json.encode(message.data), channel,
            flutterLocalNotificationsPlugin, message);
      }
    }
  }
}

setNotificationPre() async {
  await preferences.setPreference(PreferenceKey.NOTIFICATION_ALERT, true);
}

Future<void> _demoNotification(
    String title,
    String body,
    String sender,
    AndroidNotificationChannel channel,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    RemoteMessage message) async {
  print("--->>$title");
  print("--->>$body");
  print("--->>$sender");
  AndroidNotification? android = message.notification?.android;
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'channel_ID',
    channel.id,
    channelDescription: channel.description,
    importance: Importance.max,
    playSound: true,
    showProgress: true,
    priority: Priority.high,
    ticker: 'test ticker',
    icon: android?.smallIcon,
    styleInformation: BigTextStyleInformation(body),
  );

  var iOSChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
  await flutterLocalNotificationsPlugin
      .show(0, title, body, platformChannelSpecifics, payload: sender);
}
