import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Screens/reading/photoBook_page.dart';
import 'package:iskcon/Screens/reading/reading_page.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/controller/book_intro_controller.dart';
import 'package:iskcon/controller/favourite_controller.dart';
import 'package:iskcon/widgets/gradientButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BookIntroPage extends StatelessWidget {
  BookIntroPage({Key? key}) : super(key: key);
  final bookIntroController = Get.put(BookIntroPageController());
  final favController = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<BookIntroPageController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
        body: controller.isLoading.value || controller.blogList.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                strokeWidth: 1.5,
              ))
            : SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(children: [
                        Container(
                          height: height / 6.85 * 3,
                          child: Image.network(
                            controller.blogList[0].mainPicture!,
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        ),
                        SizedBox(
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              SizedBox(
                                height: height / 40,
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AutoSizeText(
                                    controller.blogList[0].title!,
                                    minFontSize: 16,
                                    maxFontSize: 18,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "AnekTamil",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/quill-pen.png",
                                        height: 25.r,
                                        width: 25.r,
                                      ),
                                      AutoSizeText(
                                        " ${controller.blogList[0].authorName!}",
                                        textAlign: TextAlign.center,
                                        minFontSize: 10,
                                        maxFontSize: 12,
                                        style: TextStyle(
                                          fontFamily: "AnekTamil",
                                          color: Color(0xFF454545),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height / 84.4,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5),
                                child: Container(
                                  height: height / 25.0 * 2,
                                  width: width / 3.9 * 3,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFF2EE),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: width / 3.9,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              "Pages",
                                              style: TextStyle(
                                                fontFamily: "AnekTamil",
                                                fontSize: 14.r,
                                                color: Color(0xFFADADAD),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.bookOpen,
                                                  color: Color(0xFFF83600),
                                                  size: 16.r,
                                                ),
                                                SizedBox(
                                                  width: width / 40,
                                                ),
                                                AutoSizeText(
                                                  controller.blogList[0].pages
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontFamily: "AnekTamil",
                                                      fontSize: 16.r,
                                                      color: Get.isDarkMode
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width / 3.9,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              "Rating",
                                              style: TextStyle(
                                                  fontFamily: "AnekTamil",
                                                  fontSize: 14.r,
                                                  color: Color(0xFFADADAD)),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.star,
                                                  color: Color(0xFFF83600),
                                                  size: 16.r,
                                                ),
                                                SizedBox(
                                                  width: width / 40,
                                                ),
                                                AutoSizeText(
                                                  controller.blogList[0].rating
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontFamily: "AnekTamil",
                                                      fontSize: 16.r,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width / 3.9,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              "Read",
                                              style: TextStyle(
                                                fontFamily: "AnekTamil",
                                                fontSize: 14.r,
                                                color: Color(0xFFADADAD),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.eye,
                                                  color: Color(0xFFF83600),
                                                  size: 16.r,
                                                ),
                                                SizedBox(
                                                  width: width / 40,
                                                ),
                                                AutoSizeText(
                                                  controller.blogList[0].view
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontFamily: "AnekTamil",
                                                      fontSize: 16.r,
                                                      color: Get.isDarkMode
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height / 168.8,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFFFF2EE),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: AutoSizeText(controller
                                          .blogList[0].category!
                                          .toString())),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 10),
                                child: Container(
                                  // height: height / 10.55,
                                  child: Html(
                                    data: controller.blogList[0].description!,
                                    style: {
                                      'p': Style(
                                          fontFamily: "Krishna-Regular",
                                          lineHeight: LineHeight(1.5),
                                          fontWeight: FontWeight.w100,
                                          fontSize: FontSize(
                                            14.r,
                                          )),
                                      'h1': Style(
                                          fontWeight: FontWeight.w100,
                                          fontFamily: "Brahmanya",
                                          fontSize: FontSize(20.r)),
                                      'h2': Style(
                                          fontWeight: FontWeight.w100,
                                          fontFamily: "Brahmanya",
                                          fontSize: FontSize(19.r)),
                                      'h3': Style(
                                          fontWeight: FontWeight.w100,
                                          fontFamily: "Brahmanya",
                                          fontSize: FontSize(18.r)),
                                      'h4': Style(
                                          fontWeight: FontWeight.w100,
                                          fontFamily: "Brahmanya",
                                          fontSize: FontSize(17.r)),
                                      'h5': Style(
                                          fontWeight: FontWeight.w100,
                                          fontFamily: "Brahmanya",
                                          fontSize: FontSize(16.r)),
                                      'h6': Style(
                                          fontWeight: FontWeight.w100,
                                          fontFamily: "Brahmanya",
                                          fontSize: FontSize(15.r)),
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.r,
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                    Positioned(
                      left: 5.r,
                      top: 5.r,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: height / 28.1,
                              width: width / 13,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5.r,
                      top: 5.r,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Center(
                                  child: Text(
                                controller.blogList[0].showDate!,
                                style: TextStyle(
                                    fontFamily: "AnekTamil",
                                    color: Color(0xFFF83600),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.r),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        floatingActionButton: controller.isLoading.value ||
                controller.blogList.isEmpty
            ? SizedBox()
            : Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: height / 14.55,
                  color: Colors.white,
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Get.isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                    blurRadius: 10,
                                    offset: Offset(5, 5),
                                  ),
                                ],
                              ),
                              child: GradientButton(
                                size: Size(width / 1.2, height / 21.1),
                                name: 'Continue Reading',
                                onPress: () {
                                  controller
                                      .articleVisit(controller.blogList[0].id!);
                                  controller.blogList[0].type == 3
                                      ? Get.to(
                                          () => ComicPage(
                                              // type: "anime",
                                              ),
                                          arguments: controller.blogList[0].id)
                                      : Get.to(() => ReadingPage(),
                                          arguments: controller.blogList[0].id);
                                },
                                border: false,
                                gradient: gradientOpp,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              !controller.isFav.value
                                  ? favController.getAddToFavApiData(
                                      controller.blogList[0].id)
                                  : favController.getRemoveFavApiData(
                                      controller.blogList[0].id);
                              controller.addOrRemove();
                              !controller.isFav.value
                                  ? Get.snackbar(
                                      "Done", "Removed from favourites",
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: primaryColor,
                                      duration: Duration(seconds: 1))
                                  : Get.snackbar("Done", "Added to favourites",
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: primaryColor,
                                      duration: Duration(seconds: 1));
                            },
                            child: Container(
                              height: height / 21.1,
                              width: width / 8.73,
                              decoration: BoxDecoration(
                                  color: Color(0xFFFD9319),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Icon(
                                  controller.isFav.value
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: controller.isFav.value
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ]),
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    });
  }
}
