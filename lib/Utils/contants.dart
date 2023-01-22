/* date: 06.08.21
* name: vennila
* task: forgot_password & login_change_logout(FORGOT,LOGIN_RESET,LOGIN_MOB) */
/*THEME*/
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart' as api;

const UserThemeData = 'UserThemeData';

/*LANUGAE */
const String SAVE_LANG = 'SAVELANG';
String? token = '';

/*PAGE ROUTER*/
const ROUTE_SPLASH = '/splash';
const ROUTE_LOGIN = '/login';
const ROUTE_OTP = '/OTP';
const ROUTE_REGISTER = '/register';
const ROUTE_HOME_PAGE = '/homePage';
const ROUTE_FORGOT_PASSWORD = '/forgotPassword';
const ROUTE_RESET_PASSWORD = '/resetPassword';
const ROUTE_RESET_SUCCESS = '/resetSuccess';
const ROUTE_LOGIN_SUCCESS = '/loginSuccess';
const ROUTE_DASHBOARD = '/dashboard';
const ROUTE_PROFILE_INFO = '/profileInfo';
const ROUTE_HELP = '/help';
const ROUTE_PRIVACY_POLICY = '/privacyPolicy';
const ROUTE_TERM_AND_CONDITIONS = '/termAndConditions';
const ROUTE_NOTIFICATION = '/notification';
const ROUTE_NOTIFICATION_READ = '/notificationRead';
const ROUTE_CATEGORY_WISE = '/category';
const ROUTE_MONTH_WISE = '/monthwiseBooks';
const ROUTE_CATEGORY_LIST = '/categoryList';
const ROUTE_FAVORITE_BOOKS = '/favorite';
const ROUTE_BOOK_INTRO = '/bookIntro';
const ROUTE_BOOK_CHAPTER = '/bookchapter';
const ROUTE_READ_PAGE = '/readingPage';
const ROUTE_FILTER_PAGE = '/filterPage';
const ROUTE_FILTER_RESULT_PAGE = '/filterResultPage';
const ROUTE_SEARCH_RESULT_PAGE = '/searchResultPage';
const ROUTE_DONATE_PAGE = '/donatePage';

/* PREF DATA */
const String FIREBASE_TOKEN = 'FIREBASE_TOKEN';
const String AUTH_CODE = 'AUTH_CODE';

String? convertMaptoString(Map<String, dynamic> value) {
  return json.encode(value);
}

Map<String, dynamic>? convertStringtoMap(String value) {
  return jsonDecode(value);
}

api.FormData inputParams(Map<String, dynamic> map) {
  print('PARAMS:- $map');
  return api.FormData.fromMap(map);
}

Map<String, dynamic> readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'token': token,
    'deviceType': 'ANDROID',
    'release': '${build.version.release}',
    'version': '${build.version.sdkInt}',
    'id': '${build.id}',
    'brand': '${build.brand}',
    'model': '${build.model}',
    'board': '${build.board}',
    // 'lang': getLanguage(),
  };
}

Map<String, dynamic> readIosDeviceInfo(IosDeviceInfo data) {
  return <String, dynamic>{
    'token': token,
    'deviceType': 'IOS',
    'release': '${data.utsname.release}',
    'version': '${data.systemVersion}',
    'id': '${data.identifierForVendor}',
    'brand': '${data.model}',
    'model': '${data.name}',
    'board': '${data.systemName}',
    // 'lang': getLanguage(),
  };
}
