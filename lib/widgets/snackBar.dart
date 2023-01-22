import 'package:iskcon/Utils/size_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackBar? snackBarMsg(
    {IconData? icon, var title, var msg, Color? bgColor, Color? colors}) {
  Get.snackbar(
    title,
    msg,
    icon: Icon(
      icon,
      color: colors,
      size: size28,
    ),
    shouldIconPulse: false,
    barBlur: 50,
    isDismissible: true,
    duration: const Duration(seconds: 3),
    padding: EdgeInsets.all(size10),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: bgColor,
    borderRadius: size10,
    titleText: Text(
      title,
      style: TextStyle(
          fontFamily: "AnekTamil",
          color: colors,
          fontSize: 16,
          fontWeight: FontWeight.bold),
    ),
    messageText: Text(
      msg,
      style: TextStyle(
        fontFamily: "AnekTamil",
        color: colors,
        fontSize: 16,
      ),
    ),
    //dismissDirection: SnackDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

SnackBar? snackBarNotificationMsg(
    {var title,
    var msg,
    Color? bgColor,
    Color? titleColors,
    Color? messageColor}) {
  Get.snackbar(
    title, // title
    msg, // message
    icon: Image.asset(
      'assets/images/ic_launcher.png',
    ),
    shouldIconPulse: false,
    barBlur: 50,
    isDismissible: true,
    duration: const Duration(seconds: 3),
    padding: const EdgeInsets.all(20),
    snackPosition: SnackPosition.TOP,
    backgroundColor: bgColor,
    borderRadius: 10,
    titleText: Text(
      title,
      style: TextStyle(
          fontFamily: "AnekTamil",
          color: titleColors,
          fontSize: size16 / Get.textScaleFactor,
          fontWeight: FontWeight.bold),
    ),
    messageText: Text(
      msg,
      style: TextStyle(fontFamily: "AnekTamil", color: messageColor),
    ),
  );
}
