import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/Utils/size_style.dart';
import 'package:iskcon/controller/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_settings/open_settings.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Utils/contants.dart';

class FavouritesPage extends StatelessWidget {
  FavouritesPage({Key? key}) : super(key: key);

  final controller = Get.put(FavoritesController());
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await Future.delayed(Duration(milliseconds: 1000));
      await controller.favouritesApiData();
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
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.grey[600] : Color(0xFFFFFAF4),
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: primaryColor,
          title: Text("Favourites",
              style: TextStyle(
                  fontFamily: "AnekTamil",
                  color: Colors
                      .white)), //Get.isDarkMode ? Colors.white : Colors.black)),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: TextButton(
                onPressed: () {
                  controller.getClearAllApiData();
                },
                child: Text(
                  "Clear All",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ]),
      body: GetBuilder<FavoritesController>(
        builder: (controller) => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                strokeWidth: 1.5,
              ))
            : controller.favouriteBooks.length == 0
                ? SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: WaterDropHeader(
                      waterDropColor: primaryColor,
                    ),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: height / 4.2,
                              width: width / 1.9,
                              child: Image.asset('assets/images/no_data.png')),
                          SizedBox(
                            height: height / 28.1,
                          ),
                          Text("No Articles found"),
                        ],
                      ),
                    ),
                  )
                : Container(
                    color: primaryColor,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        color: Get.isDarkMode
                            ? Colors.grey[600]
                            : Color(0xFFFFFAF4),
                      ),
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        header: WaterDropHeader(
                          waterDropColor: primaryColor,
                        ),
                        controller: _refreshController,
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            itemCount: controller.favouriteBooks.length,
                            padding: EdgeInsets.all(5),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: InkWell(
                                    onTap: () {
                                      Get.toNamed(ROUTE_BOOK_INTRO,
                                          arguments: controller
                                              .favouriteBooks[index].blogId);
                                    },
                                    child: favListWidget(index, context)),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  Card favListWidget(int index, context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            size10,
          ),
        ),
        height: height / 7,
        width: width / 1.01,
        child: Stack(
          children: [
            GetBuilder<FavoritesController>(
              builder: (controller) => Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          height: height / 5.62,
                          width: width / 3.54,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              controller.favouriteBooks[index].mainPicture!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width / 1.9 + width / 9.69,
                        child: Row(
                          children: [
                            controller.favouriteBooks[index].category == null
                                ? SizedBox.shrink()
                                : Container(
                                    // constraints:
                                    //     BoxConstraints(maxWidth: width / 3.25),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xFFF83600), width: 0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: AutoSizeText(
                                        controller
                                            .favouriteBooks[index].category!,
                                        maxLines: 1,
                                        minFontSize: 8,
                                        maxFontSize: 10,
                                        style: TextStyle(
                                          fontFamily: "AnekTamil",
                                          overflow: TextOverflow.ellipsis,
                                          color: Color(0xFFF83600),
                                        )),
                                  ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Container(
                        width: (width / 3.25) * 2,
                        child: AutoSizeText(
                          controller.favouriteBooks[index].title!,
                          maxLines: 2,
                          minFontSize: 14,
                          maxFontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: "AnekTamil",
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: (width / 3.25) * 2,
                        child: AutoSizeText(
                          " ~ ${controller.favouriteBooks[index].authorName}",
                          maxLines: 1,
                          minFontSize: 10,
                          maxFontSize: 12,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: "AnekTamil",
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black54,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.bookOpen,
                            size: 14.r,
                            color: Color(0xFFF83600),
                          ),
                          SizedBox(width: width / 40),
                          Text(
                            controller.favouriteBooks[index].pages.toString(),
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: width / 9.69),
                          Icon(
                            FontAwesomeIcons.star,
                            size: 14.r,
                            color: Color(0xFFF83600),
                          ),
                          SizedBox(width: width / 40),
                          Text(
                            controller.favouriteBooks[index].rating.toString(),
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: width / 9.69),
                          Icon(
                            FontAwesomeIcons.eye,
                            size: 14.r,
                            color: Color(0xFFF83600),
                          ),
                          SizedBox(width: width / 40),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              controller.favouriteBooks[index].visitor
                                  .toString(),
                              style: TextStyle(
                                  fontFamily: "AnekTamil",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: InkWell(
                      onTap: () {
                        print(controller.favouriteBooks[index].bookId);
                        controller.getRemoveFavApiData(
                            controller.favouriteBooks[index].blogId!);
                        controller.update();
                      },
                      child:
                          Icon(Icons.favorite, color: Colors.red, size: 22.r),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
