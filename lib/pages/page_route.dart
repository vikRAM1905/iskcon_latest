// ignore_for_file: avoid_classes_with_only_static_members

import 'package:iskcon/Screens/categories/category_wise_books.dart';
import 'package:iskcon/Screens/dashboard/dashboard.dart';
import 'package:iskcon/Screens/favorites/favorite_page.dart';
import 'package:iskcon/Screens/login/login_page.dart';
import 'package:iskcon/Screens/reading/book_intro_page.dart';
import 'package:iskcon/Utils/contants.dart';
import 'package:iskcon/binding/bookIntro_binding.dart';
import 'package:iskcon/binding/category_wise_binding.dart';
import 'package:iskcon/binding/dashBoard_binding.dart';
import 'package:iskcon/binding/favorite_binding.dart';
import 'package:iskcon/binding/login_binding.dart';
import 'package:get/get.dart';

import '../Screens/categories/monthwise_articles.dart';
import '../Screens/dashboard/filter_page.dart';
import '../Screens/dashboard/filter_result_page.dart';
import '../Screens/dashboard/search_page.dart';
import '../Screens/notifications/notifications_detail_page.dart';
import '../Screens/register/register_page.dart';
import '../binding/filter_binding.dart';
import '../binding/filter_result_binding.dart';
import '../binding/monthwise_binding.dart';
import '../binding/notification_binding.dart';
import '../binding/register_binding.dart';
import '../binding/search_binding.dart';

/* date: 06.08.21
* name: vennila
* task: forgot_password (ForgetPasswordBinding added)*/
class AppPages {
  static final List<GetPage> pages = [
    //GetPage(name: ROUTE_SPLASH, page: () => SplashScreen()),
    GetPage(
        name: ROUTE_LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
        name: ROUTE_REGISTER,
        page: () => RegisterPage(),
        binding: RegisterBinding()),
    GetPage(
        name: ROUTE_DASHBOARD,
        page: () => DashBoard(),
        binding: DashBoardBinding()),
    GetPage(
        name: ROUTE_CATEGORY_WISE,
        page: () => CategoryWiseBooksPage(),
        binding: CategoriesBinding()),
    GetPage(
        name: ROUTE_MONTH_WISE,
        page: () => MonthWiseBooksPage(),
        binding: MonthwiseBinding()),
    GetPage(
        name: ROUTE_BOOK_INTRO,
        page: () => BookIntroPage(),
        binding: BookIntroBinding()),
    GetPage(
        name: ROUTE_FAVORITE_BOOKS,
        page: () => FavouritesPage(),
        binding: FavoriteBinding()),
    GetPage(
        name: ROUTE_NOTIFICATION_READ,
        page: () => NotificationsDetailPage(),
        binding: NotificationBinding()),
    GetPage(
        name: ROUTE_FILTER_PAGE,
        page: () => FilterPage(),
        binding: FilterBinding()),
    GetPage(
        name: ROUTE_FILTER_RESULT_PAGE,
        page: () => FilterResultPage(),
        binding: FilterResultBinding()),
    GetPage(
        name: ROUTE_SEARCH_RESULT_PAGE,
        page: () => SearchPage(),
        binding: SearchBinding()),
  ];
}
