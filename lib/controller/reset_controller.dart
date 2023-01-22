import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iskcon/Utils/contants.dart';
import 'package:iskcon/Utils/pref_manager.dart';
import 'package:iskcon/Utils/screen_overlay.dart';
import 'package:iskcon/provider/api_provider.dart';

class ResetController extends GetxController {
  late bool passwordVisible;
  late bool cPasswordVisible;

  final TextEditingController passController = TextEditingController();

  final TextEditingController confirmPassController = TextEditingController();

  @override
  void dispose() {
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  Future<void> validation(
      BuildContext context, String pass, String confirmPass) async {
    if (pass.isNotEmpty) {
      if (confirmPass.isNotEmpty) {
        if (confirmPass == pass) {
          await getApiData(pass, confirmPass);
        } else {
          Get.snackbar(
              "Invalid", "Confirm Password should be same as New Password",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              icon: Icon(Icons.warning));
        }
      } else {
        Get.snackbar("Invalid", "Confirm Password should not be empty",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            icon: Icon(Icons.warning));
      }
    } else {
      Get.snackbar("Invalid", "New Password should not be empty",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: Icon(Icons.warning));
    }
  }

  @override
  void onInit() {
    passwordVisible = true;
    cPasswordVisible = true;
    super.onInit();
  }

  Future<void> getApiData(String password, String cPassword) async {
    Map<String, dynamic> input = {
      'user_id': Preferences.getIntValuesSF(Preferences.USER_ID),
      'new_password': password,
      'confirm_password': cPassword,
    };
    Get.dialog(loadingOverlay());
    await APIProvider().resetAPI(
      params: input,
      onSuccess: (data) {
        print('Response : ${data.status}');
        print('Response : ${data.message}');
        Get.back();
        if (data.status == true) {
          data.userDetail!.forEach((element) {
            Preferences.addDataToSF(Preferences.USER_ID, element.userId);
            Preferences.addDataToSF(
                Preferences.USER_FIRST_NAME, element.firstName);
            Preferences.addDataToSF(
                Preferences.USER_LAST_NAME, element.lastName);
            Preferences.addDataToSF(Preferences.USER_EMAIL, element.email);
            Preferences.addDataToSF(Preferences.USER_MOBILE, element.mobileNo);
          });

          Get.snackbar('Reset Password', data.message.toString(),
              snackPosition: SnackPosition.BOTTOM,
              icon: const Icon(Icons.done),
              backgroundColor: Colors.green,
              colorText: Colors.white);
          Get.toNamed(ROUTE_RESET_SUCCESS);
        } else {
          Get.snackbar('Reset Password', data.message.toString(),
              snackPosition: SnackPosition.BOTTOM,
              icon: const Icon(Icons.dangerous),
              backgroundColor: Colors.redAccent,
              colorText: Colors.white);
        }
      },
      onError: (error) {
        print('Error : $error');
      },
    );
    update();
  }
}
