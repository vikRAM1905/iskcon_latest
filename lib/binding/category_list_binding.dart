import 'package:iskcon/controller/categories_controller.dart';
import 'package:get/get.dart';

class CategoryListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoriesController());
  }
}
