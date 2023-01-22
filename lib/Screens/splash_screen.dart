import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Screens/dashboard/dashboard.dart';
import 'package:iskcon/Screens/login/login_page.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_settings/open_settings.dart';

import '../Utils/pref_manager.dart';
import 'register/splash_video.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Preferences.init();
    super.initState();
    startTimer();
  }

  startTimer() async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      var duration = Duration(seconds: 3);
      return new Timer(duration, route);
    } else {
      Get.defaultDialog(
          title: "Oops!...",
          content: Text("Check your internet connection"),
          actions: [
            ElevatedButton(
              onPressed: () {
                exit(0);
              },
              child: Text("Exit"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: primaryColor),
              onPressed: () {
                OpenSettings.openWIFISetting();
              },
              child: Text('Open Settings'),
            ),
          ]);
    }
  }

  route() {
    Preferences.getBoolValuesSF(Preferences.USER_EXIST) == null ||
            Preferences.getBoolValuesSF(Preferences.USER_EXIST) == false
        ? Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SplashVideo()))
        : Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashBoard()));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: splashScreenColor,
      body: SafeArea(
          child: Container(
        constraints: BoxConstraints.expand(height: height, width: width),
        child: Image.asset(
          "assets/images/splash screen.jpg",
          fit: BoxFit.cover,
        ),
      )),
    );
  }
}
