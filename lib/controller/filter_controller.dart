// ignore_for_file: equal_keys_in_map
import 'package:iskcon/models/filter_page_model.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  var catList = List<Category>.empty(growable: true).obs;
  // var yearList = List<String>.empty(growable: true).obs;
  var selectedYear = 'Choose Year'.obs;
  var selectedAuthor = 'All Authors'.obs;
  var allCat = List<String>.empty(growable: true).obs;
  var authorList = List<String>.empty(growable: true).obs;
  var selectAll = false.obs;
  var tagList = List<String>.empty(growable: true).obs;
  var monthList = [
    "ஜனவரி",
    "பிப்ரவரி",
    "மார்ச்",
    "ஏப்ரல்",
    "மே",
    "ஜூன்",
    "ஜூலை",
    "ஆகஸ்ட்",
    "செப்டம்பர்",
    "அக்டோபர்",
    "நவம்பர்",
    "டிசம்பர்"
  ].obs;
  var yearList = [
    // "Choose Year",
    "2009",
    "2010",
    "2011",
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    // "2023",
  ].obs;
  var isLoading = false.obs;
  var packageId;
  var isFav = false.obs;
  var myTest;

  var isMonthChecked = List<bool>.empty(growable: true);
  var isCatChecked = List<bool>.empty(growable: true);

  @override
  void onInit() async {
    authorList.insert(0, "All Authors");
    selectedYear.value = 'Choose Year';
    selectedAuthor.value = 'All Authors';
    await getFilterPageApi();
    isMonthChecked = List.generate(monthList.length, (index) => false);
    isCatChecked = List.generate(catList.length, (index) => false);
    super.onInit();
  }

  @override
  void dispose() {
    Get.changeTheme(ThemeData.light());
    super.dispose();
  }

  void clearAll() {
    isMonthChecked = List.generate(monthList.length, (index) => false);
    isCatChecked = List.generate(catList.length, (index) => false);
    update();
  }

  Future<void> getFilterPageApi() async {
    isLoading.value = true;
    catList.clear();
    await APIProvider().filterApi(
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          selectedYear.value = 'Choose Year';
          selectedAuthor.value = 'All Authors';
          data.result!.category!.forEach((cat) {
            catList.add(cat);
            allCat.add(cat.id.toString());
          });
          data.result!.tagList!.forEach((tag) {
            tagList.add(tag);
          });
          data.result!.authorName!.forEach((authors) {
            authorList.add(authors.authorName.toString());
            selectedAuthor.value = authorList[0];
            print(authorList[0]);
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
    print("============${catList.length}");
  }
}

/*
// ignore_for_file: equal_keys_in_map
import 'package:iskcon/models/filter_page_model.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  var catList = List<Category>.empty(growable: true).obs;
  // var yearList = List<String>.empty(growable: true).obs;
  var selectedYear = 'Choose Year'.obs;
  var selectedAuthor = 'Choose Author'.obs;
  var allCat = List<String>.empty(growable: true).obs;
  var authorList = List<String>.empty(growable: true).obs;
  var selectAll = false.obs;
  var tagList = List<String>.empty(growable: true).obs;
  var monthList = [
    "ஜனவரி",
    "பிப்ரவரி",
    "மார்ச்",
    "ஏப்ரல்",
    "மே",
    "ஜூன்",
    "ஜூலை",
    "ஆகஸ்ட்",
    "செப்டம்பர்",
    "அக்டோபர்",
    "நவம்பர்",
    "டிசம்பர்"
  ].obs;
  var yearList = [
    // "Choose Year",
    "2009",
    "2010",
    "2011",
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    // "2023",
  ].obs;
  var isLoading = false.obs;
  var packageId;
  var isFav = false.obs;
  var myTest;

  var isMonthChecked = List<bool>.empty(growable: true);
  var isCatChecked = List<bool>.empty(growable: true);

  @override
  void onInit() async {
    selectedYear.value = 'Choose Year';
    selectedAuthor.value = 'Choose Author';
    await getFilterPageApi();
    isMonthChecked = List.generate(monthList.length, (index) => false);
    isCatChecked = List.generate(catList.length, (index) => false);
    super.onInit();
  }

  @override
  void dispose() {
    Get.changeTheme(ThemeData.light());
    super.dispose();
  }

  void clearAll() {
    isMonthChecked = List.generate(monthList.length, (index) => false);
    isCatChecked = List.generate(catList.length, (index) => false);
    update();
  }

  Future<void> getFilterPageApi() async {
    isLoading.value = true;
    catList.clear();
    await APIProvider().filterApi(
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          selectedYear.value = 'Choose Year';
          selectedAuthor.value = 'Choose Author';
          data.result!.category!.forEach((cat) {
            catList.add(cat);
            allCat.add(cat.id.toString());
          });
          data.result!.tagList!.forEach((tag) {
            tagList.add(tag);
          });
          data.result!.authorName!.forEach((authors) {
            authorList.add(authors.authorName.toString());
            selectedAuthor.value = authorList[0];
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
    print("============${catList.length}");
  }
}
*/
