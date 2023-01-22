import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/widgets/gallery_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../Utils/custColors.dart';
import '../../controller/photoPage_controller.dart';
import '../../widgets/gradientButton.dart';
import '../../widgets/snackBar.dart';
import '../dashboard/dashboard.dart';
import '../donate/donate_page.dart';

class ComicPage extends StatefulWidget {
  ComicPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ComicPage> createState() => _ComicPageState();
}

class _ComicPageState extends State<ComicPage> {
  final photoController = Get.put(PhotoPageController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Obx(
      () => Scaffold(
        backgroundColor: Color(0xFFFFFAF4),
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(photoController.articleDetail.isEmpty
              ? ""
              : photoController.articleDetail[0].title!),
          centerTitle: true,
          elevation: 0,
        ),
        body: GetBuilder<PhotoPageController>(builder: (controller) {
          return controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  strokeWidth: 1.5,
                ))
              : controller.photosList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: height / 4.2,
                            width: width / 1.9,
                            child: Image.asset('assets/images/no_data.png'),
                          ),
                          SizedBox(
                            height: height / 28.1,
                          ),
                          Text("Articles Not found"),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GalleryImage(
                            // key: _key,
                            imageUrls: [
                              for (int i = 0;
                                  i < controller.photosList.length;
                                  i++)
                                controller.photosList[i].picture!
                            ],
                            numOfShowImages: controller.photosList.length,
                            // titleGallery: _title,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Html(
                              data: controller.pagesList.isEmpty
                                  ? ""
                                  : controller.pagesList[0].photoDescription,
                              style: {
                                'p': Style(
                                  fontFamily: "AnekTamil",
                                ),
                                'h1': Style(
                                  fontFamily: "AnekTamil",
                                ),
                                'h2': Style(
                                  fontFamily: "AnekTamil",
                                ),
                                'h3': Style(
                                  fontFamily: "AnekTamil",
                                ),
                                'h4': Style(
                                  fontFamily: "AnekTamil",
                                ),
                                'h5': Style(
                                  fontFamily: "AnekTamil",
                                ),
                                'h6': Style(
                                  fontFamily: "AnekTamil",
                                ),
                              },
                            ),
                          ),
                          Text("* * *"),
                          SizedBox(
                            height: 20,
                          ),
                          GradientButton(
                            onPress: () {
                              controller.articleDetail[0].userRating != '0'
                                  ? Get.back()
                                  : showDialog(
                                      context: context,
                                      builder: (context) {
                                        return RatingDialog(
                                          enableComment: false,
                                          starColor: primaryColor,
                                          initialRating: 1.0,
                                          title: Text(
                                            controller.articleDetail[0].title!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: "AnekTamil",
                                              fontSize: 22.r,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          message: Text(
                                            'Tap a star to set your rating for this Article.', // Add more description here if you want.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 15.r),
                                          ),
                                          image: Image.network(controller
                                              .articleDetail[0].mainPicture!),
                                          submitButtonText: 'Rate',
                                          // commentHint:
                                          //     'Set your custom comment hint',
                                          onCancelled: () =>
                                              Get.offAll(() => DashBoard()),
                                          onSubmitted: (response) {
                                            // print(
                                            //     'rating: ${response.rating}, comment: ${response.comment}');

                                            controller.articleRating(
                                                controller.articleDetail[0].id!,
                                                response.rating.toString());
                                            controller.update();
                                            Get.offAll(() => DashBoard());
                                            snackBarMsg(
                                                title: "Success",
                                                msg:
                                                    "Rating added successfully",
                                                colors: Colors.white,
                                                bgColor: primaryColor);
                                          },
                                        );
                                      });
                            },
                            name: "back",
                            txtColor: Colors.white,
                            size: Size(width / 1.2, height / 20),
                            border: false,
                          ),
                          SizedBox(
                            height: height / 40,
                          ),
                          GradientButton(
                            onPress: () => Get.to(() => DonatePage()),
                            name: "Donate Now",
                            txtColor: Colors.red,
                            size: Size(width / 1.2, height / 20),
                            border: true,
                          )
                        ],
                      ),
                    );
        }),
      ),
    );
  }
}
