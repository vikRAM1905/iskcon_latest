import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Screens/dashboard/dashboard.dart';
import 'package:iskcon/Utils/contants.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/Utils/size_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../controller/search_controller.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final controller = Get.put(SearchController());
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
                  Get.offAll(() => DashBoard());
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              title: Text("Search Results",
                  style:
                      TextStyle(fontFamily: "AnekTamil", color: Colors.white)),
              elevation: 0,
            ),
            body: controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                    backgroundColor: primaryColor,
                    strokeWidth: 1.5,
                  ))
                : controller.searchResult.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: height / 4.2,
                                width: width / 1.9,
                                child:
                                    Image.asset('assets/images/no_data.png')),
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
                              itemCount: controller.searchResult.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: InkWell(
                                      onTap: () {
                                        Get.toNamed(ROUTE_BOOK_INTRO,
                                            arguments: controller
                                                .searchResult[index].id);
                                      },
                                      child: catWiseListWidget(index, context)),
                                );
                              },
                            ),
                          ),
                        ),
                      )),
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
            GetBuilder<SearchController>(
              builder: (controller) => Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      height: height / 5.62,
                      width: width / 3.54,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          controller.searchResult[index].mainPicture!,
                          fit: BoxFit.fill,
                        ),
                      ),
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
                                  controller.searchResult[index].category!,
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
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: AutoSizeText(
                                controller.searchResult[index].showDate!,
                                style: TextStyle(
                                  fontFamily: "AnekTamil",
                                  color: Color(0xFFF83600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: (width / 3.25) * 2,
                        child: AutoSizeText(
                          controller.searchResult[index].title!,
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
                          " ~ ${controller.searchResult[index].authorName}",
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
                            controller.searchResult[index].pages.toString(),
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
                            controller.searchResult[index].rating.toString(),
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
                            controller.searchResult[index].view.toString(),
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
