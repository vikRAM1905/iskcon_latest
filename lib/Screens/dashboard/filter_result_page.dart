import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Screens/dashboard/dashboard.dart';
import 'package:iskcon/Utils/contants.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/Utils/size_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iskcon/controller/favourite_controller.dart';
import '../../controller/filter_controller.dart';
import '../../controller/filter_result_controller.dart';
import 'filter_page.dart';

class FilterResultPage extends StatelessWidget {
  FilterResultPage({Key? key}) : super(key: key);
  final resultController = Get.put(FilterResultController());
  final filterController = Get.put(FilterController());
  final favController = Get.put(FavoritesController());
  List<String> months = [];
  List<String> categories = [];
  var year = "1991";
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Future<bool> onWillPop() {
      Get.offAll(DashBoard());
      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Obx(
        () => Scaffold(
          backgroundColor:
              Get.isDarkMode ? Colors.grey[600] : Color(0xFFFFFAF4),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: primaryColor,
            leading: IconButton(
              onPressed: () {
                Get.offAll(DashBoard());
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: Text("Articles",
                style: TextStyle(fontFamily: "AnekTamil", color: Colors.white)),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: InkWell(
                  onTap: () {
                    filterController.clearAll();
                    months.clear();
                    filterController.selectedYear.value = '2009';
                    categories.clear();
                    resultController.resultList.clear();
                    filterController.update();
                    resultController.update();
                    Get.offAll(() => FilterPage());
                  },
                  child: Container(
                    height: 25.r,
                    width: 25.r,
                    child: Image.asset(
                      "assets/images/filter_btn.png",
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
            elevation: 0,
          ),
          body: resultController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  strokeWidth: 1.5,
                ))
              : resultController.resultList.isEmpty
                  ? Center(
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
                    )
                  : Container(
                      color: primaryColor,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: Get.isDarkMode
                              ? Colors.grey[600]
                              : Color(0xFFFFFAF4),
                        ),
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            padding: EdgeInsets.all(5),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: resultController.resultList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: InkWell(
                                    onTap: () {
                                      Get.toNamed(ROUTE_BOOK_INTRO,
                                          arguments: resultController
                                              .resultList[index].id);
                                    },
                                    child: catWiseListWidget(index, context)),
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

  Card catWiseListWidget(int index, context) {
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
        height: (height / 12.50) * 2,
        width: width / 1.01,
        child: Stack(
          children: [
            GetBuilder<FilterResultController>(
              builder: (controller) => Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height / 8.5,
                          width: width / 3.54,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.network(
                              controller.resultList[index].mainPicture!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: height / 33.76,
                          width: width / 3.54,
                          color: Colors.white,
                          // padding: const EdgeInsets.only(right: 10.0),
                          child: Center(
                            child: AutoSizeText(
                              controller.resultList[index].showDate!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "AnekTamil",
                                color: Color(0xFFF83600),
                              ),
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
                        width: (width / 3.25) * 2,
                        child: Row(
                          children: [
                            Container(
                              constraints:
                                  BoxConstraints(maxWidth: width / 3.25),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFF83600), width: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: AutoSizeText(
                                  controller.resultList[index].category!,
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
                            InkWell(
                              onTap: () {
                                !controller.isFav.value
                                    ? favController.getAddToFavApiData(
                                        controller.resultList[index].id)
                                    : favController.getRemoveFavApiData(
                                        controller.resultList[index].id);
                                controller.addOrRemove();
                                !controller.isFav.value
                                    ? Get.snackbar(
                                        "Done", "Removed from favourites",
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: primaryColor,
                                        duration: Duration(seconds: 1))
                                    : Get.snackbar(
                                        "Done", "Added to favourites",
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: primaryColor,
                                        duration: Duration(seconds: 1));
                              },
                              child: Center(
                                child: Icon(
                                  controller.isFav.value
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: controller.isFav.value
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: (width / 3.25) * 2,
                        child: AutoSizeText(
                          controller.resultList[index].title!,
                          maxLines: 2,
                          minFontSize: 12,
                          maxFontSize: 14,
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
                          " ~ ${controller.resultList[index].authorName}",
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
                            controller.resultList[index].pages.toString(),
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontSize: 12.r,
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
                            controller.resultList[index].rating.toString(),
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontSize: 12.r,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: width / 9.69),
                          Icon(
                            FontAwesomeIcons.eye,
                            size: 14.r,
                            color: Color(0xFFF83600),
                          ),
                          SizedBox(width: width / 40),
                          Text(
                            controller.resultList[index].view.toString(),
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontSize: 12.r,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_ios,
                  // size: 20,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
