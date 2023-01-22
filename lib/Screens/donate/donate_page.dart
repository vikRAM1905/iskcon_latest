import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import '../../controller/donate_controller.dart';
import 'donate_succes_page.dart';

class DonatePage extends StatefulWidget {
  DonatePage({Key? key}) : super(key: key);

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final donateController = Get.put(DonateController());
  final profileController = Get.put(ProfileController());
  Razorpay? _razorpay;
  var selectedIndex;
  var orderId = "";
  bool _focus = false;
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
    await donateController
        .paymentVerifyApi(paymentSuccessResponse.paymentId,
            paymentSuccessResponse.orderId, paymentSuccessResponse.signature)
        .then((value) => Get.offAll(() => DonateSuccessPage()));
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
    var d = await donateController
        .createOrderApi(donateController.enteredAmount.value)
        .catchError((onError) {
      Get.back();
      snackBarMsg(
          icon: Icons.dangerous,
          title: "Failed!",
          msg: "Payment failed... Please Try again",
          bgColor: primaryColor,
          colors: Colors.white);
    });
    orderId = d['order_id'];
    amount = d['amount'].toString();
    key = d['key'];
    print("...........${d['order_id']}");
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
    final double itemHeight = (size.height - kToolbarHeight - height / 2) / 3;
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
            "Donate",
            style: TextStyle(
                fontFamily: "AnekTamil",
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: primaryColor,
        ),
        body: GetBuilder<DonateController>(builder: (controller) {
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                elevation: 2,
                                shadowColor: Colors.grey,
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Image.network(
                                      controller.appDetail[0].appIcon!,
                                      height: height / 12.06,
                                      width: width / 5.61,
                                    ),
                                  ),
                                  title: AutoSizeText(
                                      controller.appDetail[0].appTitle!,
                                      minFontSize: 16,
                                      maxFontSize: 18,
                                      style: TextStyle(
                                          fontFamily: "AnekTamil",
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText(
                                    controller.amountContent,
                                    minFontSize: 16,
                                    maxFontSize: 18,
                                    style: TextStyle(
                                        fontFamily: "AnekTamil",
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            GridView.count(
                                childAspectRatio: (itemWidth / itemHeight),
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                children: [
                                  for (int i = 0;
                                      i < controller.amount.length;
                                      i++)
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = i;
                                          i == 0
                                              ? controller.amountController
                                                  .text = controller.amount[0]
                                              : i == 1
                                                  ? controller.amountController
                                                          .text =
                                                      controller.amount[1]
                                                  : i == 2
                                                      ? controller
                                                              .amountController
                                                              .text =
                                                          controller.amount[2]
                                                      : i == 3
                                                          ? controller
                                                              .amountController
                                                              .text = ""
                                                          : controller
                                                              .amountController
                                                              .text = "";
                                          controller.update();
                                        });
                                      },
                                      child: Card(
                                        color: selectedIndex == i
                                            ? primaryColor
                                            : null,
                                        elevation: 3,
                                        child: Center(
                                          child: i != 3
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                        FontAwesomeIcons
                                                            .indianRupeeSign,
                                                        size: 18,
                                                        color:
                                                            selectedIndex == i
                                                                ? Colors.white
                                                                : Colors.black),
                                                    AutoSizeText(
                                                        controller
                                                            .amountsName[i]
                                                            .toString(),
                                                        minFontSize: 18,
                                                        maxFontSize: 20,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "AnekTamil",
                                                          color:
                                                              selectedIndex == i
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                        )),
                                                  ],
                                                )
                                              : AutoSizeText(
                                                  controller.amountsName[i]
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  minFontSize: 18,
                                                  maxFontSize: 20,
                                                  style: TextStyle(
                                                    fontFamily: "AnekTamil",
                                                    color: selectedIndex == i
                                                        ? Colors.white
                                                        : Colors.black,
                                                  )),
                                        ),
                                      ),
                                    )
                                ]),
                            SizedBox(
                              height: height / 42.2,
                            ),
                            Text("OR", style: TextStyle(fontSize: 16)),
                            SizedBox(
                              height: height / 42.2,
                            ),
                            Card(
                                elevation: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(),
                                  child: TextField(
                                    style: TextStyle(fontSize: 20),
                                    onChanged: (val) {
                                      setState(() {});
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: controller.amountController,
                                    cursorColor: primaryColor,
                                    autofocus: _focus,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        FontAwesomeIcons.indianRupeeSign,
                                        color: primaryColor,
                                      ),
                                      hintText: 'Enter Amount',
                                      hintStyle:
                                          TextStyle(color: Color(0xFFB5B5B5)),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: height / 21.1,
                            ),
                            GradientButton(
                              onPress: () async {
                                setState(() {
                                  controller.enteredAmount.value =
                                      controller.amountController.text;
                                });
                                if (controller.amountController.text == "" ||
                                    controller.amountController.text.isEmpty) {
                                  Get.snackbar('Enter Amount',
                                      'Please enter amount to process',
                                      backgroundColor: primaryColor,
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.BOTTOM);
                                } else {
                                  var result = await (Connectivity()
                                      .checkConnectivity());
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
                                }
                              },
                              name: "Apply",
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
}
