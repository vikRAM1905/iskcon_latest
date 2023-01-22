import 'package:iskcon/controller/categoryWise_book_controller.dart';
import 'package:get/get.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryWiseBooksController());
  }
}
