import 'dart:convert';
import 'dart:io';

import 'package:iskcon/Utils/contants.dart';
import 'package:iskcon/Utils/pref_manager.dart';
import 'package:iskcon/Utils/screen_overlay.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic>? deviceData;

  TextEditingController fNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  bool passwordVisible = true;
  bool cPasswordVisible = true;
  var newUserOTP;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> validation(
    BuildContext context,
    String fName,
    String dob,
    String emailValue,
    String mobileNum,
    String passwordValue,
    String cPasswordValue,
  ) async {
    if (fName.isNotEmpty) {
      if (dob.isNotEmpty) {
        if (emailValue.isNotEmpty) {
          if (mobileNum.isNotEmpty) {
            /* if (!regExp.hasMatch(emailValue)) {*/
            if (passwordValue.isNotEmpty) {
              if (passwordValue == cPasswordValue) {
                await getApiData(
                    fName, dob, emailValue, mobileNum, passwordValue);
                // apiService = new APIService();
                // isApiCallProcess = true;
                // apiService.loginUserAPI(emailValue, passwordValue).then((value) => resultAPI(context,value)

                // );
                //Get.to(() => OtpScreen(name: 'register',));
              } else {
                Get.snackbar(
                    "Invalid", "Password and Confirm Password should be same",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    icon: Icon(Icons.warning));
              }
            } else {
              Get.snackbar("Invalid", "Please Enter Password",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  icon: Icon(Icons.warning));
            }
          } else {
            Get.snackbar("Invalid", "Please Enter Mobile Number",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
                icon: Icon(Icons.warning));
          }
        } else {
          Get.snackbar("Invalid", "Please Enter Email Id",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              icon: Icon(Icons.warning));
        }
      } else {
        Get.snackbar("Invalid", "Please Enter Date of Birth",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            icon: Icon(Icons.warning));
      }
    }
    /* } else {
          snakbarMsg(context, Icons.person, "Please Enter Proper Email",
              Colors.red, Colors.white);
        }*/
    else {
      Get.snackbar("Invalid", "Please Enter First Name",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: Icon(Icons.warning));
    }
  }

  @override
  void onInit() {
    super.onInit();
    getPlatformState();
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

  Future<void> getApiData(String firstname, String lastname, String email,
      String mobile, String password) async {
    Map<String, dynamic> input = {
      'first_name': firstname, //'User',
      'last_name': lastname, //'Test',
      'email': email, //'testing2we@gmail.com',
      'mobile_no': mobile, //'9087654321',
      'password': password, //'test123',
      // 'gender': gender,
      'deviceinfo': json.encode(deviceData),
    };
    Get.dialog(loadingOverlay());
    await APIProvider().registerAPI(
      params: inputParams(input),
      onSuccess: (data) {
        print('Response : ${data.status}');
        print('Response : ${data.message}');
        Get.back();
        if (data.status == true) {
          Preferences.addDataToSF(Preferences.AUTH_CODE, data.jwtToken);
          data.userDetail!.forEach((element) {
            Preferences.addDataToSF(Preferences.USER_ID, element.id);
            Preferences.addDataToSF(
                Preferences.USER_FIRST_NAME, element.firstName);
            Preferences.addDataToSF(
                Preferences.USER_LAST_NAME, element.lastName);
            Preferences.addDataToSF(Preferences.USER_EMAIL, element.email);
            Preferences.addDataToSF(Preferences.USER_MOBILE, element.mobileNo);
            Preferences.addDataToSF(Preferences.USER_GENDER, element.gender);
          });

          Preferences.addDataToSF(Preferences.USER_EXIST, data.status);
          Preferences.addDataToSF(Preferences.USER_SHOW_CASE_WIDGET, false);
          Get.toNamed(ROUTE_DASHBOARD);
        } else {
          Get.snackbar('', data.message.toString(),
              icon: const Icon(Icons.dangerous),
              backgroundColor: Colors.redAccent,
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white);
        }
      },
      onError: (error) {
        print('Error : $error');
        Get.back();
      },
    );
    update();
  }
}
