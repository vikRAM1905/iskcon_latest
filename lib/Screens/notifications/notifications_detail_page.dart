// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Utils/custColors.dart';
import '../../controller/notification_controller.dart';

class NotificationsDetailPage extends StatelessWidget {
  NotificationsDetailPage({Key? key}) : super(key: key);
  var notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Detail"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryColor,
      ),
      body: Obx(
        () => notificationController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                strokeWidth: 1.5,
              ))
            : Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              notificationController
                                  .readNotificationData!.createdAt
                                  .toString(),
                              style: TextStyle(
                                  fontFamily: "AnekTamil", color: primaryColor),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              notificationController.readNotificationData!.title
                                  .toString(),
                              style: TextStyle(
                                  fontFamily: "AnekTamil",
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: height / 84.4),
                          Text(
                            notificationController
                                .readNotificationData!.description
                                .toString(),
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
