import 'package:get/get.dart';

import '../controller/monthwise_articles_controller.dart';

class MonthwiseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MonthWiseBooksController());
  }
}
