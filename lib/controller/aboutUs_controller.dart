import 'package:flutter/material.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:get/get.dart';

import '../models/about_us_model.dart';

class AboutUsController extends GetxController {
  var contactList = List<Contact>.empty(growable: true).obs;
  var resultList = List<Result>.empty(growable: true).obs;
  var isLoading = false.obs;
  // var packageId;
  GlobalKey three = GlobalKey();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    aboutUsApiData();
    super.onInit();
  }

  Future<void> aboutUsApiData() async {
    isLoading.value = true;
    resultList.clear();
    contactList.clear();
    await APIProvider().aboutUsAPI(
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          resultList.add(data.result!);
          if (data.result!.contact != null) {
            contactList.add(data.result!.contact!);
          }
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
}
