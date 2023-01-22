// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:iskcon/Screens/profile/about_us_page.dart';
import 'package:iskcon/Screens/subscribe/subscribe_page.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/models/dashboard_model.dart' as dashboard;
import 'package:iskcon/provider/api_provider.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoardController extends GetxController {
  var bannerList = List<dashboard.Banner>.empty(growable: true).obs;
  var categoryList = List<dashboard.Catergory>.empty(growable: true).obs;
  var popularList = List<dashboard.Popular>.empty(growable: true).obs;
  var recommendedList = List<dashboard.Recommend>.empty(growable: true).obs;
  var version = "";
  int selectedIndex = 0;
  var isSubscribed = true.obs;
  var name = "";
  var fcmToken = "";
  String? storeVersion;
  var subscriptionId = "";
  void tabChange(int index) {
    selectedIndex = index;
    update();
  }

  GlobalKey one = GlobalKey();
  GlobalKey two = GlobalKey();
  GlobalKey three = GlobalKey();
  GlobalKey four = GlobalKey();
  GlobalKey five = GlobalKey();

  bool showCaseOne = false;
  bool showCaseTwo = false;
  bool showCaseThree = false;
  bool showCaseFour = false;
  bool showCaseFive = false;

  var isLoading = false.obs;
  var packageId;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    fcmToken = (await FirebaseMessaging.instance.getToken())!;
    packageId = Get.arguments;
    await dashBoardApiData();
    checkVersion();
    if (isSubscribed.value == false)
      Get.defaultDialog(
          contentPadding: EdgeInsets.all(10),
          // onWillPop: () {
          //   return Future.delayed(Duration.zero).then((value) => exit(0));
          // },
          // barrierDismissible: false,
          title: "Subscription Ended",
          content: Text("Your subscription was ended. Please contact us!..."),
          actions: [
            TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  Get.to(() => AboutUsPage());
                },
                child: Text(
                  "Contact Us",
                  style: TextStyle(color: Colors.white),
                )),
            // TextButton(
            //     style: ButtonStyle(
            //       backgroundColor:
            //           MaterialStateProperty.all<Color>(primaryColor),
            //     ),
            //     onPressed: () {
            //       Get.to(() => SubscribePage());
            //     },
            //     child: Text(
            //       "Subscribe",
            //       style: TextStyle(color: Colors.white),
            //     )),
          ]);
    print("Start");
    print("End");
    super.onInit();
  }

  Future<void> dashBoardApiData() async {
    isLoading.value = true;
    bannerList.clear();
    popularList.clear();
    categoryList.clear();
    recommendedList.clear();
    await APIProvider().dashBoardAPI(
      token: fcmToken,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          isSubscribed.value = data.subscription!;
          storeVersion = data.result!.appVersion;
          name = data.result!.name!;
          subscriptionId = data.result!.subscriptionId!;
          data.result!.catergory!.forEach((cat) {
            categoryList.add(cat);
          });
          data.result!.banner!.forEach((ban) {
            bannerList.add(ban);
          });
          data.result!.popular!.forEach((pop) {
            popularList.add(pop);
          });
          data.result!.recommend!.forEach((rec) {
            recommendedList.add(rec);
          });
        }
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : $error');
        isLoading.value = false;
      },
    );
    update();
  }

  Future<void> checkVersion() async {
    dynamic buildNumber;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    print("///////////////////////-----$buildNumber");
    print("///////////////////////-----$storeVersion");

    Future.delayed(Duration.zero, () async {
      if (int.parse(storeVersion!) > int.parse(buildNumber)) {
        // Get.defaultDialog(title: "Hi", content: Container());
        // InAppUpdate.checkForUpdate().then((info) {
        //   info.updateAvailability == UpdateAvailability.updateAvailable
        //       ? InAppUpdate.performImmediateUpdate()
        //           .catchError((e) => print(e.toString()))
        //       : print(info.packageName);
        // });
        // _launchURL(String url) async {
        if (Platform.isAndroid) {
          // @override
          // final appcastURL =
          //     'https://github.com/testwaretwics/upgrader_test/blob/main/test.xml';
          // final cfg =
          //     AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
          // UpgradeAlert(
          //   upgrader: Upgrader(appcastConfig: cfg),
          //   child: Center(child: Text('Checking...')),
          // );

          Get.defaultDialog(
              title: "Update Available",
              content: Text("New update for your app is available!..."),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Ignore")),
                TextButton(
                    onPressed: () async {
                      if (await canLaunchUrl(Uri.parse(
                          "https://play.google.com/store/apps/details?id=com.iskconapp.iskcon"))) {
                        await launchUrl(
                            Uri.parse(
                                "https://play.google.com/store/apps/details?id=com.iskconapp.iskcon"),
                            mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Could not launch "https://play.google.com/store/apps/details?id=com.iskconapp.iskcon"';
                      }
                    },
                    child: Text("Update Now"))
              ]);
        } else if (Platform.isIOS) {
          Get.defaultDialog(
              title: "Update Available",
              content: Text("New update for your app is available!..."),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Ignore")),
                TextButton(
                    onPressed: () async {
                      if (await canLaunchUrl(Uri.parse(
                          "https://apps.apple.com/in/app/ola-the-top-ride-hailing-app/id539179365"))) {
                        await launchUrl(
                            Uri.parse(
                                "https://apps.apple.com/in/app/ola-the-top-ride-hailing-app/id539179365"),
                            mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Could not launch "https://apps.apple.com/in/app/ola-the-top-ride-hailing-app/id539179365"';
                      }
                    },
                    child: Text("Update Now"))
              ]);
        }
        // }

        // NativeUpdater.displayUpdateAlert(
        //   context,
        //   forceUpdate: true,
        //   appStoreUrl: 'https://play.google.com/store/apps/details?id=com.dwarikeshapp.dwarikesh',
        //   // playStoreUrl:
        //   //     'https://play.google.com/store/apps/details?id=com.dwarikeshapp.dwarikesh',
        //   iOSDescription: '<Your description>',
        //   iOSUpdateButtonLabel: 'Upgrade',
        //   iOSIgnoreButtonLabel: 'Next Time',
        // );
      } else {
        print("update not available!");
      }
    });
  }
}
