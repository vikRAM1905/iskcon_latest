import 'package:iskcon/controller/book_intro_controller.dart';
import 'package:get/get.dart';

class BookIntroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookIntroPageController());
  }
}
