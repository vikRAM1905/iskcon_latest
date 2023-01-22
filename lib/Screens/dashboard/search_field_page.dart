import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

import '../../Utils/contants.dart';

class SearchBookPage extends StatelessWidget {
  SearchBookPage({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();
  GoogleTranslator translator = GoogleTranslator();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: new AppBar(
        // title: new Text('Home'),
        backgroundColor: primaryColor,
        elevation: 0.0,
        toolbarHeight: 40,
      ),
      backgroundColor: Colors.grey.withOpacity(0.5),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            color: primaryColor,
            child: new Card(
              child: new ListTile(
                  horizontalTitleGap: 5,
                  title: new TextField(
                    autofocus: true,
                    controller: searchController,
                    decoration: new InputDecoration(
                      labelText: 'Enter Search Text',
                      labelStyle: TextStyle(fontSize: 12, color: primaryColor),
                      prefixText: ' ',
                      suffixIcon: new InkWell(
                        child: new Icon(
                          Icons.cancel,
                          size: 20,
                          color: Get.isDarkMode ? Colors.white54 : Colors.grey,
                        ),
                        onTap: () {
                          searchController.clear();
                          // onSearchTextChanged('');
                        },
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (_) {},
                  ),
                  trailing: InkWell(
                    onTap: () async {
                      if (searchController.text.isNotEmpty ||
                          searchController.text != '') {
                        var translation = await translator.translate(
                            searchController.text,
                            from: 'en',
                            to: 'ta');
                        print(
                            '${translation.source} (${translation.sourceLanguage}) == ${translation.text} (${translation.targetLanguage})');
                        if (translation.sourceLanguage.code == 'en')
                          print(
                              'code===========${translation.sourceLanguage.code}');
                        else
                          translation = await translator.translate(
                              searchController.text,
                              from: 'ta',
                              to: 'ta');

                        Get.toNamed(ROUTE_SEARCH_RESULT_PAGE,
                            arguments: translation.text);
                        // Get.to(() => SearchPage(),
                        //     arguments: searchController.text);
                      } else
                        snackBarMsg(
                            title: "message",
                            msg: "Enter keywords",
                            bgColor: primaryColor,
                            colors: Colors.white);
                    },
                    child: Icon(
                      Icons.search,
                      color: Get.isDarkMode ? Colors.white54 : Colors.grey,
                      size: 30,
                    ),
                  )),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //       color: Get.isDarkMode ? Colors.black : Colors.white,
          //       borderRadius: BorderRadius.circular(5)),
          //   child: TextField(
          //     controller: searchController,
          //     autofocus: true,
          //     // onTap: () {
          //     //   Get.to(() => SearchBookPage());
          //     //   // setState(() {
          //     //   //   isSearch = !isSearch;
          //     //   // });
          //     // },
          //     // controller: searchController,
          //     decoration: new InputDecoration(
          //       labelText: 'Enter Search Text',
          //       labelStyle: TextStyle(fontSize: 12, color: primaryColor),
          //       prefixIcon: IconButton(
          //         onPressed: () {
          //           Get.back();
          //         },
          //         icon: Icon(
          //           Icons.arrow_back,
          //           color: Colors.grey,
          //           size: 18.r,
          //         ),
          //       ),
          //       prefixText: ' ',
          //       suffixIcon: IconButton(
          //         onPressed: () async {
          //           if (searchController.text.isNotEmpty ||
          //               searchController.text != '') {
          //             var translation = await translator.translate(
          //                 searchController.text,
          //                 from: 'en',
          //                 to: 'ta');
          //             print(
          //                 '${translation.source} (${translation.sourceLanguage}) == ${translation.text} (${translation.targetLanguage})');
          //             if (translation.sourceLanguage.code == 'en')
          //               print(
          //                   'code===========${translation.sourceLanguage.code}');
          //             else
          //               translation = await translator.translate(
          //                   searchController.text,
          //                   from: 'ta',
          //                   to: 'ta');

          //             Get.toNamed(ROUTE_SEARCH_RESULT_PAGE,
          //                 arguments: translation.text);
          //             // Get.to(() => SearchPage(),
          //             //     arguments: searchController.text);
          //           } else
          //             snackBarMsg(
          //                 title: "message",
          //                 msg: "Enter keywords",
          //                 bgColor: primaryColor,
          //                 colors: Colors.white);
          //           // setState(() {
          //           //   isSearch = !isSearch;
          //           //   searchController.clear();
          //           // });
          //         },
          //         icon: Icon(
          //           Icons.search,
          //           color: Get.isDarkMode ? Colors.white54 : Colors.grey,
          //           size: 18.r,
          //         ),
          //       ),
          //       border: InputBorder.none,
          //     ),
          //   ),
          // ),
        ],
      )),
    );
  }
}
