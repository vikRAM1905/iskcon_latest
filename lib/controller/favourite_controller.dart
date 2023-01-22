import 'package:iskcon/controller/dashboard_controller.dart';
import 'package:iskcon/models/favorites_model.dart';
import 'package:iskcon/provider/api_provider.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  var favouriteBooks = List<Favourite>.empty(growable: true).obs;
  var dashboardController = Get.put(DashBoardController());
  var isLoading = false.obs;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    favouritesApiData();
    // if (dashboardController.selectedIndex == 1) apiCallingMethod();
    super.onInit();
  }

  Future<void> apiCallingMethod() async {
    await favouritesApiData();
  }

  Future<void> favouritesApiData() async {
    isLoading.value = true;
    favouriteBooks.clear();
    await APIProvider().favoriteBooksAPI(
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status == true) {
          data.result!.favourite!.forEach((cat) {
            favouriteBooks.add(cat);
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

  Future<void> getAddToFavApiData(int? packageId) async {
    Map<String, dynamic> input = {
      'blog_id': packageId,
    };
    isLoading.value = true;
    await APIProvider().addToCartAPI(
      params: input,
      onSuccess: (data) {
        print('Response 11 addToCartAPI: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!) {}
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : $error');
        isLoading.value = false;
      },
    );
    update();
  }

  Future<void> getRemoveFavApiData(int? bookId) async {
    // Map<String, dynamic> input ={
    //   'cart_id': cartId,
    // };
    isLoading.value = true;
    await APIProvider().removeFromFavouriteAPI(
      id: bookId,
      onSuccess: (data) {
        print('Response 11 Remove Cart: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!) {
          isLoading.value = false;
          favouritesApiData();
        }
      },
      onError: (error) {
        print('Error : $error');
        isLoading.value = false;
      },
    );
    update();
  }

  Future<void> getClearAllApiData() async {
    // Map<String, dynamic> input ={
    //   'cart_id': cartId,
    // };
    isLoading.value = true;
    await APIProvider().clearFavouritesAPI(
      onSuccess: (data) {
        print('Response 11 Clear Favourite: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!) {
          isLoading.value = false;
          favouritesApiData();
        }
      },
      onError: (error) {
        print('Error : $error');
        isLoading.value = false;
      },
    );
    update();
  }
}
