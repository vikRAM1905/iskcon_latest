import 'package:iskcon/Utils/contants.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/controller/profile_controller.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:iskcon/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/screen_overlay.dart';

class PasswordUpdateController extends GetxController {
  var profileController = Get.put(ProfileController());
  var isVisible1 = true.obs;
  var isVisible2 = true.obs;
  var isLoading = false.obs;
  var obscureText1 = true.obs;
  var obscureText2 = true.obs;
  void toggle1() {
    obscureText1.value = !obscureText1.value;
    update();
  }

  void toggle2() {
    obscureText2.value = !obscureText2.value;
    update();
  }

  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.clear();
    rePasswordController.clear();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  visible1() {
    isVisible1.value = !isVisible1.value;
    update();
  }

  visible2() {
    isVisible2.value = !isVisible2.value;
    update();
  }

  Future<void> passwordUpdateApiData() async {
    Map<String, dynamic> input = {
      'new_password': passwordController.text,
      'confirm_password': rePasswordController
          .text, // imageFile, //File(imageFile!.path), //profileImage,
    };
    isLoading.value = true;
    await APIProvider().passwordUpdateAPI(
      params: inputParams(input),
      onSuccess: (data) {
        print("called");
        print("called ${data.status}");
        print("called ${data.message}");
        // if(data.status != true) {
        //   profileImage = data.result!.studentImage.toString();
        //   fNameController.text = data.result!.firstName!;
        //   lNameController.text = data.result!.lastName!;
        //   emailController.text = data.result!.email!;
        //   mobileController.text = data.result!.mobileNo.toString();
        //   passwordController.text = data.result!.toString();
        // }
        isLoading.value = false;
        Get.back();
        Get.back();
        profileController.profileApiData();
        snackBarMsg(
            bgColor: Colors.green,
            title: "Success",
            msg: "Password has been updated successfully",
            colors: kWhiteColor,
            icon: Icons.done);
      },
      onError: (error) {
        print('Error : $error');
      },
    );
    update();
  }

  Future<void> updatePasswordValidation(ctx) async {
    if (passwordController.text.isEmpty || rePasswordController.text.isEmpty) {
      snackBarMsg(
          bgColor: primaryColor,
          title: "Password",
          msg: "Fill the both fields",
          colors: kWhiteColor,
          icon: Icons.warning);
    } else if (passwordController.text != rePasswordController.text) {
      snackBarMsg(
          bgColor: Colors.redAccent,
          title: "Error",
          msg: "Both fields has to be same",
          colors: kWhiteColor,
          icon: Icons.warning);
    } else {
      showDialog(
          builder: (BuildContext context) {
            return loadingOverlay();
          },
          context: ctx);
      await passwordUpdateApiData();
    }
  }
}
