import 'package:iskcon/Utils/contants.dart';
import 'package:iskcon/Utils/pref_manager.dart';
import 'package:iskcon/Utils/screen_overlay.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController {
  final TextEditingController textController = TextEditingController();
  var userOTP;
  var userMobile;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> validation(BuildContext context, String userId) async {
    if (userId.isNotEmpty && userId.length >= 10) {
      await getApiData(userId);
    } else {
      Get.snackbar('Invalid', 'Please enter Email Id or Mobile Number',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: Icon(Icons.warning));
    }
  }

  Future<void> getApiData(String mobile) async {
    Map<String, dynamic> input = {
      'mobile_number': mobile,
    };
    Get.dialog(loadingOverlay());
    await APIProvider().forgotAPI(
      params: input,
      onSuccess: (data) {
        print('Response : ${data.status}');
        print('Response : ${data.message}');
        Get.back();
        if (data.status!) {
          data.userDetail!.forEach((element) {
            Preferences.addDataToSF(Preferences.USER_ID, element.userId);
            Preferences.addDataToSF(Preferences.USER_MOBILE, element.mobileNo);
            userMobile = element.mobileNo;
            userOTP = element.otp;
          });
          Get.toNamed(ROUTE_OTP, arguments: [userOTP, userMobile, "Forgot"]);
        } else {
          Get.snackbar("Invalid", data.message!,
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.redAccent,
              icon: Icon(Icons.warning));
        }
      },
      onError: (error) {
        print('Error : $error');
      },
    );
    update();
  }
}
