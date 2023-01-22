import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Screens/dashboard/dashboard.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/widgets/gradientButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/donate_success_controller.dart';

class DonateSuccessPage extends StatelessWidget {
  DonateSuccessPage({Key? key}) : super(key: key);
  final donateSuccessController = Get.put(DonateSuccessController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          backgroundColor: primaryColor,
        ),
        body: GetBuilder<DonateSuccessController>(builder: (controller) {
          return controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  strokeWidth: 1.5,
                ))
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: height / 4.2,
                            width: width / 1.9,
                            child:
                                Image.asset('assets/images/donate_image.png')),
                        SizedBox(
                          height: height / 28.1,
                        ),
                        AutoSizeText(
                          controller.title,
                          textAlign: TextAlign.center,
                          minFontSize: 18,
                          maxFontSize: 20,
                          style: TextStyle(
                              fontFamily: "AnekTamil",
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height / 42.2,
                        ),
                        AutoSizeText(
                          controller.content,
                          minFontSize: 12,
                          maxFontSize: 14,
                          style: TextStyle(
                            fontFamily: "AnekTamil",
                          ),
                        ),
                        SizedBox(
                          height: height / 42.2,
                        ),
                        GradientButton(
                          onPress: () {
                            Get.offAll(() => DashBoard());
                          },
                          name: "Back To Home",
                          size: Size(width / 1.2, height / 21.1),
                          border: false,
                          gradient: gradientOpp,
                        )
                      ],
                    ),
                  ),
                );
        }));
  }
}
