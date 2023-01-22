import 'package:iskcon/Screens/login/login_page.dart';
import 'package:iskcon/Utils/contants.dart';
import 'package:iskcon/Utils/pref_manager.dart';
import 'package:iskcon/Utils/screen_overlay.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';

import 'login_controller.dart';

class LogoutController extends GetxController {
  final loginController = Get.put(LoginController());
  var showCaseValue;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getLogoutApiData() async {
    Map<String, dynamic> input = {
      "token": Preferences.getStringValuesSF(Preferences.AUTH_CODE)
    };
    Get.dialog(loadingOverlay());
    await APIProvider().logoutAPI(
      params: inputParams(input),
      onSuccess: (data) {
        print('Response : ${data.success}');
        print('Response : ${data.message}');
        if (data.success == true) {
          showCaseValue =
              Preferences.getBoolValuesSF(Preferences.USER_SHOW_CASE_WIDGET);
          Preferences.clearAllValuesSF();
          Preferences.addDataToSF(
              Preferences.USER_SHOW_CASE_WIDGET, showCaseValue);
          loginController.emailController.clear();
          loginController.passwordController.clear();
          Get.back();
          Get.snackbar(
            'Logout',
            data.message.toString(),
            icon: const Icon(Icons.dangerous),
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          Restart.restartApp();
        } else {
          Get.snackbar(
            'Logout',
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
