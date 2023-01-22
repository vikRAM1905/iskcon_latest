import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/notification_model.dart';
import '../models/notification_read_model.dart' as read;
import '../provider/api_provider.dart';

class NotificationController extends GetxController {
  var notificationDataList = List<Result>.empty(growable: true).obs;
  read.Result? readNotificationData;
  var isLoading = false.obs;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    print("Start");
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await apiCallingMethod();
    } else {
      Get.snackbar(
        'Internet',
        'No Internet Connection',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    print("End");
  }

  Future<void> apiCallingMethod() async {
    await getNotificationApiData();
  }

  Future<void> getNotificationApiData() async {
    isLoading.value = true;
    notificationDataList.clear();
    await APIProvider().notificationAPI(
      onSuccess: (data) {
        print('Response Notification : ${data.status}');
        print('Response Notification : ${data.message}');
        if (data.status!) {
          data.result!.forEach((element) {
            notificationDataList.add(element);
          });
        }
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : $error');
      },
    );
    update();
  }

  Future<void> getNotificationReadApiData(int? id) async {
    isLoading.value = true;
    await APIProvider().notificationReadAPI(
      id: id,
      onSuccess: (data) {
        print('Response Notification Read : ${data.status}');
        print('Response Notification Read : ${data.message}');
        if (data.status!) {
          readNotificationData = data.result;
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

  Future<void> getNotificationClearApiData() async {
    isLoading.value = true;
    await APIProvider().notificationClearAPI(
      onSuccess: (data) {
        if (data.status!) {
          print('Response Notification Clear : ${data.status}');
          print('Response Notification Clear : ${data.message}');
          Get.snackbar(
            'Notification',
            data.message!,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : $error');
        isLoading.value = false;
      },
    );
    getNotificationApiData();
    update();
  }
}
