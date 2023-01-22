import 'package:iskcon/controller/reset_controller.dart';
import 'package:get/get.dart';

class ResetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetController());
  }
}
