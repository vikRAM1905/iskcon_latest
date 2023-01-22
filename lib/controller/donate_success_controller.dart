import 'package:iskcon/models/donate_success_model.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonateSuccessController extends GetxController {
  TextEditingController amountController = TextEditingController();
  var title = "";
  var content = "";
  var userDetails = List<UserDetail>.empty(growable: true).obs;
  var isLoading = false.obs;

  @override
  void onInit() async {
    await getDonateSuccessApi();
    super.onInit();
  }

  @override
  void dispose() {
    Get.changeTheme(ThemeData.light());
    super.dispose();
  }

  Future<void> getDonateSuccessApi() async {
    isLoading.value = true;
    userDetails.clear();
    await APIProvider().donateSuccessAPI(
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          userDetails.add(data.result!.userDetail!);
          title = data.result!.title!;
          content = data.result!.content!;
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
