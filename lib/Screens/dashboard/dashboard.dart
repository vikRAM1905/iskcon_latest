import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Screens/favorites/favorite_page.dart';
import 'package:iskcon/Screens/profile/profile_page.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/Utils/gradient_text.dart';
import 'package:iskcon/controller/categories_controller.dart';
import 'package:iskcon/controller/dashboard_controller.dart';
import 'package:iskcon/controller/monthwise_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_settings/open_settings.dart';
import '../../Utils/pref_manager.dart';
import '../categories/categories_page.dart';
import '../categories/monthwise_page.dart';
import 'homePage.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var dashboardController = Get.put(DashBoardController());
  final recentController = Get.put(MonthWiseController());
  final categoriesController = Get.put(CategoriesController());
  var currentBackPressTime;
  int carouselIndex = 0;

  List<BottomNavigationBarItem> itemBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: GetBuilder<DashBoardController>(
          builder: (DashBoardController dashboardController) {
            return Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 0),
              child: dashboardController.selectedIndex == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/home.png",
                            height: 24.r, width: 24.r, fit: BoxFit.fill),
                        SizedBox(
                          height: 5.r,
                        ),
                        GradientText(
                          "Home",
                          gradient: myGradient,
                          style: TextStyle(
                              fontFamily: "AnekTamil", fontSize: 12.r),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/un_home.png",
                            height: 22.r, width: 22.r, fit: BoxFit.fill),
                        SizedBox(
                          height: 5.r,
                        ),
                        GradientText(
                          "Home",
                          gradient: unSelectGradient,
                          style: TextStyle(
                              fontFamily: "AnekTamil", fontSize: 12.r),
                        )
                      ],
                    ),
            );
          },
        ),
        label: ''),
    BottomNavigationBarItem(
        icon: GetBuilder<DashBoardController>(
          builder: (DashBoardController dashboardController) {
            return Padding(
              padding: const EdgeInsets.only(top: 0),
              child: dashboardController.selectedIndex == 1
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/favouritesr.png",
                            height: 20.r, width: 20.r, fit: BoxFit.fill),
                        SizedBox(
                          height: 5.r,
                        ),
                        GradientText(
                          "Favorites", //Recent
                          gradient: myGradient,
                          style: TextStyle(
                              fontFamily: "AnekTamil", fontSize: 12.r),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/un_fav.png",
                            height: 22.r, width: 22.r, fit: BoxFit.fill),
                        SizedBox(
                          height: 5.r,
                        ),
                        GradientText(
                          "Favorites", //Recent
                          gradient: unSelectGradient,
                          style: TextStyle(
                              fontFamily: "AnekTamil", fontSize: 12.r),
                        )
                      ],
                    ),
            );
          },
        ),
        label: ''),
    BottomNavigationBarItem(
        icon: GetBuilder<DashBoardController>(
          builder: (DashBoardController dashboardController) {
            return Padding(
              padding: const EdgeInsets.only(top: 0),
              child: dashboardController.selectedIndex == 2
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/categories.png",
                            height: 18.r, width: 18.r, fit: BoxFit.fill),
                        SizedBox(
                          height: 5.r,
                        ),
                        GradientText(
                          "Categories",
                          gradient: myGradient,
                          style: TextStyle(
                              fontFamily: "AnekTamil", fontSize: 12.r),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/un_categories.png",
                            height: 16.r, width: 16.r, fit: BoxFit.fill),
                        SizedBox(
                          height: 5.r,
                        ),
                        GradientText(
                          "Categories",
                          gradient: unSelectGradient,
                          style: TextStyle(
                              fontFamily: "AnekTamil", fontSize: 12.r),
                        )
                      ],
                    ),
            );
          },
        ),
        label: ''),
    BottomNavigationBarItem(
        icon: GetBuilder<DashBoardController>(
          builder: (DashBoardController dashboardController) {
            return Padding(
              padding: const EdgeInsets.only(top: 0),
              child: dashboardController.selectedIndex == 3
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/my profile.png",
                            height: 20.r, width: 20.r, fit: BoxFit.fill),
                        SizedBox(
                          height: 5.r,
                        ),
                        GradientText(
                          "My Profile",
                          gradient: myGradient,
                          style: TextStyle(
                              fontFamily: "AnekTamil", fontSize: 12.r),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/un_profile.png",
                            height: 18.r, width: 18.r, fit: BoxFit.fill),
                        SizedBox(
                          height: 5.r,
                        ),
                        GradientText(
                          "My Profile",
                          gradient: unSelectGradient,
                          style: TextStyle(
                              fontFamily: "AnekTamil", fontSize: 12.r),
                        )
                      ],
                    ),
            );
          },
        ),
        label: ''),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    Future<bool> onWillPop() {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime) > Duration(milliseconds: 1000)) {
        currentBackPressTime = now;

        Get.snackbar('Exit', 'Press back again to exit app',
            backgroundColor: Colors.black45,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        return Future.value(false);
      }
      return Future.value(true);
    }

    return WillPopScope(
        onWillPop: () => onWillPop(),
        child: Scaffold(
          body: IndexedStack(
            index: dashboardController.selectedIndex,
            children: [
              HomePage(),
              FavouritesPage(), // MonthWisePage(),
              CategoriesPage(),
              ProfilePage()
            ],
          ),
          bottomNavigationBar: GetBuilder<DashBoardController>(
              builder: (DashBoardController dashboardController) {
            print("/////////////////" +
                Preferences.getBoolValuesSF(Preferences.USER_SHOW_CASE_WIDGET)
                    .toString());
            print(dashboardController.selectedIndex);
            return BottomNavigationBar(
              items: itemBar,
              selectedFontSize: 0,
              type: BottomNavigationBarType.fixed,
              currentIndex: dashboardController.selectedIndex,
              onTap: (index) async {
                var result = await (Connectivity().checkConnectivity());
                if (result == ConnectivityResult.wifi ||
                    result == ConnectivityResult.mobile) {
                  setState(() {
                    dashboardController.selectedIndex = index;

                    // if (Preferences.getBoolValuesSF(
                    //             Preferences.USER_SHOW_CASE_WIDGET) ==
                    //         false ||
                    //     Preferences.getBoolValuesSF(
                    //             Preferences.USER_SHOW_CASE_WIDGET) ==
                    //         null) {
                    //   if (dashboardController.selectedIndex == 0) {
                    //     WidgetsBinding.instance.addPostFrameCallback(
                    //       (_) => ShowCaseWidget.of(context).startShowCase([
                    //         dashboardController.one,
                    //         dashboardController.two,
                    //         dashboardController.three,
                    //         dashboardController.four,
                    //         dashboardController.five,
                    //       ]),
                    //     );
                    //     dashboardController.showCaseOne = true;
                    //   } else if (dashboardController.selectedIndex == 3) {
                    //     WidgetsBinding.instance.addPostFrameCallback(
                    //       (_) => ShowCaseWidget.of(context).startShowCase([
                    //         Get.put(ProfileController()).six,
                    //         Get.put(ProfileController()).seven,
                    //         Get.put(ProfileController()).eight,
                    //       ]),
                    //     );
                    //   } else {
                    //     print("Yes");
                    //     Preferences.addDataToSF(
                    //         Preferences.USER_SHOW_CASE_WIDGET, true);
                    //   }
                    // }
                    dashboardController.update();
                  });
                } else {
                  Get.defaultDialog(
                      title: "Connection Lost!",
                      content: Text("Check your internet connection"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          child: Text("Close"),
                        ),
                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: primaryColor),
                          onPressed: () {
                            OpenSettings.openWIFISetting();
                            Get.back();
                          },
                          child: Text('Open Settings'),
                        ),
                      ]);
                }
              },
            );
          }),
        ));
  }
}
