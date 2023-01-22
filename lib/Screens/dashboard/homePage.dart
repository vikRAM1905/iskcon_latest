import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Screens/categories/categories_page.dart';
import 'package:iskcon/Screens/reading/book_intro_page.dart';
import 'package:iskcon/Utils/contants.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/Utils/gradient_text.dart';
import 'package:iskcon/controller/dashboard_controller.dart';
import 'package:iskcon/widgets/gradientButton.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iskcon/widgets/snackBar.dart';
import 'package:open_settings/open_settings.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../notifications/notifications_page.dart';
import 'filter_page.dart';
import 'listwise_books_page.dart';
import 'search_field_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dashBoardcontroller = Get.put(DashBoardController());
  // final usercontroller = Get.put(ProfileController());
  TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  int carouselIndex = 0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh() async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await Future.delayed(Duration(milliseconds: 1000));
      await dashBoardcontroller.dashBoardApiData();
      _refreshController.refreshCompleted();
    } else {
      Get.defaultDialog(
          title: "Oops!...",
          content: Text("Check your internet connection"),
          actions: [
            ElevatedButton(
              onPressed: () {
                exit(0);
              },
              child: Text("Exit"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: primaryColor),
              onPressed: () {
                OpenSettings.openWIFISetting();
              },
              child: Text('Open Settings'),
            ),
          ]);
    }
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Obx(() => dashBoardcontroller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(
            backgroundColor: primaryColor,
            strokeWidth: 1.5,
          ))
        : Scaffold(
            backgroundColor: Color(0xFFFFFAF4),
            appBar: PreferredSize(
              preferredSize: Size(width, height / 7),
              child: SafeArea(
                child: Container(
                  color: primaryColor,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: height / 80),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width / 1.01,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: width / 30),
                                    child: Text.rich(
                                      TextSpan(
                                        children: <InlineSpan>[
                                          WidgetSpan(
                                            child: Text(
                                              'வணக்கம்',
                                              style: TextStyle(
                                                  fontFamily: "AnekTamil",
                                                  color: Get.isDarkMode
                                                      ? Colors.black
                                                      : Colors.white,
                                                  fontSize: 16.r,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          WidgetSpan(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: width / 78),
                                              child: Text(
                                                dashBoardcontroller.name,
                                                style: TextStyle(
                                                    fontFamily: "AnekTamil",
                                                    color: Get.isDarkMode
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontSize: 16.r,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(right: width / 50),
                                    child: Stack(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            var result = await (Connectivity()
                                                .checkConnectivity());
                                            if (result ==
                                                    ConnectivityResult.wifi ||
                                                result ==
                                                    ConnectivityResult.mobile) {
                                              Get.to(() => NotificationsPage());
                                            } else {
                                              Get.defaultDialog(
                                                  title: "Oops!...",
                                                  content: Text(
                                                      "Check your internet connection"),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        exit(0);
                                                      },
                                                      child: Text("Exit"),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary:
                                                                  primaryColor),
                                                      onPressed: () {
                                                        Get.back();
                                                        OpenSettings
                                                            .openWIFISetting();
                                                      },
                                                      child:
                                                          Text('Open Settings'),
                                                    ),
                                                  ]);
                                            }
                                          },
                                          child: Container(
                                            height: height / 28.1,
                                            width: width / 13,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Get.isDarkMode
                                                    ? Colors.black
                                                    : Colors.white),
                                            child: Center(
                                              child: Icon(
                                                  Icons
                                                      .notification_important_rounded,
                                                  size: 18.r),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: height / 168.8,
                                          right: width / 78,
                                          child: Container(
                                            height: height / 168.8,
                                            width: width / 178,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 30),
                              child: Text(
                                  "Subscription ID : ${dashBoardcontroller.subscriptionId}",
                                  style: TextStyle(
                                    fontFamily: "AnekTamil",
                                    color: Get.isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                  )),
                            ),
                            SizedBox(height: height / 84.4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    var result = await (Connectivity()
                                        .checkConnectivity());
                                    if (result == ConnectivityResult.wifi ||
                                        result == ConnectivityResult.mobile) {
                                      snackBarMsg(
                                          title: "Note !...",
                                          msg:
                                              "Enable Tamil keyboard and try to type in Tamil For more accurate results",
                                          bgColor: primaryColor,
                                          colors: Colors.white);
                                      Get.to(() => SearchBookPage());
                                    } else {
                                      Get.defaultDialog(
                                          title: "Oops!...",
                                          content: Text(
                                              "Check your internet connection"),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                exit(0);
                                              },
                                              child: Text("Exit"),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: primaryColor),
                                              onPressed: () {
                                                Get.back();
                                                OpenSettings.openWIFISetting();
                                              },
                                              child: Text('Open Settings'),
                                            ),
                                          ]);
                                    }
                                  },
                                  child: Container(
                                    height: height / 21.1,
                                    width: width / 1.21,
                                    decoration: BoxDecoration(
                                        color: Get.isDarkMode
                                            ? Colors.black
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: TextField(
                                      enabled: false,
                                      autofocus: false,
                                      onTap: () async {
                                        var result = await (Connectivity()
                                            .checkConnectivity());
                                        if (result == ConnectivityResult.wifi ||
                                            result ==
                                                ConnectivityResult.mobile) {
                                          snackBarMsg(
                                              title: "Note !...",
                                              msg:
                                                  "Enable Tamil keyboard and try to type in Tamil For more accurate results",
                                              bgColor: primaryColor,
                                              colors: Colors.white);
                                          Get.to(() => SearchBookPage());
                                        } else {
                                          Get.defaultDialog(
                                              title: "Oops!...",
                                              content: Text(
                                                  "Check your internet connection"),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    exit(0);
                                                  },
                                                  child: Text("Exit"),
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              primaryColor),
                                                  onPressed: () {
                                                    Get.back();
                                                    OpenSettings
                                                        .openWIFISetting();
                                                  },
                                                  child: Text('Open Settings'),
                                                ),
                                              ]);
                                        }
                                        setState(() {
                                          isSearch = !isSearch;
                                        });
                                      },
                                      controller: searchController,
                                      decoration: new InputDecoration(
                                        labelText: '      Enter Search Text',
                                        labelStyle: TextStyle(
                                            fontSize: 12.r,
                                            leadingDistribution:
                                                TextLeadingDistribution
                                                    .proportional),
                                        prefixText: ' ',
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isSearch = !isSearch;
                                              searchController.clear();
                                            });
                                          },
                                          icon: Icon(
                                            Icons.search,
                                            color: Get.isDarkMode
                                                ? Colors.white54
                                                : Colors.grey,
                                            size: 18.r,
                                          ),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    var result = await (Connectivity()
                                        .checkConnectivity());
                                    if (result == ConnectivityResult.wifi ||
                                        result == ConnectivityResult.mobile) {
                                      Get.to(() => FilterPage());
                                    } else {
                                      Get.defaultDialog(
                                          title: "Oops!...",
                                          content: Text(
                                              "Check your internet connection"),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                exit(0);
                                              },
                                              child: Text("Exit"),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: primaryColor),
                                              onPressed: () {
                                                Get.back();
                                                OpenSettings.openWIFISetting();
                                              },
                                              child: Text('Open Settings'),
                                            ),
                                          ]);
                                    }
                                  },
                                  child: Container(
                                    height: height / 21.1,
                                    width: width / 9.69,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Get.isDarkMode
                                            ? Colors.black
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Container(
                                      child: Image.asset(
                                        "assets/images/filter_btn.png",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropHeader(
                waterDropColor: primaryColor,
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                            height: height / 10.55,
                            width: double.infinity,
                            color: primaryColor),
                        GetBuilder<DashBoardController>(
                          builder: (_) => Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CarouselSlider.builder(
                              // carouselController: carouselController,
                              options: CarouselOptions(
                                  height: height / 5.62,
                                  scrollDirection: Axis.horizontal,
                                  enlargeCenterPage: false,
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  autoPlay: true,
                                  autoPlayCurve: Curves.ease,
                                  onPageChanged: (index, page) {
                                    setState(() {
                                      carouselIndex = index;
                                    });
                                  },
                                  autoPlayAnimationDuration:
                                      const Duration(seconds: 1)),
                              itemCount: dashBoardcontroller.bannerList.length,
                              itemBuilder: (context, index, realIdx) {
                                return sliderWidget(index);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 168.8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          dashBoardcontroller.bannerList.length,
                          (index) => Container(
                                height: height / 168.8,
                                width: width / 78,
                                margin: EdgeInsets.only(
                                    bottom: 3, left: 3, right: 3),
                                decoration: BoxDecoration(
                                    color: carouselIndex == index
                                        ? primaryColor
                                        : Color(0xFFD4D4D4),
                                    shape: BoxShape.circle),
                              )),
                    ),
                    SizedBox(
                      child: GetBuilder<DashBoardController>(
                          builder: (_) => Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width / 39),
                                        child: Row(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                               "வகைகள்" "Categories",
                                                style: TextStyle(
                                                    fontFamily: "AnekTamil",
                                                    color: Get.isDarkMode
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.r),
                                              ),
                                            ),
                                            Spacer(),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: TextButton(
                                                onPressed: () async {
                                                  var result =
                                                      await (Connectivity()
                                                          .checkConnectivity());
                                                  if (result ==
                                                          ConnectivityResult
                                                              .wifi ||
                                                      result ==
                                                          ConnectivityResult
                                                              .mobile) {
                                                    Get.to(
                                                        () => CategoriesPage());
                                                  } else {
                                                    Get.defaultDialog(
                                                        title: "Oops!...",
                                                        content: Text(
                                                            "Check your internet connection"),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              exit(0);
                                                            },
                                                            child: Text("Exit"),
                                                          ),
                                                          ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary:
                                                                        primaryColor),
                                                            onPressed: () {
                                                              Get.back();
                                                              OpenSettings
                                                                  .openWIFISetting();
                                                            },
                                                            child: Text(
                                                                'Open Settings'),
                                                          ),
                                                        ]);
                                                  }
                                                },
                                                child: GradientText(
                                                  "See All",
                                                  style: TextStyle(
                                                      fontFamily: "AnekTamil",
                                                      color: primaryColor,
                                                      fontSize: 14.r),
                                                  gradient: myGradient,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Container(
                                          height: height / 4.60,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return catWidget(
                                                  _, index, height, width);
                                            },
                                            itemCount: _.categoryList.length,
                                          ),
                                        ),
                                      ),
                                    ]),
                              )),
                    ),
                    SizedBox(
                        child: GetBuilder<DashBoardController>(
                      builder: (_) => Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "பிரபலமான கட்டுரைகள்",//Popular
                                        style: TextStyle(
                                            fontFamily: "AnekTamil",
                                            color: Get.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.r),
                                      ),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () async {
                                          var result = await (Connectivity()
                                              .checkConnectivity());
                                          if (result ==
                                                  ConnectivityResult.wifi ||
                                              result ==
                                                  ConnectivityResult.mobile) {
                                            Get.to(() => ListWiseBooksPage(),
                                                arguments: "popular");
                                          } else {
                                            Get.defaultDialog(
                                                title: "Oops!...",
                                                content: Text(
                                                    "Check your internet connection"),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      exit(0);
                                                    },
                                                    child: Text("Exit"),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                primaryColor),
                                                    onPressed: () {
                                                      Get.back();
                                                      OpenSettings
                                                          .openWIFISetting();
                                                    },
                                                    child:
                                                        Text('Open Settings'),
                                                  ),
                                                ]);
                                          }
                                        },
                                        child: GradientText(
                                          "See All",
                                          style: TextStyle(
                                              fontFamily: "AnekTamil",
                                              color: primaryColor,
                                              fontSize: 14.r),
                                          gradient: myGradient,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  height: height / 4.60,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return popularWidget(
                                          _, index, height, width);
                                    },
                                    itemCount: _.popularList.length,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    )),
                    SizedBox(
                        child: GetBuilder<DashBoardController>(
                      builder: (_) => Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "சமீபத்தில் சேர்க்கப்பட்டவை",//Recently Added
                                        style: TextStyle(
                                            fontFamily: "AnekTamil",
                                            color: Get.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.r),
                                      ),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () async {
                                          var result = await (Connectivity()
                                              .checkConnectivity());
                                          if (result ==
                                                  ConnectivityResult.wifi ||
                                              result ==
                                                  ConnectivityResult.mobile) {
                                            Get.to(() => ListWiseBooksPage(),
                                                arguments: "recent");
                                          } else {
                                            Get.defaultDialog(
                                                title: "Oops!...",
                                                content: Text(
                                                    "Check your internet connection"),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      exit(0);
                                                    },
                                                    child: Text("Exit"),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                primaryColor),
                                                    onPressed: () {
                                                      Get.back();
                                                      OpenSettings
                                                          .openWIFISetting();
                                                    },
                                                    child:
                                                        Text('Open Settings'),
                                                  ),
                                                ]);
                                          }
                                        },
                                        child: GradientText(
                                          "See All",
                                          style: TextStyle(
                                              fontFamily: "AnekTamil",
                                              color: primaryColor,
                                              fontSize: 14.r),
                                          gradient: myGradient,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  height: height / 4.60,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return recentlyAddedWidget(
                                          _, index, height, width);
                                    },
                                    itemCount: _.recommendedList.length,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ))
                  ],
                ),
              ),
            )));
  }

  Padding recentlyAddedWidget(
      DashBoardController _, int index, double height, double width) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        child: InkWell(
          onTap: () async {
            var result = await (Connectivity().checkConnectivity());
            if (result == ConnectivityResult.wifi ||
                result == ConnectivityResult.mobile) {
              Get.toNamed(ROUTE_BOOK_INTRO,
                  arguments: _.recommendedList[index].id);
            } else {
              Get.defaultDialog(
                  title: "Oops!...",
                  content: Text("Check your internet connection"),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: Text("Exit"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: primaryColor),
                      onPressed: () {
                        Get.back();
                        OpenSettings.openWIFISetting();
                      },
                      child: Text('Open Settings'),
                    ),
                  ]);
            }
          },
          child: Container(
            height: height / 4.60,
            width: width / 3.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        child: Image.network(
                          _.recommendedList[index].mainPicture!,
                          height: height / 8.44,
                          width: width / 3.35,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                        height: height / 56.20,
                        width: width / 13,
                        decoration: BoxDecoration(
                          color: Get.isDarkMode ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _.recommendedList[index].rating.toString(),
                                style: TextStyle(
                                    fontFamily: "AnekTamil", fontSize: 8.r),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFF0C94F),
                                size: 11.r,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
                  child: AutoSizeText(
                    _.recommendedList[index].title!,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    minFontSize: 8,
                    maxFontSize: 12,
                    maxLines: 4,
                    style: TextStyle(
                      fontFamily: "AnekTamil",
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding popularWidget(
      DashBoardController _, int index, double height, double width) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        child: InkWell(
          onTap: () async {
            var result = await (Connectivity().checkConnectivity());
            if (result == ConnectivityResult.wifi ||
                result == ConnectivityResult.mobile) {
              Get.toNamed(ROUTE_BOOK_INTRO, arguments: _.popularList[index].id);
            } else {
              Get.defaultDialog(
                  title: "Oops!...",
                  content: Text("Check your internet connection"),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: Text("Exit"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: primaryColor),
                      onPressed: () {
                        Get.back();
                        OpenSettings.openWIFISetting();
                      },
                      child: Text('Open Settings'),
                    ),
                  ]);
            }
          },
          child: Container(
            height: height / 4.60,
            width: width / 3.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      child: Image.network(
                        _.popularList[index].mainPicture!,
                        height: height / 8.44,
                        width: width / 3.35,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                        height: height / 56.20,
                        width: width / 13,
                        decoration: BoxDecoration(
                          color: Get.isDarkMode ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _.popularList[index].rating.toString(),
                                style: TextStyle(
                                    fontFamily: "AnekTamil", fontSize: 8.r),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFF0C94F),
                                size: 11.r,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: AutoSizeText(
                    _.popularList[index].title!,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    minFontSize: 8,
                    maxFontSize: 12,
                    maxLines: 4,
                    style: TextStyle(
                      fontFamily: "AnekTamil",
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding catWidget(
      DashBoardController _, int index, double height, double width) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        child: InkWell(
          onTap: () async {
            var result = await (Connectivity().checkConnectivity());
            if (result == ConnectivityResult.wifi ||
                result == ConnectivityResult.mobile) {
              Get.toNamed(ROUTE_CATEGORY_WISE,
                  arguments: _.categoryList[index].id);
            } else {
              Get.defaultDialog(
                  title: "Oops!...",
                  content: Text("Check your internet connection"),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: Text("Exit"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: primaryColor),
                      onPressed: () {
                        Get.back();
                        OpenSettings.openWIFISetting();
                      },
                      child: Text('Open Settings'),
                    ),
                  ]);
            }
          },
          child: Container(
            height: height / 4.60,
            width: width / 3.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      child: Image.network(
                        _.categoryList[index].mainPicture!,
                        height: height / 8.44,
                        width: width / 3.35,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: AutoSizeText(
                    _.categoryList[index].title!,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    minFontSize: 8,
                    maxFontSize: 12,
                    maxLines: 4,
                    style: TextStyle(
                      fontFamily: "AnekTamil",
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding categoriesWidget(
      DashBoardController _, int index, double height, double width) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        child: InkWell(
          onTap: () async {
            var result = await (Connectivity().checkConnectivity());
            if (result == ConnectivityResult.wifi ||
                result == ConnectivityResult.mobile) {
              Get.toNamed(ROUTE_CATEGORY_WISE,
                  arguments: _.categoryList[index].id);
            } else {
              Get.defaultDialog(
                  title: "Oops!...",
                  content: Text("Check your internet connection"),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: Text("Exit"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: primaryColor),
                      onPressed: () {
                        Get.back();
                        OpenSettings.openWIFISetting();
                      },
                      child: Text('Open Settings'),
                    ),
                  ]);
            }
          },
          child: Container(
            height: height / 4.60,
            width: width / 3.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      child: Image.network(
                        _.categoryList[index].mainPicture!,
                        height: height / 8.44,
                        width: width / 3.35,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: AutoSizeText(
                    _.categoryList[index].title!,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    minFontSize: 8,
                    maxFontSize: 14,
                    maxLines: 5,
                    style: TextStyle(
                      fontFamily: "AnekTamil",
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  sliderWidget(int index) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<DashBoardController>(
      builder: (_) => InkWell(
        onTap: () async {
          var result = await (Connectivity().checkConnectivity());
          if (result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile) {
            Get.to(() => BookIntroPage(), arguments: _.bannerList[index].id);
          } else {
            Get.defaultDialog(
                title: "Oops!...",
                content: Text("Check your internet connection"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: Text("Exit"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: primaryColor),
                    onPressed: () {
                      Get.back();
                      OpenSettings.openWIFISetting();
                    },
                    child: Text('Open Settings'),
                  ),
                ]);
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          shadowColor: Colors.grey[100],
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            height: height / 6.75,
            width: width / 1.01,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            _.bannerList[index].mainPicture!,
                            height: height / 6.50,
                            width: width / 3.40,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 5,
                          child: Container(
                            height: height / 56.20,
                            width: width / 13,
                            decoration: BoxDecoration(
                              color:
                                  Get.isDarkMode ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _.bannerList[index].rating!,
                                    style: TextStyle(
                                        fontFamily: "AnekTamil", fontSize: 8.r),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFF0C94F),
                                    size: 10.r,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: (width / 3.25) * 2,
                        child: Row(
                          children: [
                            Container(
                              constraints:
                                  BoxConstraints(maxWidth: width / 3.25),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFF83600), width: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: AutoSizeText(_.bannerList[index].category!,
                                  minFontSize: 8,
                                  maxFontSize: 10,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "AnekTamil",
                                    color: Color(0xFFF83600),
                                  )),
                            ),
                            Spacer(),
                            AutoSizeText(
                              _.bannerList[index].showDate!,
                              minFontSize: 10,
                              maxFontSize: 12,
                              style: TextStyle(
                                fontFamily: "AnekTamil",
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: (width / 3.25) * 2,
                        child: AutoSizeText(
                          _.bannerList[index].title!,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          minFontSize: 14,
                          maxFontSize: 16,
                          style: TextStyle(
                              fontFamily: "AnekTamil",
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: (width / 3.25) * 2,
                        child: AutoSizeText(
                          " ~ ${_.bannerList[index].authorName}",
                          maxLines: 1,
                          minFontSize: 12,
                          maxFontSize: 13,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: "AnekTamil",
                            color: Get.isDarkMode
                                ? Colors.white70
                                : Color(0xFF454545),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          _.bannerList[index].pages == "" ||
                                  _.bannerList[index].pages == "0"
                              ? SizedBox()
                              : Icon(
                                  FontAwesomeIcons.bookOpen,
                                  size: 14.r,
                                  color: Color(0xFFF83600),
                                ),
                          SizedBox(width: width / 50),
                          _.bannerList[index].pages == "" ||
                                  _.bannerList[index].pages == "0"
                              ? SizedBox()
                              : Text(
                                  _.bannerList[index].pages!,
                                  style: TextStyle(
                                      fontFamily: "AnekTamil",
                                      fontSize: 11.r,
                                      fontWeight: FontWeight.bold),
                                ),
                          SizedBox(width: width / 19.5),
                          Icon(
                            FontAwesomeIcons.eye,
                            size: 14.r,
                            color: Color(0xFFF83600),
                          ),
                          SizedBox(width: width / 50),
                          Text(
                            _.bannerList[index].visitor!.toString(),
                            style: TextStyle(
                                fontFamily: "AnekTamil",
                                fontSize: 11.r,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      GradientButton(
                        size: Size(width / 4.00, height / 28.1),
                        onPress: () async {
                          var result =
                              await (Connectivity().checkConnectivity());
                          if (result == ConnectivityResult.wifi ||
                              result == ConnectivityResult.mobile) {
                            Get.to(() => BookIntroPage(),
                                arguments: _.bannerList[index].id);
                          } else {
                            Get.defaultDialog(
                                title: "Oops!...",
                                content: Text("Check your internet connection"),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      exit(0);
                                    },
                                    child: Text("Exit"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: primaryColor),
                                    onPressed: () {
                                      Get.back();
                                      OpenSettings.openWIFISetting();
                                    },
                                    child: Text('Open Settings'),
                                  ),
                                ]);
                          }
                        },
                        name: "Read Now",
                        border: false,
                        gradient: gradientOpp,
                        fontSize: 10.r,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
