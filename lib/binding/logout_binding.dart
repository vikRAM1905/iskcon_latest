import 'package:iskcon/controller/logout_controller.dart';
import 'package:get/get.dart';

class LogoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogoutController());
  }
}
