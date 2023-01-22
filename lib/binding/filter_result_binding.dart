import 'package:get/get.dart';
import '../controller/filter_result_controller.dart';

class FilterResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterResultController());
  }
}
