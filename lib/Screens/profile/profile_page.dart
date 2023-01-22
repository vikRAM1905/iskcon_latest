// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Screens/favorites/favorite_page.dart';
import 'package:iskcon/Screens/profile/about_us_page.dart';
import 'package:iskcon/Screens/profile/profile_update_page.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iskcon/controller/logout_controller.dart';
import 'package:open_settings/open_settings.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Utils/pref_manager.dart';
import '../../controller/favourite_controller.dart';
import '../../controller/login_controller.dart';
import '../../controller/profile_controller.dart';
import '../donate/donate_page.dart';
import '../login/login_page.dart';
import 'password_update_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final profilecontroller = Get.put(ProfileController());
  final favController = Get.put(FavoritesController());
  final dashboardController = Get.put(DashBoardController());
  final loginController = Get.put(LoginController());
  final logoutController = Get.put(LogoutController());
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await Future.delayed(Duration(milliseconds: 1000));
      await profilecontroller.profileApiData();
      profilecontroller.update();
      _refreshController.refreshCompleted();
    } else {
      Get.defaultDialog(
          title: "Oops!...",
          content: Text("Check your internet connection"),
          actions: [
            ElevatedButton(
              onPressed: () {
                exit(0);
              },
              child: Text("Exit"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: primaryColor),
              onPressed: () {
                OpenSettings.openWIFISetting();
              },
              child: Text('Open Settings'),
            ),
          ]);
    }
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Obx(() => Scaffold(
          backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
          body: profilecontroller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  strokeWidth: 1.5,
                ))
              : SmartRefresher(
                  enablePullDown: true,
                  header: WaterDropHeader(
                    waterDropColor: primaryColor,
                  ),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                              height: height / 6.55 * 3,
                              width: double.infinity,
                              color: primaryColor,
                              child: Column(
                                children: [
                                  SizedBox(height: height / 18.1),
                                  CachedNetworkImage(
                                    imageUrl: profilecontroller.profPic,
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      radius: 45.r,
                                      backgroundImage: imageProvider,
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.5),
                                    ),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  SizedBox(
                                    height: height / 84.4,
                                  ),
                                  AutoSizeText(
                                    "${profilecontroller.name}".toUpperCase(),
                                    minFontSize: 20,
                                    maxFontSize: 22,
                                    style: TextStyle(
                                      fontFamily: "AnekTamil",
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 84.4,
                                  ),
                                  AutoSizeText(
                                    "${profilecontroller.mail}",
                                    minFontSize: 14,
                                    maxFontSize: 16,
                                    style: TextStyle(
                                      fontFamily: "AnekTamil",
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 84.4,
                                  ),
                                  Container(
                                    height: height / 12.06,
                                    width: width / 1.22,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            AutoSizeText(
                                              "Subscription Starts",
                                              minFontSize: 14,
                                              maxFontSize: 16,
                                              style: TextStyle(
                                                fontFamily: "AnekTamil",
                                                color: primaryColor,
                                              ),
                                            ),
                                            AutoSizeText(
                                              "${profilecontroller.subsStart}",
                                              minFontSize: 14,
                                              maxFontSize: 16,
                                              style: TextStyle(
                                                  fontFamily: "AnekTamil",
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        Container(
                                          height: height / 28.1,
                                          width: 2,
                                          color: Colors.grey,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            AutoSizeText(
                                              "Subscription Ends",
                                              minFontSize: 14,
                                              maxFontSize: 16,
                                              style: TextStyle(
                                                  fontFamily: "AnekTamil",
                                                  color: primaryColor),
                                            ),
                                            AutoSizeText(
                                              "${profilecontroller.subsEnds}",
                                              minFontSize: 14,
                                              maxFontSize: 16,
                                              style: TextStyle(
                                                  fontFamily: "AnekTamil",
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      Positioned(
                        top: height / 2.50,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:
                                  Get.isDarkMode ? Colors.black : Colors.white),
                          child: ListView(
                            // physics: NeverScrollableScrollPhysics(),
                            children: [
                              ListTile(
                                onTap: () => Get.to(() => ProfileUpdatePage()),
                                leading: Icon(
                                  Icons.person,
                                  color: Color.fromARGB(255, 106, 103, 103),
                                ),
                                title: AutoSizeText("My Profile",
                                    style: TextStyle(
                                      fontFamily: "AnekTamil",
                                    )),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Color.fromARGB(255, 106, 103, 103),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Divider(),
                              ),
                              ListTile(
                                onTap: () {
                                  favController.apiCallingMethod();
                                  favController.update();
                                  Get.to(() => FavouritesPage());
                                },
                                leading: Icon(
                                  Icons.favorite,
                                  color: Color.fromARGB(255, 106, 103, 103),
                                ),
                                title: AutoSizeText("Favourites",
                                    style: TextStyle(
                                      fontFamily: "AnekTamil",
                                    )),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Color.fromARGB(255, 106, 103, 103),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Divider(),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.to(() => DonatePage());
                                },
                                leading: Image.asset(
                                  "assets/images/donate.png",
                                  color: Color.fromARGB(255, 106, 103, 103),
                                  height: 30,
                                  width: 30,
                                ),
                                title: AutoSizeText("Donate Now",
                                    style: TextStyle(
                                      fontFamily: "AnekTamil",
                                    )),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Color.fromARGB(255, 106, 103, 103),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Divider(),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.to(() => PasswordUpdatePage());
                                },
                                leading: Icon(
                                  Icons.lock,
                                  color: Color.fromARGB(255, 106, 103, 103),
                                ),
                                title: AutoSizeText("Change Password",
                                    style: TextStyle(
                                      fontFamily: "AnekTamil",
                                    )),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Color.fromARGB(255, 106, 103, 103),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Divider(),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.to(() => AboutUsPage());
                                },
                                leading: Icon(
                                  Icons.contact_page,
                                  color: Color.fromARGB(255, 106, 103, 103),
                                ),
                                title: AutoSizeText("About Us",
                                    style: TextStyle(
                                      fontFamily: "AnekTamil",
                                    )),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Color.fromARGB(255, 106, 103, 103),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Divider(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Get.defaultDialog(
                  title: "Are you Sure?",
                  content: Text("You want to logout?"),
                  actions: [
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        // color: Colors.blue,
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontFamily: "AnekTamil", color: Colors.white),
                        )),
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                        ),
                        onPressed: () {
                          logoutController.getLogoutApiData();
                          Preferences.clearAllValuesSF();
                          dashboardController.selectedIndex = 0;
                          dashboardController.update();
                          // loginController.emailController.clear();
                          // loginController.passwordController.clear();

                          // Get.snackbar(
                          //   'Logout',
                          //   "Successfully Logged Out",
                          //   icon: const Icon(Icons.done),
                          //   backgroundColor: Colors.green,
                          //   colorText: Colors.white,
                          //   snackPosition: SnackPosition.BOTTOM,
                          // );
                          // Get.offAll(() => LoginPage());
                        },
                        child: Text(
                          "Yes. Logout",
                          style: TextStyle(
                              fontFamily: "AnekTamil", color: Colors.white),
                        )),
                  ]);
            },
            backgroundColor: Colors.white,
            label: Text("Logout", style: TextStyle(color: primaryColor)),
            icon: Icon(
              Icons.logout,
              color: primaryColor,
            ),
          ),
        ));
  }
}
