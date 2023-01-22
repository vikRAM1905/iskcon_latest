import 'package:iskcon/models/category_books_model.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:get/get.dart';

class CategoryWiseBooksController extends GetxController {
  var categoryWiseBooks = List<Article>.empty(growable: true).obs;
  var isLoading = false.obs;
  var packageId;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    packageId = Get.arguments;
    print(packageId);
    categoryWiseApiData();
    super.onInit();
  }

  Future<void> categoryWiseApiData() async {
    isLoading.value = true;
    categoryWiseBooks.clear();
    await APIProvider().categoryWiseBooksApi(
      id: packageId,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          data.result!.article!.forEach((cat) {
            categoryWiseBooks.add(cat);
          });
        }
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : $error');
        isLoading.value = false;
      },
    );
    update();
  }
}
