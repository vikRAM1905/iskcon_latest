import 'package:iskcon/models/donate_success_model.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscribeSuccessController extends GetxController {
  TextEditingController amountController = TextEditingController();
  var status = false;
  var message = "";
  // var userDetails = List<UserDetail>.empty(growable: true).obs;
  var isLoading = false.obs;

  @override
  void onInit() async {
    await getSubscribeSuccessApi();
    super.onInit();
  }

  @override
  void dispose() {
    Get.changeTheme(ThemeData.light());
    super.dispose();
  }

  Future<void> getSubscribeSuccessApi() async {
    isLoading.value = true;
    await APIProvider().subscribePaymentAPI(
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          status = data.status!;
          message = data.message!;
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
