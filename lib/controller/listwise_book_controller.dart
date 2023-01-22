import 'package:iskcon/provider/api_provider.dart';
import 'package:get/get.dart';

import '../models/listwise_book_model.dart';

class ListWiseBooksController extends GetxController {
  var listWiseBooks = List<Article>.empty(growable: true).obs;
  var isLoading = false.obs;
  var listName;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    listName = Get.arguments;
    print(listName);
    listName == "popular" ? popularApiData() : recommandApiData();
    super.onInit();
  }

  Future<void> popularApiData() async {
    isLoading.value = true;
    listWiseBooks.clear();
    await APIProvider().popularBooksApi(
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          data.result!.article!.forEach((cat) {
            listWiseBooks.add(cat);
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

  Future<void> recommandApiData() async {
    isLoading.value = true;
    listWiseBooks.clear();
    await APIProvider().recommandBooksApi(
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          data.result!.article!.forEach((cat) {
            listWiseBooks.add(cat);
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
