import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:iskcon/Utils/urlUtils.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/pref_manager.dart';
import '../models/subsribePage_model.dart';

class SubscribeController extends GetxController {
  Dio _dio() {
    // Put your authorization token here
    return Dio(BaseOptions(
      headers: {
        'Accept': 'application/json',
        "Content-Type": "multipart/form-data",
        //"Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZGVtby5ncmVlbnBlbi5pblwvYXBpXC92MVwvbG9naW4iLCJpYXQiOjE2NDk2NzE0MjQsImV4cCI6MTY4MTIwNzQyNCwibmJmIjoxNjQ5NjcxNDI0LCJqdGkiOiIxVE91RkpaMTZSV092MTNIIiwic3ViIjoxOTEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.VwUfRomG97vcMVeilaiOnx16fQhBqRV8TLC8GgxYUE0",
        "Authorization":
            "Bearer ${Preferences.getStringValuesSF(Preferences.AUTH_CODE)}"
      },
      responseType: ResponseType.json,
      connectTimeout: 30000,
      receiveTimeout: 30000,
    ));
  }

  TextEditingController amountController = TextEditingController();
  var cardList = List<SubscriptionPlan>.empty(growable: true).obs;
  String content = "";
  // var amountsName = List<String>.empty(growable: true).obs;
  // var amount = List<String>.empty(growable: true).obs;
  var isLoading = false.obs;
  var myTest;
  var enteredAmount = '00'.obs;

  @override
  void onInit() async {
    // Preferences.clearAllValuesSF();
    // packageId = Get.arguments;
    // print("packageId $packageId");
    await getsubScribeApi();
    super.onInit();
  }

  @override
  void dispose() {
    Get.changeTheme(ThemeData.light());
    amountController.dispose();
    // amountsName.clear();
    super.dispose();
  }

  Future<void> getsubScribeApi() async {
    isLoading.value = true;
    // amountsName.clear();
    await APIProvider().subscribePageAPI(
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          content = data.result!.pageContent!;
          data.result!.subscriptionPlan!.forEach((element) {
            cardList.add(element);
            // amountsName.add(element.plan!);
            // amount.add(element.amount!);
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

  Future<dynamic> createOrderApi(val) async {
    var data;
    Map<String, dynamic> input = {
      'total': val,
    };
    await _dio()
        .post(urlCreateOrderForSubscribe, queryParameters: input)
        .then((res) {
      data = json.decode(res.toString());
      print('Log...${res.statusCode}');
    }).catchError((error) {
      print('ERROR VALUE :- $error');
    });
    update();
    return data;
  }

  Future<dynamic> paymentVerifyApi(
      paymentId, orderId, signature, plan, year) async {
    var data;
    Map<String, dynamic> input = {
      "razorpay_payment_id": paymentId,
      "razorpay_order_id": orderId,
      "razorpay_signature": signature,
      "plan": plan,
      "year": year
    };
    await _dio()
        .post(urlSubscribeSuccessPage, queryParameters: input)
        .then((res) {
      data = json.decode(res.toString());
      print('Log...${res.statusCode}');
    }).catchError((error) {
      print('ERROR VALUE :- $error');
    });
    update();
    return data;
  }
}
