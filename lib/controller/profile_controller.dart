import 'dart:io';
import 'package:iskcon/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  bool enableTextFiled = false;
  // var profile = List<Result>.empty(growable: true).obs;
  var name = '';
  var mail;
  var mobileNum;
  var subsStart;
  var subsEnds;
  var subscriptionId;
  var profPic;
  var isLoading = false.obs;
  File? imageFile;
  GlobalKey six = GlobalKey();
  GlobalKey seven = GlobalKey();
  GlobalKey eight = GlobalKey();

  @override
  void onInit() {
    profileApiData();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> profileApiData() async {
    isLoading.value = true;
    await APIProvider().profileAPI(
      onSuccess: (data) {
        if (data.status == true) {
          mobileNum = data.result!.mobileNo;
          // profile.add(data.result!);
          subscriptionId = data.result!.subscriptionId;
          name = '${data.result!.firstName}' + ' ' + '${data.result!.lastName}';
          mail = data.result!.email;
          subsStart = data.result!.startDate;
          subsEnds = data.result!.expiryDate;
          profPic = data.result!.profilePhotoPath;
        }
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : $error');
      },
    );
    update();
  }
}
