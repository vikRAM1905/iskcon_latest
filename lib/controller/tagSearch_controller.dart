import 'package:flutter/material.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:get/get.dart';

import '../models/tagSearch_result_model.dart';

class TagSearchResultController extends GetxController {
  var resultList = List<Article>.empty(growable: true).obs;
  var isLoading = false.obs;
  var tag;
  // var packageId;
  GlobalKey three = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    tag = Get.arguments;
    print("////////// $tag");
    tagSearchResultApiData();
    super.onInit();
  }

  Future<void> tagSearchResultApiData() async {
    isLoading.value = true;
    resultList.clear();
    await APIProvider().TagSearchResultApi(
      tag: tag,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          data.result!.article!.forEach((article) {
            resultList.add(article);
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
