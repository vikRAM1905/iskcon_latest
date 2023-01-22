import 'package:iskcon/Utils/contants.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';
import 'package:get/get.dart';
import '../models/book_view_model.dart';

class BookPageController extends GetxController {
  var isOpen = false.obs;
  var absorbing = false.obs;
  var ratingValue = 0.0.obs;

  var bottomSheetController;
  PersistentBottomSheetController? bootomSheetController1;
  var pageList = List<Pages>.empty(growable: true).obs;
  var articleDetail = List<Article>.empty(growable: true).obs;
  var htmlList = List<String>.empty(growable: true).obs;
  var imageList = List<String>.empty(growable: true).obs;
  var isLoading = false.obs;
  var size = 18.0.obs;
  var page = false.obs;
  var brightness = 0.0.obs;
  RxList<bool> isSelected = [false, true].obs;
  var cellSize = Size(double.infinity, double.infinity).obs;
  PageController pageController = PageController();
  var currentPageValue = 0.0;
  double brightSliderValue = 0;
  bool brightSliderVisible = false;
  double fontSliderValue = 0;
  bool fontSliderVisible = false;
  var packageId;

  void showOverlay(BuildContext context, bool mode) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry1;
    overlayEntry1 = OverlayEntry(builder: (context) {
      return Positioned(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            child: Material(
              color: Colors.transparent,
              child: mode
                  ? Container(
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/images/swipe_left.gif'))
                  : Container(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'assets/images/swipe_up.gif',
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      )),
            ),
          ),
        ),
      );
    });

    // Inserting the OverlayEntry into the Overlay
    overlayState!.insert(overlayEntry1);

    // Awaiting for 3 seconds
    await Future.delayed(Duration(seconds: 2));

    // Removing the first OverlayEntry from the Overlay
    overlayEntry1.remove();

    // Awaiting for 2 seconds more
    await Future.delayed(Duration(seconds: 2));
    update();
  }

  @override
  void onInit() async {
    initPlatformBrightness();
    packageId = Get.arguments;
    print("==============================$packageId");
    await getBookApi();
    // await getGridApi();
    super.onInit();
  }

  @override
  void dispose() {
    Get.changeTheme(ThemeData.light());
    super.dispose();
  }

  // updateSize(context, font) {
  //   if (font == 12) {
  //     cellSize.value = Size(MediaQuery.of(context).size.width,
  //         MediaQuery.of(context).size.height - 50);
  //   } else if (font == 14) {
  //     cellSize.value = Size(MediaQuery.of(context).size.width,
  //         MediaQuery.of(context).size.height);
  //   } else if (font == 16) {
  //     cellSize.value = Size(MediaQuery.of(context).size.width,
  //         MediaQuery.of(context).size.height + 1000);
  //   } else if (font == 18) {
  //     cellSize.value = Size(MediaQuery.of(context).size.width,
  //         MediaQuery.of(context).size.height + 1500);
  //   } else if (font == 20) {
  //     cellSize.value = Size(MediaQuery.of(context).size.width,
  //         MediaQuery.of(context).size.height + 2000);
  //   } else if (font == 22) {
  //     cellSize.value = Size(MediaQuery.of(context).size.width,
  //         MediaQuery.of(context).size.height + 2500);
  //   }
  //   update();
  // }

  Future<void> getBookApi() async {
    isLoading.value = true;
    htmlList.clear();
    pageList.clear();
    articleDetail.clear();
    await APIProvider().bookPageApi(
      id: packageId,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          articleDetail.add(data.result!.article!);
          data.result!.pages!.forEach((element) {
            pageList.add(element);
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

  bool isDarkMode = false;

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
