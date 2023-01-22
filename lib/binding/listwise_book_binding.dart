import 'package:get/get.dart';
import '../controller/listwise_book_controller.dart';

class ListwiseBooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListWiseBooksController());
  }
}
