import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Screens/dashboard/dashboard.dart';
import 'package:iskcon/Screens/dashboard/filter_result_page.dart';
import 'package:iskcon/Screens/dashboard/tagSearch_page.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/widgets/gradientButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/filter_controller.dart';
import '../../widgets/snackBar.dart';

class FilterPage extends StatelessWidget {
  FilterPage({Key? key}) : super(key: key);
  final filterController = Get.put(FilterController());
  List<String> months = [];
  List<String> categories = [];
  // String author = '';
  // var year = "2009";
  SizedBox yearPicker(BuildContext context, height, width) {
    return SizedBox(
      width: width / 1.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          primary: primaryColor,
        ),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                filterController.selectedYear.value,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontFamily: "AnekTamil",
                ),
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        onPressed: () => showMaterialScrollPicker<String>(
          context: context,
          title: ' Select Year',
          showDivider: false,
          headerColor: primaryColor,
          items: filterController.yearList,
          selectedItem: filterController.selectedYear.value,
          onChanged: (value) {
            filterController.selectedYear.value = value;
            // year = value;
            filterController.update();
          },
          onCancelled: () => print('Scroll Picker cancelled'),
          onConfirmed: () => print('Scroll Picker confirmed'),
        ),
      ),
    );
  }

  SizedBox authorPicker(BuildContext context, height, width) {
    return SizedBox(
      width: width / 1.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          primary: primaryColor,
        ),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                filterController.selectedAuthor.value,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontFamily: "AnekTamil",
                ),
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        onPressed: () => showMaterialRadioPicker<String>(
          context: context,
          title: 'Select Author',
          headerColor: primaryColor,
          items: filterController.authorList,
          selectedItem: filterController.selectedAuthor.value,
          onChanged: (value) {
            filterController.selectedAuthor.value = value;
            // author = value;
            filterController.update();
          },
          onCancelled: () => print('Scroll Picker cancelled'),
          onConfirmed: () => print('Scroll Picker confirmed'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    filterController.selectedAuthor.value = 'All Authors';
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // print("============${controller.catList.length}");
    final double itemHeight = (height - kToolbarHeight - height / 1.35) / 2;
    final double itemWidth = width;
    final double catHeight = (height - kToolbarHeight - height / 1.65) / 6;
    final double catWidth = width;
    return GetBuilder<FilterController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.offAll(DashBoard());
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Filter",
            style: TextStyle(
                fontFamily: "AnekTamil",
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            months.isNotEmpty || categories.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: TextButton(
                      onPressed: () {
                        controller.clearAll();
                        months.clear();
                        controller.selectedYear.value = 'Choose Year';
                        controller.selectedAuthor.value = 'All Authors';
                        // year = controller.selectedYear.value
                        // .toString()
                        // .substring(0, 4);
                        categories.clear();
                        controller.selectAll.value = false;
                        controller.update();
                      },
                      child: AutoSizeText(
                        "Clear All",
                        style: TextStyle(
                            fontFamily: "AnekTamil", color: Colors.white),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: TextButton(
                        onPressed: () {
                          controller.selectAll.value = true;
                          // for (int i = 0;
                          //     i < controller.isMonthChecked.length;
                          //     i++) {
                          //   controller.isMonthChecked[i] = true;
                          // }

                          for (int j = 0;
                              j < controller.isCatChecked.length;
                              j++) {
                            controller.isCatChecked[j] = true;
                          }

                          // for (int k = 0;
                          //     k < controller.isAuthorsChecked.length;
                          //     k++) {
                          //   controller.isAuthorsChecked[k] = true;
                          // }
                          // months.addAll(controller.monthList);
                          categories.addAll(controller.allCat);
                          // controller.selectedYear.value != 'Choose Year'
                          //     ? controller.selectedYear.value = 'Choose Year'
                          //     : controller.selectedYear.value;
                          controller.selectedYear.value = "Choose Year";
                          controller.selectedAuthor.value = 'All Authors';
                          //     ? controller.selectedAuthor.value =
                          //         'All Authors'
                          //     :
                          //      controller.selectedAuthor.value;
                          // year = DateTime.now().toString().substring(0, 4);
                          controller.update();
                        },
                        child: AutoSizeText(
                          "Select All",
                          style: TextStyle(
                              fontFamily: "AnekTamil", color: Colors.white),
                        )),
                  ),
          ],
          elevation: 0,
          backgroundColor: primaryColor,
        ),
        body: controller.isLoading.value &&
                (controller.catList.isEmpty || controller.monthList.isEmpty)
            ? const Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                strokeWidth: 1.5,
              ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 84.4,
                    ),
                    InkWell(
                      onTap: () async {
                        Get.to(() => TagSearch());
                      },
                      child: Container(
                        height: height / 21.1,
                        width: width / 1.05,
                        decoration: BoxDecoration(
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: TextField(
                          enabled: false,
                          autofocus: false,
                          onTap: () async {
                            Get.to(() => TagSearch());
                          },
                          decoration: new InputDecoration(
                            labelText: '   Search by Tag',
                            labelStyle: TextStyle(
                                fontSize: 12.r,
                                leadingDistribution:
                                    TextLeadingDistribution.proportional),
                            prefixText: ' ',
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.search,
                                color: primaryColor,
                                size: 18.r,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 42.2,
                    ),
                    Text(
                      "OR",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: height / 168.8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            "Author",
                            minFontSize: 18,
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    authorPicker(context, height, width),
                    SizedBox(
                      height: height / 84.4,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            "Months",
                            minFontSize: 18,
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      child: GridView.count(
                        childAspectRatio: (itemWidth / itemHeight),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: [
                          for (int i = 0; i < controller.monthList.length; i++)
                            ListTile(
                              title: AutoSizeText(
                                controller.monthList[i],
                                style: TextStyle(
                                    fontFamily: "AnekTamil",
                                    fontWeight: FontWeight.bold),
                              ),
                              leading: Checkbox(
                                  activeColor: Color(0xFFF83600),
                                  onChanged: (checked) {
                                    controller.isMonthChecked[i] = checked!;
                                    controller.update();
                                    if (controller.isMonthChecked[i] == false) {
                                      months.removeWhere(((element) =>
                                          element == controller.monthList[i]));
                                    } else
                                      months.add(
                                          controller.monthList[i].toString());
                                  },
                                  value: controller.isMonthChecked[i]),
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 40.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            "Year",
                            minFontSize: 18,
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    // Container(
                    //   height: 200,
                    //   width: 400,
                    //   child: CupertinoPicker(
                    //     selectionOverlay:
                    //         CupertinoPickerDefaultSelectionOverlay(
                    //       capEndEdge: false,
                    //       capStartEdge: false,
                    //       background: Color.fromARGB(30, 152, 128, 76),
                    //     ),
                    //     useMagnifier: true,
                    //     magnification: 2.0,
                    //     backgroundColor: Color.fromARGB(0, 185, 133, 65),
                    //     children: <Widget>[
                    //       for (int i = 0; i < controller.yearList.length; i++)
                    //         Text(
                    //           controller.yearList[i],
                    //           style:
                    //               TextStyle(color: primaryColor, fontSize: 16),
                    //         ),
                    //     ],
                    //     itemExtent: 28, //height of each item
                    //     looping: true,
                    //     onSelectedItemChanged: (int index) {
                    //       year = controller.yearList[index];
                    //     },
                    //   ),
                    // ),
                    yearPicker(context, height, width),

                    SizedBox(
                      height: height / 40.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            "Categories",
                            minFontSize: 18,
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      child: GridView.count(
                        childAspectRatio: (catWidth / catHeight),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 1,
                        children: [
                          for (int i = 0; i < controller.catList.length; i++)
                            ListTile(
                              title: Container(
                                child: Text(
                                  controller.catList[i].title!,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontFamily: "AnekTamil",
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              leading: Checkbox(
                                  activeColor: Color(0xFFF83600),
                                  onChanged: (checked) {
                                    controller.isCatChecked[i] = checked!;
                                    controller.update();
                                    if (controller.isCatChecked[i] == false) {
                                      categories.removeWhere(((element) =>
                                          element ==
                                          controller.catList[i].id.toString()));
                                    } else
                                      categories.add(
                                          controller.catList[i].id.toString());
                                  },
                                  value: controller.isCatChecked[i]),
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 10.1,
                    )
                  ],
                ),
              ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: GradientButton(
            onPress: () {
              // if (months.isEmpty || categories.isEmpty) {
              //   months.addAll(controller.monthList);
              //   categories.addAll(controller.allCat);
              //   print("====================$months");
              //   print("====================$categories");
              //   print("====================$author");
              //   Get.to(
              //     () => FilterResultPage(),
              //     arguments: {
              //       "months": months,
              //       "year": controller.selectedYear.value,
              //       "categories": categories,
              //       "author_name": [author]
              //     },
              //   );
              // }
              // if (author == "") author = controller.allAuthors[0];
              print(controller.selectedYear.value);
              print(controller.selectedAuthor.value);
              print("====================$months");
              print("====================$categories");
              print("====================${controller.yearList}");
              print("====================${controller.authorList}");
              // print("====================$author");
              // if (controller.selectedYear.value != "Choose Year") {
              //   if (controller.selectedAuthor.value != "All Authors") {
              //     if (months.isEmpty) {
              //       months.addAll(controller.monthList);
              //       if (categories.isEmpty) {
              //         categories.addAll(controller.allCat);
              //         // if (author != '') {
              //         Get.to(
              //           () => FilterResultPage(),
              //           arguments: {
              //             "months": months,
              //             "year": [controller.selectedYear.value],
              //             "categories": categories,
              //             "author_name": [controller.selectedAuthor.value]
              //           },
              //         );
              //         // } else {
              //         //   snackBarMsg(
              //         //       icon: Icons.warning,
              //         //       title: "Author",
              //         //       msg: "select Author / Authors",
              //         //       bgColor: primaryColor,
              //         //       colors: Colors.white);
              //         // }
              //       } else {
              //         Get.to(
              //           () => FilterResultPage(),
              //           arguments: {
              //             "months": months,
              //             "year": [controller.selectedYear.value],
              //             "categories": categories,
              //             "author_name": [controller.selectedAuthor.value]
              //           },
              //         );
              //       }
              //     } else {
              //       Get.to(
              //         () => FilterResultPage(),
              //         arguments: {
              //           "months": months,
              //           "year": [controller.selectedYear.value],
              //           "categories": categories,
              //           "author_name": [controller.selectedAuthor.value]
              //         },
              //       );
              //     }
              //   } else {
              //     snackBarMsg(
              //         icon: Icons.warning,
              //         title: "Author",
              //         msg: "All Authors",
              //         bgColor: primaryColor,
              //         colors: Colors.white);
              //   }
              // } else {
              //   snackBarMsg(
              //       icon: Icons.warning,
              //       title: "Year",
              //       msg: "Choose Year",
              //       bgColor: primaryColor,
              //       colors: Colors.white);
              // }

              // if(controller.selectAll.value == true && controller.selectedYear.value == "Choose Year" && controller.selectedAuthor.value == "All Authors"){

              // }
              // if (controller.selectedYear.value == "Choose Year") {
              //   years.addAll(controller.yearList);
              // }
              //  if (controller.selectedAuthor.value == "Choose Year") {
              //   authors.addAll(controller.allAuthors);
              // }
              if (months.isEmpty) {
                snackBarMsg(
                    icon: Icons.warning,
                    title: "Month",
                    msg: "Please select month",
                    bgColor: primaryColor,
                    colors: Colors.white);
              } else {
                if (controller.selectedYear.value == "Choose Year") {
                  snackBarMsg(
                      icon: Icons.warning,
                      title: "Year",
                      msg: "Choose Year",
                      bgColor: primaryColor,
                      colors: Colors.white);
                } else {
                  if (months.isEmpty && categories.isEmpty) {
                    categories.addAll(controller.allCat);
                    months.addAll(controller.monthList);
                    Get.to(
                      () => FilterResultPage(),
                      arguments: {
                        "months": months,
                        "year": controller.selectedYear.value != 'Choose Year'
                            ? [controller.selectedYear.value]
                            : controller.yearList,
                        "categories": categories,
                        "author_name":
                            controller.selectedAuthor.value != 'All Authors'
                                ? [controller.selectedAuthor.value]
                                : controller.authorList
                      },
                    );
                  }
                  if (months.isNotEmpty) {
                    if (categories.isNotEmpty) {
                      Get.to(
                        () => FilterResultPage(),
                        arguments: {
                          "months": months,
                          "year": controller.selectedYear.value != 'Choose Year'
                              ? [controller.selectedYear.value]
                              : controller.yearList,
                          "categories": categories,
                          "author_name":
                              controller.selectedAuthor.value != 'All Authors'
                                  ? [controller.selectedAuthor.value]
                                  : controller.authorList
                        },
                      );
                    } else {
                      categories.addAll(controller.allCat);
                      Get.to(
                        () => FilterResultPage(),
                        arguments: {
                          "months": months,
                          "year": controller.selectedYear.value != 'Choose Year'
                              ? [controller.selectedYear.value]
                              : controller.yearList,
                          "categories": categories,
                          "author_name":
                              controller.selectedAuthor.value != 'All Authors'
                                  ? [controller.selectedAuthor.value]
                                  : controller.authorList
                        },
                      );
                    }
                  } else {
                    snackBarMsg(
                        icon: Icons.warning,
                        title: "Month is Empty",
                        msg: "Please Select Months",
                        bgColor: primaryColor,
                        colors: Colors.white);
                    // months.addAll(controller.monthList);
                    // Get.to(
                    //   () => FilterResultPage(),
                    //   arguments: {
                    //     "months": months,
                    //     "year": controller.selectedYear.value != 'Choose Year'
                    //         ? [controller.selectedYear.value]
                    //         : controller.yearList,
                    //     "categories": categories,
                    //     "author_name":
                    //         controller.selectedAuthor.value != 'All Authors'
                    //             ? [controller.selectedAuthor.value]
                    //             : controller.authorList
                    //   },
                    // );
                  }
                }
              }
            },
            name: "Apply",
            size: Size(width / 1.2, height / 21.1),
            border: false,
            gradient: gradientOpp,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
/* import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Screens/dashboard/dashboard.dart';
import 'package:iskcon/Screens/dashboard/filter_result_page.dart';
import 'package:iskcon/Screens/dashboard/tagSearch_page.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/widgets/gradientButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/filter_controller.dart';

class FilterPage extends StatelessWidget {
  FilterPage({Key? key}) : super(key: key);
  final filterController = Get.put(FilterController());
  List<String> months = [];
  List<String> categories = [];
  // String author = '';
  // var year = "2009";
  SizedBox yearPicker(BuildContext context, height, width) {
    return SizedBox(
      width: width / 1.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          primary: primaryColor,
        ),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                filterController.selectedYear.value,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontFamily: "AnekTamil",
                ),
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        onPressed: () => showMaterialScrollPicker<String>(
          context: context,
          title: ' Select Year',
          showDivider: false,
          headerColor: primaryColor,
          items: filterController.yearList,
          selectedItem: filterController.selectedYear.value,
          onChanged: (value) {
            filterController.selectedYear.value = value;
            // year = value;
            filterController.update();
          },
          onCancelled: () => print('Scroll Picker cancelled'),
          onConfirmed: () => print('Scroll Picker confirmed'),
        ),
      ),
    );
  }

  SizedBox authorPicker(BuildContext context, height, width) {
    return SizedBox(
      width: width / 1.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          primary: primaryColor,
        ),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                filterController.selectedAuthor.value,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontFamily: "AnekTamil",
                ),
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        onPressed: () => showMaterialRadioPicker<String>(
          context: context,
          title: 'Select Author',
          headerColor: primaryColor,
          items: filterController.authorList,
          selectedItem: filterController.selectedAuthor.value,
          onChanged: (value) {
            filterController.selectedAuthor.value = value;
            // author = value;
            filterController.update();
          },
          onCancelled: () => print('Scroll Picker cancelled'),
          onConfirmed: () => print('Scroll Picker confirmed'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    filterController.selectedAuthor.value = 'All Authors';
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // print("============${controller.catList.length}");
    final double itemHeight = (height - kToolbarHeight - height / 1.35) / 2;
    final double itemWidth = width;
    final double catHeight = (height - kToolbarHeight - height / 1.65) / 6;
    final double catWidth = width;
    return GetBuilder<FilterController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.offAll(DashBoard());
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Filter",
            style: TextStyle(
                fontFamily: "AnekTamil",
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            months.isNotEmpty || categories.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: TextButton(
                      onPressed: () {
                        controller.clearAll();
                        months.clear();
                        controller.selectedYear.value = 'Choose Year';
                        controller.selectedAuthor.value = 'All Authors';
                        // year = controller.selectedYear.value
                        // .toString()
                        // .substring(0, 4);
                        categories.clear();
                        controller.selectAll.value = false;
                        controller.update();
                      },
                      child: AutoSizeText(
                        "Clear All",
                        style: TextStyle(
                            fontFamily: "AnekTamil", color: Colors.white),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: TextButton(
                        onPressed: () {
                          controller.selectAll.value = true;
                          for (int i = 0;
                              i < controller.isMonthChecked.length;
                              i++) {
                            controller.isMonthChecked[i] = true;
                          }

                          for (int j = 0;
                              j < controller.isCatChecked.length;
                              j++) {
                            controller.isCatChecked[j] = true;
                          }

                          // for (int k = 0;
                          //     k < controller.isAuthorsChecked.length;
                          //     k++) {
                          //   controller.isAuthorsChecked[k] = true;
                          // }
                          months.addAll(controller.monthList);
                          categories.addAll(controller.allCat);
                          // controller.selectedYear.value != 'Choose Year'
                          //     ? controller.selectedYear.value = 'Choose Year'
                          //     : controller.selectedYear.value;
                          controller.selectedYear.value = "Choose Year";
                          controller.selectedAuthor.value = 'All Authors';
                          //     ? controller.selectedAuthor.value =
                          //         'All Authors'
                          //     :
                          //      controller.selectedAuthor.value;
                          // year = DateTime.now().toString().substring(0, 4);
                          controller.update();
                        },
                        child: AutoSizeText(
                          "Select All",
                          style: TextStyle(
                              fontFamily: "AnekTamil", color: Colors.white),
                        )),
                  ),
          ],
          elevation: 0,
          backgroundColor: primaryColor,
        ),
        body: controller.isLoading.value &&
                (controller.catList.isEmpty || controller.monthList.isEmpty)
            ? const Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                strokeWidth: 1.5,
              ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 84.4,
                    ),
                    InkWell(
                      onTap: () async {
                        Get.to(() => TagSearch());
                      },
                      child: Container(
                        height: height / 21.1,
                        width: width / 1.05,
                        decoration: BoxDecoration(
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: TextField(
                          enabled: false,
                          autofocus: false,
                          onTap: () async {
                            Get.to(() => TagSearch());
                          },
                          decoration: new InputDecoration(
                            labelText: '   Search by Tag',
                            labelStyle: TextStyle(
                                fontSize: 12.r,
                                leadingDistribution:
                                    TextLeadingDistribution.proportional),
                            prefixText: ' ',
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.search,
                                color: primaryColor,
                                size: 18.r,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 42.2,
                    ),
                    Text(
                      "OR",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: height / 168.8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            "Author",
                            minFontSize: 18,
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    authorPicker(context, height, width),
                    SizedBox(
                      height: height / 84.4,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            "Months",
                            minFontSize: 18,
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      child: GridView.count(
                        childAspectRatio: (itemWidth / itemHeight),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: [
                          for (int i = 0; i < controller.monthList.length; i++)
                            ListTile(
                              title: AutoSizeText(
                                controller.monthList[i],
                                style: TextStyle(
                                    fontFamily: "AnekTamil",
                                    fontWeight: FontWeight.bold),
                              ),
                              leading: Checkbox(
                                  activeColor: Color(0xFFF83600),
                                  onChanged: (checked) {
                                    controller.isMonthChecked[i] = checked!;
                                    controller.update();
                                    if (controller.isMonthChecked[i] == false) {
                                      months.removeWhere(((element) =>
                                          element == controller.monthList[i]));
                                    } else
                                      months.add(
                                          controller.monthList[i].toString());
                                  },
                                  value: controller.isMonthChecked[i]),
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 40.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            "Year",
                            minFontSize: 18,
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    // Container(
                    //   height: 200,
                    //   width: 400,
                    //   child: CupertinoPicker(
                    //     selectionOverlay:
                    //         CupertinoPickerDefaultSelectionOverlay(
                    //       capEndEdge: false,
                    //       capStartEdge: false,
                    //       background: Color.fromARGB(30, 152, 128, 76),
                    //     ),
                    //     useMagnifier: true,
                    //     magnification: 2.0,
                    //     backgroundColor: Color.fromARGB(0, 185, 133, 65),
                    //     children: <Widget>[
                    //       for (int i = 0; i < controller.yearList.length; i++)
                    //         Text(
                    //           controller.yearList[i],
                    //           style:
                    //               TextStyle(color: primaryColor, fontSize: 16),
                    //         ),
                    //     ],
                    //     itemExtent: 28, //height of each item
                    //     looping: true,
                    //     onSelectedItemChanged: (int index) {
                    //       year = controller.yearList[index];
                    //     },
                    //   ),
                    // ),
                    yearPicker(context, height, width),

                    SizedBox(
                      height: height / 40.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            "Categories",
                            minFontSize: 18,
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      child: GridView.count(
                        childAspectRatio: (catWidth / catHeight),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 1,
                        children: [
                          for (int i = 0; i < controller.catList.length; i++)
                            ListTile(
                              title: Container(
                                child: Text(
                                  controller.catList[i].title!,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontFamily: "AnekTamil",
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              leading: Checkbox(
                                  activeColor: Color(0xFFF83600),
                                  onChanged: (checked) {
                                    controller.isCatChecked[i] = checked!;
                                    controller.update();
                                    if (controller.isCatChecked[i] == false) {
                                      categories.removeWhere(((element) =>
                                          element ==
                                          controller.catList[i].id.toString()));
                                    } else
                                      categories.add(
                                          controller.catList[i].id.toString());
                                  },
                                  value: controller.isCatChecked[i]),
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 10.1,
                    )
                  ],
                ),
              ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: GradientButton(
            onPress: () {
              // if (months.isEmpty || categories.isEmpty) {
              //   months.addAll(controller.monthList);
              //   categories.addAll(controller.allCat);
              //   print("====================$months");
              //   print("====================$categories");
              //   print("====================$author");
              //   Get.to(
              //     () => FilterResultPage(),
              //     arguments: {
              //       "months": months,
              //       "year": controller.selectedYear.value,
              //       "categories": categories,
              //       "author_name": [author]
              //     },
              //   );
              // }
              // if (author == "") author = controller.allAuthors[0];
              print(controller.selectedYear.value);
              print(controller.selectedAuthor.value);
              print("====================$months");
              print("====================$categories");
              print("====================${controller.yearList}");
              print("====================${controller.authorList}");
              // print("====================$author");
              // if (controller.selectedYear.value != "Choose Year") {
              //   if (controller.selectedAuthor.value != "All Authors") {
              //     if (months.isEmpty) {
              //       months.addAll(controller.monthList);
              //       if (categories.isEmpty) {
              //         categories.addAll(controller.allCat);
              //         // if (author != '') {
              //         Get.off(
              //           () => FilterResultPage(),
              //           arguments: {
              //             "months": months,
              //             "year": controller.selectedYear.value,
              //             "categories": categories,
              //             "author_name": [controller.selectedAuthor.value]
              //           },
              //         );
              //         // } else {
              //         //   snackBarMsg(
              //         //       icon: Icons.warning,
              //         //       title: "Author",
              //         //       msg: "select Author / Authors",
              //         //       bgColor: primaryColor,
              //         //       colors: Colors.white);
              //         // }
              //       }
              //       //  else {
              //       //   snackBarMsg(
              //       //       icon: Icons.warning,
              //       //       title: "Category",
              //       //       msg: "select category / categories",
              //       //       bgColor: primaryColor,
              //       //       colors: Colors.white);
              //       // }
              //     }
              //     //  else {
              //     //   snackBarMsg(
              //     //       icon: Icons.warning,
              //     //       title: "Month",
              //     //       msg: "select Month / Months",
              //     //       bgColor: primaryColor,
              //     //       colors: Colors.white);
              //     // }
              //   } else {
              //     snackBarMsg(
              //         icon: Icons.warning,
              //         title: "Author",
              //         msg: "All Authors",
              //         bgColor: primaryColor,
              //         colors: Colors.white);
              //   }
              // } else {
              //   snackBarMsg(
              //       icon: Icons.warning,
              //       title: "Year",
              //       msg: "Choose Year",
              //       bgColor: primaryColor,
              //       colors: Colors.white);
              // }

              // if(controller.selectAll.value == true && controller.selectedYear.value == "Choose Year" && controller.selectedAuthor.value == "All Authors"){

              // }
              // if (controller.selectedYear.value == "Choose Year") {
              //   years.addAll(controller.yearList);
              // }
              //  if (controller.selectedAuthor.value == "Choose Year") {
              //   authors.addAll(controller.allAuthors);
              // }

              if (months.isEmpty && categories.isEmpty) {
                categories.addAll(controller.allCat);
                months.addAll(controller.monthList);
                Get.to(
                  () => FilterResultPage(),
                  arguments: {
                    "months": months,
                    "year": controller.selectedYear.value != 'Choose Year'
                        ? [controller.selectedYear.value]
                        : controller.yearList,
                    "categories": categories,
                    "author_name":
                        controller.selectedAuthor.value != 'All Authors'
                            ? [controller.selectedAuthor.value]
                            : controller.authorList
                  },
                );
              }
              if (months.isNotEmpty) {
                if (categories.isNotEmpty) {
                  Get.to(
                    () => FilterResultPage(),
                    arguments: {
                      "months": months,
                      "year": controller.selectedYear.value != 'Choose Year'
                          ? [controller.selectedYear.value]
                          : controller.yearList,
                      "categories": categories,
                      "author_name":
                          controller.selectedAuthor.value != 'All Authors'
                              ? [controller.selectedAuthor.value]
                              : controller.authorList
                    },
                  );
                } else {
                  categories.addAll(controller.allCat);
                  Get.to(
                    () => FilterResultPage(),
                    arguments: {
                      "months": months,
                      "year": controller.selectedYear.value != 'Choose Year'
                          ? [controller.selectedYear.value]
                          : controller.yearList,
                      "categories": categories,
                      "author_name":
                          controller.selectedAuthor.value != 'All Authors'
                              ? [controller.selectedAuthor.value]
                              : controller.authorList
                    },
                  );
                }
              } else {
                months.addAll(controller.monthList);
                Get.to(
                  () => FilterResultPage(),
                  arguments: {
                    "months": months,
                    "year": controller.selectedYear.value != 'Choose Year'
                        ? [controller.selectedYear.value]
                        : controller.yearList,
                    "categories": categories,
                    "author_name":
                        controller.selectedAuthor.value != 'All Authors'
                            ? [controller.selectedAuthor.value]
                            : controller.authorList
                  },
                );
              }
            },
            name: "Apply",
            size: Size(width / 1.2, height / 21.1),
            border: false,
            gradient: gradientOpp,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    });
  }
}
*/