import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:iskcon/Utils/contants.dart';
import 'package:iskcon/models/intro_page_model.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BookIntroPageController extends GetxController {
  var blogList = List<Article>.empty(growable: true).obs;
  var isLoading = false.obs;
  var packageId;
  var isFav = false.obs;
  Map<String, dynamic>? deviceData;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  getPlatformState() async {
    deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
      print("device data=================$deviceData");
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    print(deviceData);
  }

  @override
  void onInit() async {
    packageId = Get.arguments;
    // token = await FirebaseMessaging.instance.getToken();
    print("fcm ================$token");
    print("packageId $packageId");
    await getBookIntroApi();
    super.onInit();
  }

  void addOrRemove() {
    isFav.value = !isFav.value;
    update();
  }

  @override
  void dispose() {
    Get.changeTheme(ThemeData.light());
    blogList.clear();
    super.dispose();
  }

  Future<void> getBookIntroApi() async {
    isLoading.value = true;
    blogList.clear();
    await APIProvider().introPageApi(
      id: packageId,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          blogList.add(data.result!.article!);
          print("blog details:======${blogList[0].mainPicture}");
          blogList[0].userFavourite == "0"
              ? isFav.value = false
              : isFav.value = true;
        }
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : $error');
        isLoading.value = false;
      },
    );
    update();
  }

  void articleVisit(int id) async {
    Map<String, dynamic> input = {
      "article_id": id,
    };
    await APIProvider().articleVisitApi(
      params: inputParams(input),
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          print("Successfully visited");
        }
      },
      onError: (error) {
        print('Error : $error');
      },
    );
  }
}
