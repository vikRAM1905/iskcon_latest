import 'package:iskcon/models/monthwise_books_model.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:get/get.dart';

class MonthWiseBooksController extends GetxController {
  var monthWiseBooks = List<Article>.empty(growable: true).obs;
  var isLoading = false.obs;
  var month;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    month = Get.arguments;
    print(month);
    categoryWiseApiData();
    super.onInit();
  }

  Future<void> categoryWiseApiData() async {
    isLoading.value = true;
    monthWiseBooks.clear();
    await APIProvider().monthWiseBooksApi(
      month: month,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          data.result!.article!.forEach((cat) {
            monthWiseBooks.add(cat);
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
