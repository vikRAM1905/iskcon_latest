import 'package:iskcon/Utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  late TextEditingController firstTextController,
      secondTextController,
      thirdTextController,
      fourthTextController;
  FocusNode firstTextFocusNode = FocusNode();
  var userOTP;
  var userMobile;
  var userStatus;

  @override
  void onInit() {
    userOTP = Get.arguments[0].toString();
    userMobile = Get.arguments[1].toString();
    userStatus = Get.arguments[2].toString();

    super.onInit();
    firstTextController = TextEditingController();
    secondTextController = TextEditingController();
    thirdTextController = TextEditingController();
    fourthTextController = TextEditingController();
    initSmsListener();
  }

  @override
  void dispose() {
    firstTextController.text = '';
    secondTextController.text = '';
    thirdTextController.text = '';
    fourthTextController.text = '';
    firstTextController.clear();
    secondTextController.clear();
    thirdTextController.clear();
    fourthTextController.clear();
    firstTextController.dispose();
    secondTextController.dispose();
    thirdTextController.dispose();
    fourthTextController.dispose();
    // AltSmsAutofill().unregisterListener();
    super.dispose();
  }

// This method used to Auto filled sms.
  Future<void> initSmsListener() async {
    try {
      // String? comingSms = await AltSmsAutofill().listenForSms;
      //List<String> data = commingSms.toString().split(' ');
      // final String code = comingSms.toString().replaceAll(RegExp(r'[^0-9]'),'');
      // if(code.length==4) {
      //   firstTextController.text = code[0];
      //   secondTextController.text = code[1];
      //   thirdTextController.text = code[2];
      //   fourthTextController.text = code[3];
      // }
    } on PlatformException {
      print('Failed to get Sms.');
      firstTextController.clear();
      secondTextController.clear();
      thirdTextController.clear();
      fourthTextController.clear();
    }
  }

  void otpValidation() {
    if (firstTextController.text.isEmpty ||
        secondTextController.text.isEmpty ||
        thirdTextController.text.isEmpty ||
        fourthTextController.text.isEmpty) {
      Get.snackbar("OTP", "Please enter valid otp..!",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          icon: Icon(
            Icons.warning,
          ));
    } else {
      if (userOTP != null) {
        if (userOTP[0] == firstTextController.text &&
            userOTP[1] == secondTextController.text &&
            userOTP[2] == thirdTextController.text &&
            userOTP[3] == fourthTextController.text) {
          userStatus == "Forgot"
              ? Get.toNamed(ROUTE_RESET_PASSWORD)
              : Get.offAllNamed(ROUTE_LOGIN_SUCCESS);
          //Get.toNamed(ROUTE_LOGIN_SUCCESS);
        } else {
          Get.snackbar("OTP", "Please enter valid otp..!",
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.redAccent,
              icon: Icon(Icons.warning));
        }
      } else {
        print("Else");
      }

      //Get.put(HomeController()).getAPICalled();
    }
  }
}
