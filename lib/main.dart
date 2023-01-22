import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Screens/splash_screen.dart';
import 'Utils/pref_manager.dart';
import 'Utils/theme.dart';
import 'notifications/pushNotification_serviced.dart';
import 'pages/page_route.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await Preferences.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await PushNotificationService().setupInteractedMessage();
  HttpOverrides.global = MyHttpOverrides();
  GetStorage.init();
  await ScreenUtil.ensureScreenSize();
  runApp(
    // ShowCaseWidget(
    //   autoPlay: false,
    //   autoPlayDelay: Duration(seconds: 8),
    //   autoPlayLockEnable: false,
    //   builder: Builder(
    //     builder: (context) =>
    MyApp(),
    //   ),
    //   onStart: (index, key) {
    //     print('onStart: $index, $key');
    //   },
    //   onComplete: (index, key) {
    //     print('onComplete: $index, $key');
    //   },
    // ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  // final FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: SplashScreen(),
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeService().theme, // add this
        debugShowCheckedModeBanner: false,
        getPages: AppPages.pages,
        builder: (context, child) {
          final mediaQueryData = MediaQuery.of(context);
          final scale = mediaQueryData.textScaleFactor.clamp(0.9, 1.0);
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
              child: child!);
        });
  }
}
