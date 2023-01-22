import 'package:get/get.dart';
import '../controller/filter_controller.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterController());
  }
}
