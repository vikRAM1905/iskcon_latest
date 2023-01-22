// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Utils/contants.dart';
import '../../Utils/custColors.dart';
import '../../controller/notification_controller.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({Key? key}) : super(key: key);
  var notificationController = Get.put(NotificationController());

  clearAllNotificationDialog(height, width) {
    Get.defaultDialog(
      titlePadding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20),
      title: "Are you sure ?",
      content: Text("You want to clear all notification."),
      actions: [
        Container(
          height: height / 21.1,
          width: width / 3.250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Color(0xff296ACC),
            ),
          ),
          child: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "Cancel",
              style: TextStyle(fontFamily: "AnekTamil", color: secondaryColor),
            ),
          ),
        ),
        Container(
          height: height / 21.1,
          width: width / 3.250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: primaryColor,
            ),
          ),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
            ),
            onPressed: () {
              notificationController.getNotificationClearApiData();
              Get.back();
            },
            child: Text(
              "Clear",
              style: TextStyle(fontFamily: "AnekTamil", color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryColor,
        actions: [
          TextButton(
            onPressed: () {
              clearAllNotificationDialog(height, width);
            },
            child: Text(
              "Clear All",
              style: TextStyle(
                  fontFamily: "AnekTamil",
                  decoration: TextDecoration.underline,
                  color: Colors.white),
            ),
          ),
        ],
      ),
      body: Obx(
        () => notificationController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                strokeWidth: 1.5,
              ))
            : notificationController.notificationDataList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/no_data.png',
                            height: height / 5.53, width: width / 5.62),
                        SizedBox(height: height / 56.20),
                        Text(
                          'No Notification For You',
                          style: TextStyle(
                              fontFamily: "AnekTamil",
                              fontSize: 18.r,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: height / 56.20),
                        Text(
                          'We will notify you once you get any \nmessages.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "AnekTamil",
                              fontSize: 14.r,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount:
                          notificationController.notificationDataList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 8,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(ROUTE_NOTIFICATION_READ);
                                  notificationController
                                      .getNotificationReadApiData(
                                          notificationController
                                              .notificationDataList[index].id);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: height / 168.8),
                                      Text(
                                        notificationController
                                            .notificationDataList[index].title
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: height / 84.4),
                                      Text(
                                        notificationController
                                            .notificationDataList[index]
                                            .description
                                            .toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: height / 84.4),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          notificationController
                                              .notificationDataList[index]
                                              .createdAt
                                              .toString(),
                                          style: TextStyle(
                                              fontFamily: "AnekTamil",
                                              color: primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              notificationController
                                          .notificationDataList[index].status ==
                                      0
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 60, right: 10),
                                      child: CircleAvatar(
                                        backgroundColor: primaryColor,
                                        radius: 10.r,
                                        child: Text("1",
                                            style: TextStyle(
                                                fontFamily: "AnekTamil",
                                                color: Colors.white,
                                                fontSize: 12.r)),
                                      ),
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
