import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Screens/dashboard/dashboard.dart';
import 'package:iskcon/Screens/dashboard/homePage.dart';
import 'package:iskcon/Screens/subscribe/subscribe_success_page.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/controller/profile_controller.dart';
import 'package:iskcon/widgets/gradientButton.dart';
import 'package:iskcon/widgets/snackBar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../Utils/screen_overlay.dart';
import '../../controller/subscribe_controller.dart';

class SubscribePage extends StatefulWidget {
  SubscribePage({Key? key}) : super(key: key);

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  final subscribeController = Get.put(SubscribeController());
  final profileController = Get.put(ProfileController());
  Razorpay? _razorpay;
  var selectedIndex = 0;
  var orderId = "";
  // bool _focus = false;
  var amount = "";
  var key = "";

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay!.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(
      PaymentSuccessResponse paymentSuccessResponse) async {
    print(
        "..........*****************................${paymentSuccessResponse.orderId}");
    print(
        "..........*****************................${paymentSuccessResponse.paymentId}");
    print(
        "..........*****************................${paymentSuccessResponse.signature}");
    await subscribeController
        .paymentVerifyApi(
            paymentSuccessResponse.paymentId,
            paymentSuccessResponse.orderId,
            paymentSuccessResponse.signature,
            subscribeController.cardList[selectedIndex].plan,
            subscribeController.cardList[selectedIndex].year)
        .then((value) => {
              Get.defaultDialog(
                  contentPadding: EdgeInsets.all(10),
                  // onWillPop: () {
                  //   return Future.delayed(Duration.zero)
                  //       .then((value) => exit(0));
                  // },
                  barrierDismissible: false,
                  title: "Subscription Renewed",
                  content: Text(
                      "Your subscription Renewal was successfull. Now Enjoy your Subscription and Access our all Magazines!..."),
                  actions: [
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                        ),
                        onPressed: () {
                          Get.offAll(() => DashBoard());
                        },
                        child: Text(
                          "Okay",
                          style: TextStyle(color: Colors.white),
                        )),
                  ]),
            });
    snackBarMsg(
        icon: Icons.done,
        title: "Success",
        msg: "Payment Processed Successfully",
        bgColor: primaryColor,
        colors: Colors.white);
  }

  void _handlePaymentError(PaymentFailureResponse paymentFailureResponse) {
    snackBarMsg(
        icon: Icons.dangerous,
        title: "Failed!",
        msg: "Payment failed... Please Try again",
        bgColor: primaryColor,
        colors: Colors.white);
  }

  void _handleExternalWallet(ExternalWalletResponse externalWalletResponse) {
    snackBarMsg(
        icon: Icons.dangerous,
        title: "Oops!",
        msg: "Something went wrong... Please Try again",
        bgColor: primaryColor,
        colors: Colors.white);
  }

  void openCheckout() async {
    var order = await subscribeController
        .createOrderApi(subscribeController.cardList[selectedIndex].amount)
        .catchError((onError) {
      Get.back();
      snackBarMsg(
          icon: Icons.dangerous,
          title: "Failed!",
          msg: "Payment failed... Please Try again",
          bgColor: primaryColor,
          colors: Colors.white);
    });
    orderId = order['order_id'];
    amount = order['amount'].toString();
    key = order['key'];
    print("...........${order['order_id']}");
    Get.back();

    var options = {
      'key': "rzp_live_4gFXlhgVtAYqqM",
      //'key': 'rzp_test_NNbwJ9tmM0fbxj',
      'amount': amount,
      'name': 'Iskcon',
      'description': 'Donation for bagavat dharisanam',
      'prefill': {
        'contact': profileController.mobileNum,
        'email': profileController.mail
      },
      // 'external': {
      //   'wallets': ['Paytm']
      // },
      'theme': {'color': '#ffbf00'},
      'order_id': orderId
    };
    try {
      _razorpay!.open(options);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - height / 4) / 3;
    final double itemWidth = size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFFFFAF4),
        appBar: AppBar(
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
            "Subscribe",
            style: TextStyle(
                fontFamily: "AnekTamil",
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: primaryColor,
        ),
        body: GetBuilder<SubscribeController>(builder: (controller) {
          return controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  strokeWidth: 1.5,
                ))
              : Container(
                  color: primaryColor,
                  child: Container(
                      padding: EdgeInsets.all(10),
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
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: height / 42.2,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Subscribe to access More Magazines",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Html(
                              data: controller.content,
                              style: {
                                'p': Style(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Krishna-Regular",
                                    fontSize: FontSize(16)),
                                'h1': Style(
                                    fontWeight: FontWeight.w100,
                                    fontFamily: "Brahmanya",
                                    fontSize: FontSize(22)),
                                'h2': Style(
                                    fontWeight: FontWeight.w100,
                                    fontFamily: "Brahmanya",
                                    fontSize: FontSize(21)),
                                'h3': Style(
                                    fontWeight: FontWeight.w100,
                                    fontFamily: "Brahmanya",
                                    fontSize: FontSize(20)),
                                'h4': Style(
                                    fontWeight: FontWeight.w100,
                                    fontFamily: "Brahmanya",
                                    fontSize: FontSize(19)),
                                'h5': Style(
                                    fontWeight: FontWeight.w100,
                                    fontFamily: "Brahmanya",
                                    fontSize: FontSize(18)),
                                'h6': Style(
                                    fontWeight: FontWeight.w100,
                                    fontFamily: "Brahmanya",
                                    fontSize: FontSize(17)),
                                "img": Style(
                                  fontFamily: "Brahmanya",
                                )
                              },
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Plans For You",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: height / 21.1,
                            ),
                            CarouselSlider.builder(
                              // carouselController: carouselController,
                              options: CarouselOptions(
                                  height: height / 3.10,
                                  scrollDirection: Axis.horizontal,
                                  enableInfiniteScroll: false,
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.5,
                                  initialPage: 0,
                                  autoPlay: false,
                                  autoPlayCurve: Curves.ease,
                                  onPageChanged: (index, page) {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  autoPlayAnimationDuration:
                                      const Duration(seconds: 1)),
                              itemCount: controller.cardList.length,
                              itemBuilder: (context, index, realIdx) {
                                return _cardWidget(index, height, width);
                              },
                            ),
                            Center(
                                child: Icon(
                              Icons.navigation_sharp,
                              color: primaryColor,
                            )),
                            SizedBox(
                              height: height / 21.1,
                            ),
                            GradientButton(
                              onPress: () async {
                                // setState(() {
                                //   controller.enteredAmount.value =
                                //       controller.amountController.text;
                                // });
                                // if (controller.amountController.text == "" ||
                                //     controller.amountController.text.isEmpty) {
                                //   Get.snackbar('Enter Amount',
                                //       'Please enter amount to process',
                                //       backgroundColor: primaryColor,
                                //       colorText: Colors.white,
                                //       snackPosition: SnackPosition.BOTTOM);
                                // } else {
                                var result =
                                    await (Connectivity().checkConnectivity());
                                if (result == ConnectivityResult.wifi ||
                                    result == ConnectivityResult.mobile) {
                                  showDialog(
                                      builder: (BuildContext context) {
                                        return loadingOverlay();
                                      },
                                      context: context);
                                  openCheckout();
                                } else {
                                  Get.snackbar(
                                      'Internet', 'No Internet Connection',
                                      backgroundColor: primaryColor,
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                                // }
                              },
                              name: "Proceed",
                              size: Size(width / 1.2, height / 21.1),
                              border: false,
                              gradient: gradientOpp,
                            ),
                            SizedBox(
                              height: height / 28.1,
                            )
                          ],
                        ),
                      )),
                );
        }));
  }

  Widget _cardWidget(int index, height, width) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 8,
        // shadowColor: selectedIndex == index ? primaryColor : Colors.grey,
        color: selectedIndex == index
            ? Colors.white
            : Colors.white.withOpacity(0.8),
        child: Container(
          height: height / 6.44,
          width: width / 2.0,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 5,
                  color: selectedIndex == index
                      ? primaryColor
                      : primaryColor.withOpacity(0.8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                width: double.infinity,
                color: selectedIndex == index
                    ? primaryColor
                    : primaryColor.withOpacity(0.8),
                child: Text(
                  "Plan Detail",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: height / 84.4,
              ),
              Text(
                subscribeController.cardList[index].year.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Year",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                color: Colors.black12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.currency_rupee, color: Colors.black, size: 30),
                  Text(
                    subscribeController.cardList[index].amount!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              selectedIndex == index
                  ? IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                            contentPadding: EdgeInsets.all(10),
                            // onWillPop: () {
                            //   return Future.delayed(Duration.zero).then((value) => exit(0));
                            // },
                            barrierDismissible: true,
                            title: "Package Info",
                            content: Column(
                              children: [
                                SizedBox(
                                  height: height / 84.4,
                                ),
                                Text(
                                  "Period : ${subscribeController.cardList[index].plan}",
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: height / 84.4,
                                ),
                                Text(
                                  "Amount : Rs.${subscribeController.cardList[index].amount}",
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: height / 84.4,
                                ),
                                Text(
                                  "${subscribeController.cardList[index].description}",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "Close",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ]);
                      },
                      icon: Icon(
                        Icons.info,
                        color: primaryColor,
                        size: 30,
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                height: height / 84.4,
              ),
            ],
          ),
        ));
  }
}
