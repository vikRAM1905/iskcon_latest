import 'dart:io';
import 'package:iskcon/Utils/contants.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/controller/profile_controller.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:iskcon/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as api;

import '../Utils/screen_overlay.dart';

class ProfileUpdateController extends GetxController {
  var profileController = Get.put(ProfileController());
  var profPic;
  var isLoading = false.obs;
  File? imageFile;
  String username = '';

  TextEditingController fNameController = TextEditingController();

  TextEditingController lNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  @override
  void onInit() {
    profileApiData();
    super.onInit();
    fNameController = TextEditingController(text: "First Name");
    lNameController = TextEditingController(text: "Last Name");
    emailController = TextEditingController(text: "Email");
    mobileController = TextEditingController(text: "Mobile Number");
  }

  @override
  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  Future<void> profileApiData() async {
    isLoading.value = true;
    await APIProvider().profileAPI(
      onSuccess: (data) {
        if (data.status == true) {
          profPic = data.result!.profilePhotoPath;
          fNameController.text = data.result!.firstName!;
          lNameController.text = data.result!.lastName!;
          print("last name on profile :- ${data.result!.lastName}");
          emailController.text = data.result!.email!;
          mobileController.text = data.result!.mobileNo.toString();
          username = data.result!.firstName!;
        }
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : $error');
      },
    );
    update();
  }

  Future<void> profileUpdateApiData() async {
    Map<String, dynamic> input = {
      'first_name': fNameController.text,
      'last_name': lNameController.text,
      'profile_image': imageFile == null
          ? imageFile
          : await api.MultipartFile.fromFile(imageFile!.path,
              filename:
                  "${DateTime.now()}.jpg"), // imageFile, //File(imageFile!.path), //profileImage,
    };
    isLoading.value = true;
    await APIProvider().profileUpdateAPI(
      params: inputParams(input),
      onSuccess: (data) {
        print("called");
        print("called ${data.status}");
        print("called ${data.message}");
        isLoading.value = false;
        Get.back();
        Get.back();
        profileController.profileApiData();
        snackBarMsg(
            bgColor: Colors.green,
            title: "Success",
            msg: "Profile details updated successfully",
            colors: kWhiteColor,
            icon: Icons.done);
      },
      onError: (error) {
        print('Error : $error');
        snackBarMsg(
            bgColor: primaryColor,
            title: "Oops!",
            msg: "Somehing went wrong. Please try again",
            colors: kWhiteColor,
            icon: Icons.done);
      },
    );
    update();
  }

  Future<void> updateProfileValidation(ctx) async {
    if (fNameController.text.isEmpty) {
      snackBarMsg(
          bgColor: Colors.redAccent,
          title: "FirstName",
          msg: "FirstName is required",
          colors: kWhiteColor,
          icon: Icons.warning);
    } else if (lNameController.text.isEmpty) {
      snackBarMsg(
          bgColor: Colors.redAccent,
          title: "LastName",
          msg: "LastName is required",
          colors: kWhiteColor,
          icon: Icons.warning);
    } else {
      showDialog(
          builder: (BuildContext context) {
            return loadingOverlay();
          },
          context: ctx);
      await profileUpdateApiData();
    }
  }
}
