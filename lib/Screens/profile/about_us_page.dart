import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/aboutUs_controller.dart';
import '../../controller/dashboard_controller.dart';

class AboutUsPage extends StatelessWidget {
  AboutUsPage({Key? key}) : super(key: key);
  final aboutUscontroller = Get.put(AboutUsController());
  final dashboardController = Get.put(DashBoardController());

  toLast() {
    aboutUscontroller.scrollController.animateTo(
        aboutUscontroller.scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) => toLast());
    ScreenUtil.init(context);
    print(aboutUscontroller.contactList.length);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xFFFFFAF4),
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: primaryColor,
          title: Text("About Us",
              style: TextStyle(
                  fontFamily: "AnekTamil",
                  color: Colors
                      .white)), //Get.isDarkMode ? Colors.white : Colors.black)),
          elevation: 0,
        ),
        body: GetBuilder<AboutUsController>(
          builder: (controller) => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  strokeWidth: 1.5,
                ))
              : Container(
                  color: primaryColor,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color:
                          Get.isDarkMode ? Colors.grey[600] : Color(0xFFFFFAF4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                          controller: controller.scrollController,
                          children: [
                            SizedBox(
                              height: height / 22.98,
                              width: double.infinity,
                            ),
                            Container(
                              child: Image.network(
                                  controller.resultList[0].image!),
                            ),
                            SizedBox(
                              height: height / 42.2,
                            ),
                            Html(
                              data: controller.resultList[0].about,
                            ),
                            SizedBox(
                              height: height / 22.8,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Contact Us",
                                  style: TextStyle(
                                      fontFamily: "AnekTamil",
                                      fontSize: 16.r,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: height / 42.2,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.mail),
                                  SizedBox(
                                    width: width / 42.2,
                                  ),
                                  AutoSizeText(
                                      controller.contactList[0].email!.email!,
                                      style: TextStyle(
                                        fontFamily: "AnekTamil",
                                      )),
                                  SizedBox(
                                    width: width / 21.1,
                                  ),
                                  AutoSizeText(
                                      controller
                                          .contactList[0].email!.emailName!,
                                      style: TextStyle(
                                        fontFamily: "AnekTamil",
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height / 42.2,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.phone),
                                  SizedBox(
                                    width: width / 42.2,
                                  ),
                                  AutoSizeText(
                                      controller.contactList[0].landline!
                                          .landlineName!,
                                      style: TextStyle(
                                        fontFamily: "AnekTamil",
                                      )),
                                  SizedBox(
                                    width: width / 21.1,
                                  ),
                                  AutoSizeText(
                                      controller.contactList[0].landline!
                                          .landlineNumber!,
                                      style: TextStyle(
                                        fontFamily: "AnekTamil",
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height / 42.2,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.phone_android_outlined),
                                  SizedBox(
                                    width: width / 42.2,
                                  ),
                                  AutoSizeText(
                                      controller.contactList[0].mobile!.mobile!,
                                      style: TextStyle(
                                        fontFamily: "AnekTamil",
                                      )),
                                  SizedBox(
                                    width: width / 21.1,
                                  ),
                                  AutoSizeText(
                                      controller
                                          .contactList[0].mobile!.mobileNumber!,
                                      style: TextStyle(
                                        fontFamily: "AnekTamil",
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height / 42.2,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.whatsapp),
                                  SizedBox(
                                    width: width / 42.2,
                                  ),
                                  AutoSizeText(
                                      controller
                                          .contactList[0].whatsApp!.whatsApp!,
                                      style: TextStyle(
                                        fontFamily: "AnekTamil",
                                      )),
                                  SizedBox(
                                    width: width / 21.1,
                                  ),
                                  AutoSizeText(
                                      controller.contactList[0].whatsApp!
                                          .whatsAppName!,
                                      style: TextStyle(
                                        fontFamily: "AnekTamil",
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height / 42.2,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.contact_phone),
                                  SizedBox(
                                    width: width / 42.2,
                                  ),
                                  AutoSizeText(
                                      controller.contactList[0].customerSupport!
                                          .customerSupport!,
                                      style: TextStyle(
                                        fontFamily: "AnekTamil",
                                      )),
                                  SizedBox(
                                    width: width / 21.1,
                                  ),
                                  AutoSizeText(
                                      controller.contactList[0].customerSupport!
                                          .customerSupportNumber!,
                                      style: TextStyle(
                                        fontFamily: "AnekTamil",
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height / 21.1,
                            ),
                            Text(
                              "version  " + dashboardController.version,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              height: height / 21.1,
                            ),
                          ]),
                    ),
                  ),
                ),
        ));
  }
}
