// import 'dart:convert';
//
// import 'package:connect_well/splash_view.dart';
// import 'package:connect_well/ui/Login/Model/UserModel.dart';
// import 'package:connect_well/utils/colours.dart';
// import 'package:connect_well/utils/constant.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'custom/pushnotification_service.dart';
// import 'custom/titleTextView.dart';
// import 'globalVariable.dart';
// import 'localization/languageTranslation.dart';
// import 'localization/preferences.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await allTranslations.init();
//   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
//   await PushNotificationService().setupInteractedMessage();
//   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
//     runApp(
//       const MyApp(),
//     );
//   });
// }
//
// class MyApp extends StatefulWidget {
//   static const exitTimeInMillis = 2000;
//
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   int _lastTimeBackButtonWasTapped = 0;
//   bool isNotification = false;
//
//   @override
//   void initState() {
//     aaa();
//     super.initState();
//   }
//
//   Future<void> aaa() async {
//     UserModel? userModel;
//     var temp = await preferences.getPreference(PreferenceKey.USER_DATA, '');
//     if (temp != null && temp.toString().isNotEmpty) {
//       userModel = UserModel.fromJson(json.decode(temp));
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: onWillPop,
//       child: MaterialApp(
//         navigatorKey: GlobalVariable.navState,
//         color: Color(primaryColor),
//         debugShowCheckedModeBanner: false,
//         home: const SafeArea(
//           top: false,
//           bottom: false,
//           child: Scaffold(body: SplashView()),
//         ),
//       ),
//     );
//   }
//
//   Future<bool> onWillPop() async {
//     final _currentTime = DateTime.now().millisecondsSinceEpoch;
//
//     if ((_currentTime - _lastTimeBackButtonWasTapped) <
//         MyApp.exitTimeInMillis) {
//       ScaffoldMessenger.of(context).removeCurrentSnackBar();
//
//       return true;
//     } else {
//       _lastTimeBackButtonWasTapped = DateTime.now().millisecondsSinceEpoch;
//       ScaffoldMessenger.of(context).removeCurrentSnackBar();
//       ScaffoldMessenger.of(context).showSnackBar(
//         _getExitSnackBar(context),
//       );
//       return false;
//     }
//   }
//
//   SnackBar _getExitSnackBar(
//       BuildContext contex,
//       ) {
//     return SnackBar(
//       content: TitleTextView(
//         "Press back again to exit!",
//         color: Color(whiteColor),
//       ),
//       backgroundColor: Color(primaryColor),
//       duration: const Duration(
//         seconds: 2,
//       ),
//       behavior: SnackBarBehavior.floating,
//     );
//   }
// }

import 'dart:io';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:connect_well/ui/SplashView/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom/pushnotification_service.dart';
import 'localization/languageTranslation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyCfkZwnU66NePQhTVt0Lzt7kK-i1pql6b4",
            appId: "1:218668020431:android:b07f6ac578ce5954acbdba",
            messagingSenderId: "218668020431",
            projectId: "connect-well-aa75f",
          ),
        )
      : await Firebase.initializeApp();
  // await allTranslations.init();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  await PushNotificationService().setupInteractedMessage();
  PushNotificationService().requestNotificationPermission();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
