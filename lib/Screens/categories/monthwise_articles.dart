import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Utils/contants.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/Utils/size_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controller/monthwise_articles_controller.dart';
import '../dashboard/search_field_page.dart';

class MonthWiseBooksPage extends StatelessWidget {
  MonthWiseBooksPage({Key? key}) : super(key: key);
  final controller = Get.put(
    MonthWiseBooksController(),
  );
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Obx(
      () => Scaffold(
        backgroundColor: Get.isDarkMode ? Colors.grey[600] : Color(0xFFFFFAF4),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: primaryColor,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            controller.isLoading.value
                ? ""
                : controller.monthWiseBooks.isEmpty
                    ? ""
                    : controller.monthWiseBooks[0].month!,
            style: TextStyle(
              fontFamily: "AnekTamil",
              color: Colors.white,
            ),
          ),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () => Get.to(() => SearchBookPage()),
                child: Icon(
                  Icons.search,
                  size: 30.r,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  strokeWidth: 1.5,
                ),
              )
            : controller.monthWiseBooks.isEmpty
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
                          itemCount: controller.monthWiseBooks.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: InkWell(
                                child: catWiseListWidget(index, context),
                                onTap: () {
                                  Get.toNamed(ROUTE_BOOK_INTRO,
                                      arguments:
                                          controller.monthWiseBooks[index].id);
                                },
                              ),
                            );
                          },
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
            GetBuilder<MonthWiseBooksController>(
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
                          controller.monthWiseBooks[index].mainPicture!,
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
                        width: width / 1.85,
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
                                  controller.monthWiseBooks[index].category!,
                                  maxLines: 1,
                                  minFontSize: 8,
                                  style: TextStyle(
                                      fontFamily: "AnekTamil",
                                      color: Color(0xFFF83600),
                                      fontSize: 8.r)),
                            ),
                            Spacer(),
                            AutoSizeText(
                              controller.monthWiseBooks[index].showDate!,
                              style: TextStyle(
                                  fontFamily: "AnekTamil",
                                  color: Color(0xFFF83600),
                                  fontSize: 11.r),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: (width / 3.25) * 2,
                        child: AutoSizeText(
                          controller.monthWiseBooks[index].title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: "AnekTamil",
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              fontSize: 12.r,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: (width / 3.25) * 2,
                        child: AutoSizeText(
                          " ~" +
                              "${controller.monthWiseBooks[index].authorName}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: "AnekTamil",
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black54,
                            fontSize: 10.r,
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
                            controller.monthWiseBooks[index].pages.toString(),
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontSize: 11.r,
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
                            controller.monthWiseBooks[index].rating.toString(),
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontSize: 11.r,
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
                              controller.monthWiseBooks[index].view.toString(),
                              style: TextStyle(
                                  fontFamily: "AnekTamil",
                                  fontSize: 11.r,
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
