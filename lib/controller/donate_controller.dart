import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:iskcon/Utils/urlUtils.dart';
import 'package:iskcon/models/donate_page_model.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/pref_manager.dart';

class DonateController extends GetxController {
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
  var appDetail = List<AppDetail>.empty(growable: true).obs;
  String content = "";
  var amountsName = List<String>.empty(growable: true).obs;
  var amount = List<String>.empty(growable: true).obs;
  var isLoading = false.obs;
  var myTest;
  var enteredAmount = '00'.obs;
  String amountContent = "";

  @override
  void onInit() async {
    // Preferences.clearAllValuesSF();
    // packageId = Get.arguments;
    // print("packageId $packageId");
    await getDonateApi();
    super.onInit();
  }

  @override
  void dispose() {
    Get.changeTheme(ThemeData.light());
    amountController.dispose();
    amountsName.clear();
    super.dispose();
  }

  Future<void> getDonateApi() async {
    isLoading.value = true;
    amountsName.clear();
    await APIProvider().donateAPI(
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          appDetail.add(data.result!.appDetail!);
          content = data.result!.donationContent!;
          data.result!.amount!.forEach((element) {
            amountsName.add(element.name!);
            amount.add(element.amount!);
          });
          amountContent = data.result!.amountContent!;
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
    await _dio().post(urlCreateOrder, queryParameters: input).then((res) {
      data = json.decode(res.toString());
      print('Log...${res.statusCode}');
    }).catchError((error) {
      print('ERROR VALUE :- $error');
    });
    update();
    return data;
  }

  Future<dynamic> paymentVerifyApi(paymentId, orderId, signature) async {
    var data;
    Map<String, dynamic> input = {
      "razorpay_payment_id": paymentId,
      "razorpay_order_id": orderId,
      "razorpay_signature": signature
    };
    await _dio().post(urlPaymentVerify, queryParameters: input).then((res) {
      data = json.decode(res.toString());
      print('Log...${res.statusCode}');
    }).catchError((error) {
      print('ERROR VALUE :- $error');
    });
    update();
    return data;
  }
}
