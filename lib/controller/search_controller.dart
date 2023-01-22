// ignore_for_file: equal_keys_in_map
import 'package:iskcon/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/search_result_model.dart';

class SearchController extends GetxController {
  var searchResult = List<Article>.empty(growable: true).obs;
  var isLoading = false.obs;
  var keyword;

  @override
  void onInit() async {
    keyword = Get.arguments;
    print("keyword===========$keyword");
    await getSearchApi();
    super.onInit();
  }

  Future<void> getSearchApi() async {
    isLoading.value = true;
    searchResult.clear();
    await APIProvider().searchResultApi(
      keyword: keyword,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          data.result!.article!.forEach((article) {
            searchResult.add(article);
          });
        }
        isLoading.value = false;

        update();
      },
      onError: (error) {
        print('Error : $error');
        isLoading.value = false;
      },
    );
    update();
  }

  @override
  void dispose() {
    Get.changeTheme(ThemeData.light());
    searchResult.clear();
    super.dispose();
  }
}
