import 'package:flutter/material.dart';
import 'package:iskcon/models/category_list_model.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  var categoryList = List<Category>.empty(growable: true).obs;
  var isLoading = false.obs;
  // var packageId;
  GlobalKey three = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    // packageId = Get.arguments;
    // print(packageId);
    categoryListApiData();
    super.onInit();
  }

  Future<void> categoryListApiData() async {
    isLoading.value = true;
    categoryList.clear();
    await APIProvider().categoryListAPI(
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          data.result!.category!.forEach((cat) {
            categoryList.add(cat);
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
