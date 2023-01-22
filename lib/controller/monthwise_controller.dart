import 'package:flutter/material.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:get/get.dart';

import '../models/monthwise_model.dart';

class MonthWiseController extends GetxController {
  var monthWiseList = List<Article>.empty(growable: true).obs;
  var isLoading = false.obs;
  // var packageId;
  GlobalKey one = GlobalKey();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    // packageId = Get.arguments;
    // print(packageId);
    monthwiseListApiData();
    super.onInit();
  }

  Future<void> monthwiseListApiData() async {
    isLoading.value = true;
    monthWiseList.clear();
    await APIProvider().monthwiseListAPI(
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          data.result!.article!.forEach((cat) {
            monthWiseList.add(cat);
          });
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
}
