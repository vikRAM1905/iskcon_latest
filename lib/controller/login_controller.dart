import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Utils/contants.dart';
import '../Utils/pref_manager.dart';
import '../Utils/screen_overlay.dart';
import '../provider/api_provider.dart';

class LoginController extends GetxController {
  Map<String, dynamic>? deviceData;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  bool status = false;
  int count = 0;

  @override
  void onInit() {
    super.onInit();
    passwordVisible = true;
    fcmToken();
    getPlatformState();
    // getSMSPermission();
  }

  fcmToken() async {
    token = await FirebaseMessaging.instance.getToken();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> validation(
      BuildContext context, String emailValue, String passwordValue) async {
    if (emailValue.isNotEmpty) {
      if (passwordValue.isNotEmpty) {
        print("Awaiting....");
        await getApiData(emailValue, passwordValue);

        print("Awaiting....End");

        // Get.to(() => DashBoard());
      } else {
        Get.snackbar('Invalid', 'Please Enter Password',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      }
      /* } else {
          snakbarMsg(context, Icons.person, "Please Enter Proper Email",
              Colors.red, Colors.white);
        }*/
    } else {
      Get.snackbar('Invalid', 'Please Enter Email',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  getPlatformState() async {
    deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    //print(deviceData);
  }

  Future<void> getApiData(String email, String password) async {
    Map<String, dynamic> input = {
      'username': email, // '7894561235',
      'password': password, //'Admin@1',
      'deviceinfo': json.encode(deviceData),
    };
    Get.dialog(loadingOverlay());
    await APIProvider().loginAPI(
      params: inputParams(input),
      onSuccess: (data) {
        print('Response : ${data.status}');
        print('Token : ${data.jwtToken}');
        Get.back();
        status = data.status!;
        if (data.status == true) {
          Preferences.addDataToSF(Preferences.AUTH_CODE, data.jwtToken);
          data.userDetail?.forEach((element) {
            Preferences.addDataToSF(Preferences.USER_ID, element.id);
            Preferences.addDataToSF(
                Preferences.USER_FIRST_NAME, element.firstName);
            Preferences.addDataToSF(
                Preferences.USER_LAST_NAME, element.lastName);
            Preferences.addDataToSF(Preferences.USER_EMAIL, element.email);
            Preferences.addDataToSF(Preferences.USER_MOBILE, element.mobileNo);
          });
          Preferences.addDataToSF(Preferences.USER_EXIST, data.status);
          Preferences.addDataToSF(Preferences.USER_SHOW_CASE_WIDGET, false);

          Get.offAllNamed(ROUTE_DASHBOARD);
        } else {
          Get.snackbar(
            'Invalid',
            data.message.toString(),
            icon: const Icon(Icons.dangerous),
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
      onError: (error) {
        print('Error : $error');
      },
    );
    update();
  }
}
