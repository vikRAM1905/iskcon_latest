import 'package:iskcon/models/comic_view_model.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';
import 'package:get/get.dart';

import '../Utils/contants.dart';

class PhotoPageController extends GetxController {
  PageController pageController1 = PageController();
  PageController pageController2 = PageController();
  var currentPageValue = 0.0;
  var ratingValue = 0.0.obs;
  var photosList = List<Description>.empty(growable: true).obs;
  var pagesList = List<Pages>.empty(growable: true).obs;
  var articleDetail = List<Article>.empty(growable: true).obs;
  // PhotoViewModel? photoViewModel;
  var isLoading = false.obs;
  var size = 14.0.obs;
  var page = false.obs;
  var brightness = 0.0.obs;
  RxList<bool> isSelected = [false, true].obs;
  var cellSize = Size(double.infinity, double.infinity).obs;
  var packageId;

  @override
  void onInit() async {
    packageId = Get.arguments;
    initPlatformBrightness();
    // await getBookApi();
    await getGridApi();
    super.onInit();
  }

  @override
  void dispose() {
    Get.changeTheme(ThemeData.light());
    super.dispose();
  }

  Future<void> getGridApi() async {
    isLoading.value = true;
    photosList.clear();
    pagesList.clear();
    // packageDetailDataList.clear();
    await APIProvider().photoPageAPi(
      id: packageId,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          if (data.result!.article != null) {
            articleDetail.add(data.result!.article!);
          }
          data.result!.pages!.forEach((element) {
            pagesList.add(element);
            element.description!.forEach((element1) {
              photosList.add(element1);
            });
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

  Future<void> articleRating(int id, String rating) async {
    Map<String, dynamic> input = {"article_id": id, "rating": rating};
    await APIProvider().articleRatingApi(
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

  void changeMode() {
    page.value = !page.value;
    print(page.value ? "portrait" : "landscape");
    update();
  }

  void changeTabIndex(int index) {
    RxInt tabIndex = 0.obs;
    tabIndex.value = index;
    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
      if (buttonIndex == index) {
        isSelected[buttonIndex] = true;
        update();
      } else {
        isSelected[buttonIndex] = false;
        update();
      }
    }
  }

  bool isDarkMode = true;

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    if (isDarkMode) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
    update();
  }

  Future initPlatformBrightness() async {
    Future<double> bright;
    try {
      bright = (await FlutterScreenWake.brightness) as Future<double>;
    } on PlatformException {
      bright = 1.0 as Future<double>;
    }
    brightness.value = bright as double;
    update();
  }
}
