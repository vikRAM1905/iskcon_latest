import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Screens/dashboard/dashboard.dart';
import 'package:iskcon/Screens/donate/donate_page.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/widgets/gradientButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';
import 'package:get/get.dart';
import 'package:iskcon/widgets/snackBar.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../../controller/book_page_controller.dart';

class ReadingPage extends StatelessWidget {
  ReadingPage({Key? key}) : super(key: key);

  final bookController = Get.put(BookPageController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Future<bool> onWillPop() {
      Get.changeTheme(ThemeData.light());
      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: GetBuilder<BookPageController>(
          builder: (controller) => Scaffold(
                backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
                body: Scaffold(
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.miniEndDocked,
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: primaryColor.withOpacity(0.6),
                    mini: true,
                    onPressed: () {
                      bottomSheet(context);
                    },
                    child: controller.isOpen.value
                        ? Icon(Icons.settings)
                        : Icon(Icons.settings),
                  ),
                  appBar: AppBar(
                    title: AutoSizeText(
                      controller.pageList.isEmpty
                          ? ""
                          : controller.pageList[0].title!,
                      minFontSize: 12,
                      style: TextStyle(fontSize: 14.r),
                    ),
                    elevation: 0,
                    backgroundColor: primaryColor,
                    centerTitle: true,
                    actions: [
                      IconButton(
                        onPressed: () {
                          controller.changeMode();
                          controller.showOverlay(
                              context, controller.page.value);
                          controller.update();
                          !controller.page.value
                              ? Get.snackbar("", "",
                                  maxWidth: width / 1.9,
                                  backgroundColor: primaryColor,
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.only(
                                    top: 20.r,
                                  ),
                                  titleText: Center(
                                      child: Text(
                                    "Scroll Mode Activated",
                                    style: TextStyle(
                                        fontFamily: "AnekTamil",
                                        color: Colors.white),
                                  )),
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: Duration(seconds: 1))
                              : Get.snackbar("", "",
                                  maxWidth: width / 1.9,
                                  backgroundColor: primaryColor,
                                  padding: EdgeInsets.only(
                                    top: 20.r,
                                  ),
                                  margin: EdgeInsets.all(0),
                                  titleText: Center(
                                      child: Text("Flip Mode Activated",
                                          style:
                                              TextStyle(color: Colors.white))),
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: Duration(seconds: 1));
                        },
                        icon: !controller.page.value
                            ? Container(
                                height: 30.r,
                                width: 30.r,
                                child: Image.asset("assets/images/swipe2.png"))
                            : Container(
                                height: 30.r,
                                width: 30.r,
                                child: Image.asset("assets/images/swipe3.png")),
                      ),
                    ],
                  ),
                  body: GetBuilder<BookPageController>(
                      builder: (controller) => !controller.page.value
                          ? controller.isLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  backgroundColor: primaryColor,
                                  strokeWidth: 1.5,
                                ))
                              : Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: SingleChildScrollView(
                                    child: SizedBox(
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            controller.pageList.length + 1,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return index <
                                                  controller.pageList.length
                                              ? Column(
                                                  children: [
                                                    SizedBox(
                                                      height: height / 168.8,
                                                    ),
                                                    if (index == 0)
                                                      SizedBox(
                                                        height: height / 168.8,
                                                      ),
                                                    if (index == 0)
                                                      AutoSizeText(
                                                        controller
                                                            .articleDetail[0]
                                                            .title!,
                                                        minFontSize: 16,
                                                        maxFontSize: 18,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "AnekTamil",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    if (index == 0)
                                                      SizedBox(
                                                        height: height / 84.4,
                                                      ),
                                                    if (index == 0)
                                                      FittedBox(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              "assets/images/quill-pen.png",
                                                              height: 25,
                                                              width: 25,
                                                            ),
                                                            AutoSizeText(
                                                              " ${controller.articleDetail[0].authorName!}",
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "AnekTamil",
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    if (index == 0)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    15.0,
                                                                vertical: 5),
                                                        child: Divider(),
                                                      ),
                                                    if (index == 0)
                                                      SizedBox(
                                                        height: height / 168.8,
                                                      ),
                                                    // if (index == 0)
                                                    //   Padding(
                                                    //     padding:
                                                    //         const EdgeInsets
                                                    //                 .symmetric(
                                                    //             horizontal:
                                                    //                 10.0),
                                                    //     child: Align(
                                                    //       alignment: Alignment
                                                    //           .centerLeft,
                                                    //       child: Container(
                                                    //           padding:
                                                    //               EdgeInsets
                                                    //                   .all(5),
                                                    //           decoration: BoxDecoration(
                                                    //               color: Colors
                                                    //                   .blue
                                                    //                   .withOpacity(
                                                    //                       0.5),
                                                    //               borderRadius:
                                                    //                   BorderRadius
                                                    //                       .circular(
                                                    //                           5)),
                                                    //           child: AutoSizeText(
                                                    //               controller
                                                    //                   .articleDetail[
                                                    //                       0]
                                                    //                   .category
                                                    //                   .toString())),
                                                    //     ),
                                                    //   ),
                                                    Container(
                                                        child: Html(
                                                      data: controller
                                                          .pageList[index]
                                                          .description,
                                                      style: {
                                                        'p': Style(
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            lineHeight:
                                                                LineHeight(1),
                                                            fontFamily:
                                                                "Krishna-Regular",
                                                            fontSize: FontSize(
                                                              bookController
                                                                  .size.value.r,
                                                            )),
                                                        'h1': Style(
                                                            lineHeight:
                                                                LineHeight(1),
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            fontFamily:
                                                                "Brahmanya",
                                                            fontSize: FontSize(
                                                                bookController
                                                                        .size
                                                                        .value
                                                                        .r +
                                                                    6.0)),
                                                        'h2': Style(
                                                            lineHeight:
                                                                LineHeight(1),
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            fontFamily:
                                                                "Brahmanya",
                                                            fontSize: FontSize(
                                                                bookController
                                                                        .size
                                                                        .value
                                                                        .r +
                                                                    5.0)),
                                                        'h3': Style(
                                                            lineHeight:
                                                                LineHeight(1),
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            fontFamily:
                                                                "Brahmanya",
                                                            fontSize: FontSize(
                                                                bookController
                                                                        .size
                                                                        .value
                                                                        .r +
                                                                    4.0)),
                                                        'h4': Style(
                                                            lineHeight:
                                                                LineHeight(1),
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            fontFamily:
                                                                "Brahmanya",
                                                            fontSize: FontSize(
                                                                bookController
                                                                        .size
                                                                        .value
                                                                        .r +
                                                                    3.0)),
                                                        'h5': Style(
                                                            lineHeight:
                                                                LineHeight(1),
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            fontFamily:
                                                                "Brahmanya",
                                                            fontSize: FontSize(
                                                                bookController
                                                                        .size
                                                                        .value
                                                                        .r +
                                                                    2.0)),
                                                        'h6': Style(
                                                            lineHeight:
                                                                LineHeight(1),
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            fontFamily:
                                                                "Brahmanya",
                                                            fontSize: FontSize(
                                                                bookController
                                                                        .size
                                                                        .value
                                                                        .r +
                                                                    1.0)),
                                                        "img": Style(
                                                          fontFamily:
                                                              "Brahmanya",
                                                        )
                                                      },
                                                      // onLinkTap: (url,_,_m,_d) => CommonUtils.launchUrl(url),
                                                    )),
                                                  ],
                                                )
                                              : Center(
                                                  child: Column(
                                                  children: [
                                                    Text("*******"),
                                                    GetBuilder<
                                                        BookPageController>(
                                                      builder: (controller) =>
                                                          GradientButton(
                                                        onPress: () {
                                                          controller
                                                                      .articleDetail[
                                                                          0]
                                                                      .userRating !=
                                                                  '0'
                                                              ? Get.back()
                                                              : showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return RatingDialog(
                                                                      enableComment:
                                                                          false,
                                                                      starColor:
                                                                          primaryColor,
                                                                      initialRating:
                                                                          5.0,
                                                                      title:
                                                                          Text(
                                                                        controller
                                                                            .articleDetail[0]
                                                                            .title!,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              22.r,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      message:
                                                                          Text(
                                                                        'Tap a star to set your rating for this Article.', // Add more description here if you want.',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "AnekTamil",
                                                                            fontSize:
                                                                                15.r),
                                                                      ),
                                                                      image: Image.network(controller
                                                                          .articleDetail[
                                                                              0]
                                                                          .mainPicture!),
                                                                      submitButtonText:
                                                                          'Rate',
                                                                      // commentHint:
                                                                      //     'Set your custom comment hint',
                                                                      onCancelled: () =>
                                                                          Get.offAll(() =>
                                                                              DashBoard()),
                                                                      onSubmitted:
                                                                          (response) {
                                                                        // print(
                                                                        //     'rating: ${response.rating}, comment: ${response.comment}');

                                                                        controller.articleRating(
                                                                            bookController.articleDetail[0].id!,
                                                                            response.rating.toString());
                                                                        controller
                                                                            .update();
                                                                        Get.offAll(() =>
                                                                            DashBoard());
                                                                        snackBarMsg(
                                                                            title:
                                                                                "Success",
                                                                            msg:
                                                                                "Rating added successfully",
                                                                            colors:
                                                                                Colors.white,
                                                                            bgColor: primaryColor);
                                                                      },
                                                                    );
                                                                  });
                                                        },
                                                        name: "back",
                                                        txtColor: Colors.white,
                                                        size: Size(width / 1.2,
                                                            height / 20),
                                                        border: false,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: height / 40),
                                                    GradientButton(
                                                      onPress: () => Get.to(
                                                          () => DonatePage()),
                                                      name: "Donate Now",
                                                      txtColor: Colors.red,
                                                      size: Size(width / 1.2,
                                                          height / 20),
                                                      border: true,
                                                    )
                                                  ],
                                                ));
                                        },
                                      ),
                                    ),
                                  ),
                                )
                          : controller.isLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  backgroundColor: primaryColor,
                                  strokeWidth: 1.5,
                                ))
                              : PageView.builder(
                                  controller: controller.pageController,
                                  itemCount: controller.pageList.length + 1,
                                  itemBuilder: (context, position) {
                                    return position < controller.pageList.length
                                        ? Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: SingleChildScrollView(
                                                child: Column(
                                              children: [
                                                if (position == 0)
                                                  SizedBox(
                                                    height: height / 168.8,
                                                  ),
                                                if (position == 0)
                                                  AutoSizeText(
                                                    controller.articleDetail[0]
                                                        .title!,
                                                    minFontSize: 16,
                                                    textAlign: TextAlign.center,
                                                    maxFontSize: 18,
                                                    style: TextStyle(
                                                        fontFamily: "AnekTamil",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                if (position == 0)
                                                  SizedBox(
                                                    height: height / 84.4,
                                                  ),
                                                if (position == 0)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/quill-pen.png",
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                      AutoSizeText(
                                                        " ${controller.articleDetail[0].authorName!}",
                                                        minFontSize: 10,
                                                        maxFontSize: 12,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "AnekTamil",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                if (position == 0)
                                                  SizedBox(
                                                    height: height / 168.8,
                                                  ),
                                                // if (position == 0)
                                                //   Padding(
                                                //     padding: const EdgeInsets
                                                //             .symmetric(
                                                //         horizontal: 10.0),
                                                //     child: Align(
                                                //       alignment:
                                                //           Alignment.centerLeft,
                                                //       child: Container(
                                                //           padding:
                                                //               EdgeInsets.all(5),
                                                //           decoration: BoxDecoration(
                                                //               color: Colors.blue
                                                //                   .withOpacity(
                                                //                       0.5),
                                                //               borderRadius:
                                                //                   BorderRadius
                                                //                       .circular(
                                                //                           5)),
                                                //           child: AutoSizeText(
                                                //               controller
                                                //                   .articleDetail[
                                                //                       0]
                                                //                   .category
                                                //                   .toString())),
                                                //     ),
                                                //   ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0, top: 5),
                                                    child: Text(
                                                      "Page ${position + 1}",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "AnekTamil",
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                                Divider(),
                                                Container(
                                                  child: Html(
                                                    data: controller
                                                        .pageList[position]
                                                        .description,
                                                    style: {
                                                      'p': Style(
                                                          lineHeight:
                                                              LineHeight(1),
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          fontFamily:
                                                              "Krishna-Regular",
                                                          letterSpacing: 1,
                                                          fontSize: FontSize(
                                                            bookController
                                                                .size.value.r,
                                                          )),
                                                      'h1': Style(
                                                          lineHeight:
                                                              LineHeight(1),
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          letterSpacing: 1,
                                                          fontFamily:
                                                              "Brahmanya",
                                                          fontSize: FontSize(
                                                              bookController
                                                                      .size
                                                                      .value
                                                                      .r +
                                                                  6.0)),
                                                      'h2': Style(
                                                          lineHeight:
                                                              LineHeight(1),
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          letterSpacing: 1,
                                                          fontFamily:
                                                              "Brahmanya",
                                                          fontSize: FontSize(
                                                              bookController
                                                                      .size
                                                                      .value
                                                                      .r +
                                                                  5.0)),
                                                      'h3': Style(
                                                          lineHeight:
                                                              LineHeight(1),
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          letterSpacing: 1,
                                                          fontFamily:
                                                              "Brahmanya",
                                                          fontSize: FontSize(
                                                              bookController
                                                                      .size
                                                                      .value
                                                                      .r +
                                                                  4.0)),
                                                      'h4': Style(
                                                          lineHeight:
                                                              LineHeight(1),
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          letterSpacing: 1,
                                                          fontFamily:
                                                              "Brahmanya",
                                                          fontSize: FontSize(
                                                              bookController
                                                                      .size
                                                                      .value
                                                                      .r +
                                                                  3.0)),
                                                      'h5': Style(
                                                          lineHeight:
                                                              LineHeight(1),
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          letterSpacing: 1,
                                                          fontFamily:
                                                              "Brahmanya",
                                                          fontSize: FontSize(
                                                              bookController
                                                                      .size
                                                                      .value
                                                                      .r +
                                                                  2.0)),
                                                      'h6': Style(
                                                          lineHeight:
                                                              LineHeight(1),
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          letterSpacing: 1,
                                                          fontFamily:
                                                              "Brahmanya",
                                                          fontSize: FontSize(
                                                              bookController
                                                                      .size
                                                                      .value
                                                                      .r +
                                                                  1.0)),
                                                      "img": Style(
                                                        fontFamily: "Brahmanya",
                                                      )
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )),
                                          )
                                        : Center(
                                            child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("* * *"),
                                              SizedBox(
                                                height: 20.r,
                                              ),
                                              GetBuilder<BookPageController>(
                                                builder: (controller) =>
                                                    GradientButton(
                                                  onPress: () {
                                                    controller.articleDetail[0]
                                                                .userRating !=
                                                            '0'
                                                        ? Get.back()
                                                        : showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return RatingDialog(
                                                                enableComment:
                                                                    false,
                                                                starColor:
                                                                    primaryColor,
                                                                initialRating:
                                                                    5.0,
                                                                title: Text(
                                                                  controller
                                                                      .articleDetail[
                                                                          0]
                                                                      .title!,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        22,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                message: Text(
                                                                  'Tap a star to set your rating for this Article.', // Add more description here if you want.',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "AnekTamil",
                                                                      fontSize:
                                                                          15.r),
                                                                ),
                                                                image: Image.network(
                                                                    controller
                                                                        .articleDetail[
                                                                            0]
                                                                        .mainPicture!),
                                                                submitButtonText:
                                                                    'Rate',
                                                                // commentHint:
                                                                //     'Set your custom comment hint',
                                                                onCancelled: () =>
                                                                    Get.offAll(() =>
                                                                        DashBoard()),
                                                                onSubmitted:
                                                                    (response) {
                                                                  print(
                                                                      'rating: ${response.rating}, comment: ${response.comment}');

                                                                  controller.articleRating(
                                                                      bookController
                                                                          .articleDetail[
                                                                              0]
                                                                          .id!,
                                                                      response
                                                                          .rating
                                                                          .toString());
                                                                  controller
                                                                      .update();
                                                                  Get.offAll(() =>
                                                                      DashBoard());
                                                                  snackBarMsg(
                                                                      title:
                                                                          "Success",
                                                                      msg:
                                                                          "Rating added successfully",
                                                                      colors: Colors
                                                                          .white,
                                                                      bgColor:
                                                                          primaryColor);
                                                                },
                                                              );
                                                            });
                                                  },
                                                  name: "back",
                                                  txtColor: Colors.white,
                                                  size: Size(
                                                      width / 1.2, height / 20),
                                                  border: false,
                                                ),
                                              ),
                                              SizedBox(
                                                height: height / 40,
                                              ),
                                              GradientButton(
                                                onPress: () =>
                                                    Get.to(() => DonatePage()),
                                                name: "Donate Now",
                                                txtColor: Colors.red,
                                                size: Size(
                                                    width / 1.2, height / 20),
                                                border: true,
                                              )
                                            ],
                                          ));
                                  },
                                )),
                ),
              )),
    );
  }

  Future<dynamic> bottomSheet(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return showModalBottomSheet(
        constraints: BoxConstraints(
          maxHeight: 250,
        ),
        context: context,
        builder: (context) {
          return GetBuilder<BookPageController>(
            builder: (controller) => controller.articleDetail.isEmpty
                ? SizedBox()
                : Center(
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(children: [
                                Text("Category"),
                                Spacer(),
                                Text(
                                  "Pages",
                                ),
                              ]),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  AutoSizeText(
                                      controller.articleDetail[0].category!,
                                      minFontSize: 10,
                                      style: TextStyle(
                                        fontFamily: "AnekTamil",
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Spacer(),
                                  AutoSizeText(
                                      "${controller.articleDetail[0].pages.toString()}",
                                      style: TextStyle(
                                        fontFamily: "AnekTamil",
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              width: width / 1.12,
                              child: Divider(
                                thickness: 1.5,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: height / 16.88,
                                      width: width / 7.8,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Get.isDarkMode
                                              ? primaryColor
                                              : primaryColor),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.brightness_4_rounded,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        onPressed: () {
                                          controller.brightSliderVisible =
                                              !controller.brightSliderVisible;

                                          if (controller.fontSliderVisible)
                                            controller.fontSliderVisible =
                                                false;
                                          controller.update();
                                        },
                                      ),
                                    ),
                                    AutoSizeText(
                                      "Brightness",
                                      minFontSize: 14,
                                      style: TextStyle(
                                        fontFamily: "AnekTamil",
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: height / 16.88,
                                      width: width / 7.8,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Get.isDarkMode
                                              ? primaryColor
                                              : primaryColor),
                                      child: IconButton(
                                          icon: Icon(
                                            controller.isDarkMode
                                                ? Icons.dark_mode
                                                : Icons.light_mode,
                                            color: controller.isDarkMode
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                          onPressed: () =>
                                              controller.toggleDarkMode()),
                                    ),
                                    AutoSizeText(
                                      "Mode",
                                      minFontSize: 14,
                                      style: TextStyle(
                                          fontFamily: "AnekTamil",
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: height / 16.88,
                                      width: width / 7.8,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Get.isDarkMode
                                              ? primaryColor
                                              : primaryColor),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.text_format_sharp,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        onPressed: () {
                                          controller.fontSliderVisible =
                                              !controller.fontSliderVisible;

                                          if (controller.brightSliderVisible)
                                            controller.brightSliderVisible =
                                                false;
                                          controller.update();
                                        },
                                      ),
                                    ),
                                    AutoSizeText(
                                      "Font Size",
                                      minFontSize: 14,
                                      style: TextStyle(
                                          fontFamily: "AnekTamil",
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 28.1,
                            )
                          ],
                        ),
                        Positioned(
                            child: Align(
                          alignment: Alignment.topCenter,
                          child: Visibility(
                            visible: controller.brightSliderVisible,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: width / 1.77,
                                height: height / 28.1,
                                child: Slider(
                                  value: controller.brightness.value,
                                  onChanged: (value) {
                                    controller.brightness.value = value;
                                    FlutterScreenWake.setBrightness(
                                        controller.brightness.value);
                                    controller.update();
                                  },
                                  onChangeEnd: (_) {
                                    Future.delayed(Duration(milliseconds: 500))
                                        .then((value) {
                                      controller.brightSliderVisible =
                                          !controller.brightSliderVisible;
                                      controller.update();
                                    });
                                  },
                                  activeColor: primaryColor,
                                  inactiveColor: primaryColor.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        )),
                        Positioned(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Visibility(
                              visible: controller.fontSliderVisible,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: width / 1.77,
                                  height: height / 28.1,
                                  child: Slider(
                                    value: controller.size.value,
                                    onChanged: (value) {
                                      controller.size.value = value;
                                      // controller.updateSize(context, value);
                                      controller.update();
                                    },
                                    divisions: 5,
                                    min: 16.0,
                                    max: 24.0,
                                    onChangeEnd: (_) {
                                      Future.delayed(
                                              Duration(milliseconds: 500))
                                          .then((value) {
                                        controller.fontSliderVisible =
                                            !controller.fontSliderVisible;
                                        controller.update();
                                      });
                                    },
                                    activeColor: primaryColor,
                                    inactiveColor:
                                        primaryColor.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          );
        });
  }
}
