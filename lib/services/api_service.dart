import 'package:dio/dio.dart';

import '../Utils/pref_manager.dart';

class ApiRequest {
  final String url;
  final Map<String, dynamic>? params;
  var formdataParams;

  ApiRequest({required this.url, this.params, this.formdataParams});

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

//without content_type
  Dio _dio2() {
    // Put your authorization token here
    return Dio(BaseOptions(
      headers: {
        'Accept': 'application/json',
        // "Content-Type": "multipart/form-data",
        //"Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZGVtby5ncmVlbnBlbi5pblwvYXBpXC92MVwvbG9naW4iLCJpYXQiOjE2NDk2NzE0MjQsImV4cCI6MTY4MTIwNzQyNCwibmJmIjoxNjQ5NjcxNDI0LCJqdGkiOiIxVE91RkpaMTZSV092MTNIIiwic3ViIjoxOTEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.VwUfRomG97vcMVeilaiOnx16fQhBqRV8TLC8GgxYUE0",
        "Authorization":
            "Bearer ${Preferences.getStringValuesSF(Preferences.AUTH_CODE)}"
      },
      responseType: ResponseType.json,
      connectTimeout: 30000,
      receiveTimeout: 30000,
    ));
  }

  Future<void> get({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    print('GET METHOD DATA  URLS :- $url \n PARAMS :- $params');
    await _dio().get(url, queryParameters: params).then((res) {
      print("Response : ${res.statusCode}");
      print("Response : ${res.statusMessage}");
      print("Response : ${res.data.toString()}");
      if (onSuccess != null) onSuccess(res);
    }).catchError((error) {
      print("Response Error : $error");
      if (onError != null) onError(_handleError(error));
    });
  }

  Future<void> postWithData({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    print(' POST METHOD  DATA  URLS :- $url \n PARAMS :- $params');
    print("formatted params : $formdataParams");
    // print("Authorization : ${Preferences.getStringValuesSF(Preferences.AUTH_CODE)}");
    await _dio().post(url, data: formdataParams).then((res) {
      print("Response : ${res.statusCode}");
      print("Response : ${res.statusMessage}");
      print("Response : ${res.data.toString()}");
      if (onSuccess != null) onSuccess(res);
    }).catchError((error) {
      print('ERROR VALUE $error');
      if (onError != null) onError(_handleError(error));
    });
  }

//without content_type
  Future<void> postWithData2({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    print(' POST METHOD  DATA  URLS :- $url \n PARAMS :- $params');
    print("formatted params : $formdataParams");
    // print("Authorization : ${Preferences.getStringValuesSF(Preferences.AUTH_CODE)}");
    await _dio2().post(url, data: formdataParams).then((res) {
      print("Response : ${res.statusCode}");
      print("Response : ${res.statusMessage}");
      print("Response : ${res.data.toString()}");
      if (onSuccess != null) onSuccess(res);
    }).catchError((error) {
      print('ERROR VALUE $error');
      if (onError != null) onError(_handleError(error));
    });
  }

  Future<void> postWithQuery({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    print(' POST METHOD  DATA  URLS :- $url \n PARAMS :- $params');
    //print("Authorization : ${Preferences.getStringValuesSF(Preferences.AUTH_CODE)}");
    await _dio().post(url, queryParameters: params).then((res) {
      print('Log...${res.statusCode}');
      if (onSuccess != null) onSuccess(res);
    }).catchError((error) {
      print('ERROR VALUE :- $error');
      if (onError != null) onError(_handleError(error));
    });
  }

  Future<void> postWithFile({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    print(
        ' POST METHOD WITH FILE  DATA  URLS :- $url \n PARAMS :- $formdataParams');

    await _dio().post(url, data: formdataParams).then((res) {
      if (onSuccess != null) onSuccess(res);
    }).catchError((error) {
      print('ERROR VALUE $error');
      if (onError != null) onError(_handleError(error));
    });
  }
}

String _handleError(DioError error) {
  String? errorDescription = '';

  switch (error.type) {
    case DioErrorType.cancel:
      errorDescription = 'Request to API server was cancelled';
      break;
    case DioErrorType.connectTimeout:
      errorDescription = 'Connection timeout with API server';
      break;
    case DioErrorType.other:
      errorDescription =
          'Connection to API server failed due to internet connection';
      break;
    case DioErrorType.receiveTimeout:
      errorDescription = 'Receive timeout in connection with API server';
      break;
    case DioErrorType.response:
      errorDescription =
          'Error : ${error.response!.statusCode} - ${error.response!.statusMessage}';
      break;
    case DioErrorType.sendTimeout:
      errorDescription = 'Send timeout in connection with API server';
      break;
  }
  return errorDescription;
}
