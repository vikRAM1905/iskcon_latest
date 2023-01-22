import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/controller/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_settings/open_settings.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Utils/contants.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({Key? key}) : super(key: key);

  final controller = Get.put(CategoriesController());
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await Future.delayed(Duration(milliseconds: 1000));
      await controller.categoryListApiData();
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

    /*24 is for notification bar on Android*/
    final double itemHeight = (height - kToolbarHeight - height / 8.65) / 3;
    final double itemWidth = width / 2;
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.grey[600] : Color(0xFFFFFAF4),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text(
          "Categories",
          style: TextStyle(fontFamily: "AnekTamil", color: Colors.white),
        ), // Get.isDarkMode ? Colors.white : Colors.black)),
        elevation: 0,
      ),
      body: controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
              backgroundColor: primaryColor,
              strokeWidth: 1.5,
            ))
          : Container(
              color: primaryColor,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Get.isDarkMode ? Colors.grey[600] : Color(0xFFFFFAF4),
                ),
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropHeader(
                    waterDropColor: primaryColor,
                  ),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: GetBuilder<CategoriesController>(
                    builder: (controller) => SingleChildScrollView(
                      child: GridView.count(
                        padding: EdgeInsets.all(5),
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: (itemWidth / itemHeight),
                        mainAxisSpacing: 25,
                        crossAxisSpacing: 25,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: [
                          for (int i = 0;
                              i < controller.categoryList.length;
                              i++)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(ROUTE_CATEGORY_WISE,
                                      arguments: controller.categoryList[i].id);
                                },
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5)),
                                              child: Image.network(
                                                controller.categoryList[i]
                                                    .mainPicture!,
                                                height: height / 7.5,
                                                width: width / 2.22,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: AutoSizeText(
                                          controller.categoryList[i].title!,
                                          minFontSize: 10,
                                          maxFontSize: 14,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "AnekTamil",
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
