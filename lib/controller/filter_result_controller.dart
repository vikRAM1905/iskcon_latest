// ignore_for_file: equal_keys_in_map
import 'dart:convert';

import 'package:iskcon/Utils/urlUtils.dart';
import 'package:iskcon/models/filter_result_model.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Utils/pref_manager.dart';

class FilterResultController extends GetxController {
  var resultList = List<Article>.empty(growable: true).obs;
  var isLoading = false.obs;
  var categories;
  var months;
  var year;
  var author;
  var isFav = false.obs;

  @override
  void onInit() {
    categories = Get.arguments['categories'];
    months = Get.arguments['months'];
    year = Get.arguments['year'];
    author = Get.arguments['author_name'];
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$categories");
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$months");
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$year");
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$author");
    getFilterResultApi();
    super.onInit();
  }

  void addOrRemove() {
    isFav.value = !isFav.value;
    update();
  }

  Future<void> getFilterResultApi() async {
    isLoading.value = true;
    resultList.clear();
    // var body = {
    //   "category_id": jsonEncode(categories),
    //   "month": jsonEncode(months),
    //   "year": jsonEncode(year),
    //   "author_name": jsonEncode(author)
    // };
    // print("encoded body : $body");
    // await http
    //     .post(Uri.parse(urlFilterResult()),
    //         headers: {
    //           'Accept': 'application/json',
    //           // "Content-Type": "multipart/form-data",
    //           "Authorization":
    //               "Bearer ${Preferences.getStringValuesSF(Preferences.AUTH_CODE)}"
    //         },
    //         body: body)
    //     .then((response) {
    //   if (response.statusCode == 200 || response.statusCode == 201) {
    //     var data =
    //         FilterResultModel.fromJson(json.decode(response.body.toString()));
    //     data.result!.article!.forEach((article) {
    //       resultList.add(article);
    //     });
    //     isLoading.value = false;
    //     update();
    //   }
    // }).catchError((onError) {
    //   print('Error : $onError');
    //   isLoading.value = false;
    // });

    await APIProvider().filterResultApi(
      catList: categories,
      months: months,
      year: year, //int.parse(year),
      authors: author,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          data.result!.article!.forEach((article) {
            resultList.add(article);
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
    super.dispose();
  }
}
