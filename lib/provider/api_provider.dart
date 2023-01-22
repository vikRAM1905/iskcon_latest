import 'dart:convert';
import 'package:iskcon/Utils/urlUtils.dart';
import 'package:iskcon/models/about_us_model.dart';
import 'package:iskcon/models/book_view_model.dart';
import 'package:iskcon/models/category_books_model.dart';
import 'package:iskcon/models/category_list_model.dart';
import 'package:iskcon/models/dashboard_model.dart';
import 'package:iskcon/models/favorites_model.dart';
import 'package:iskcon/models/filter_page_model.dart';
import 'package:iskcon/models/forgot_model.dart';
import 'package:iskcon/models/comic_view_model.dart';
import 'package:iskcon/models/intro_page_model.dart';
import 'package:iskcon/models/listwise_book_model.dart';
import 'package:iskcon/models/logout_model.dart';
import 'package:iskcon/models/monthwise_model.dart';
import 'package:iskcon/models/notification_clear_model.dart';
import 'package:iskcon/models/notification_model.dart';
import 'package:iskcon/models/notification_read_model.dart';
import 'package:iskcon/models/profileUpdate_model.dart';
import 'package:iskcon/models/profile_model.dart';
import 'package:iskcon/models/register_model.dart';
import 'package:iskcon/models/reset_model.dart';
import 'package:iskcon/models/subsribePage_model.dart';
import '../models/add_favourite_model.dart';
import '../models/articleVisit_model.dart';
import '../models/article_rating_model.dart';
import '../models/clear_fav_model.dart';
import '../models/donate_page_model.dart';
import '../models/donate_success_model.dart';
import '../models/filter_result_model.dart';
import '../models/login_model.dart';
import '../models/monthwise_books_model.dart';
import '../models/passwordUpdate_model.dart';
import '../models/remove_favourite_model.dart';
import '../models/search_result_model.dart';
import '../models/subscribe_success_model.dart';
import '../models/tagSearch_result_model.dart';
import '../services/api_service.dart';

/* date: 06.08.21
* name: vennila
* task: forgot_password (forgotAPI and resetApi added)*/
class APIProvider {
  Future<void> loginAPI({
    var params,
    Function()? beforeSend,
    Function(LoginModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlLogin, formdataParams: params).postWithData(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        LoginModel res = LoginModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> registerAPI({
    var params,
    Function()? beforeSend,
    Function(RegisterModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlRegister, formdataParams: params).postWithData(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        RegisterModel res =
            RegisterModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> forgotAPI({
    var params,
    Function()? beforeSend,
    Function(ForgotPasswordModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlForgot, params: params).postWithQuery(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        ForgotPasswordModel res =
            ForgotPasswordModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> resetAPI({
    var params,
    Function()? beforeSend,
    Function(ResetPasswordModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlReset, params: params).postWithQuery(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        ResetPasswordModel res =
            ResetPasswordModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> logoutAPI({
    var params,
    Function()? beforeSend,
    Function(LogOutModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlLogout, formdataParams: params).postWithData(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        LogOutModel res = LogOutModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> dashBoardAPI({
    var params,
    required String token,
    Function()? beforeSend,
    Function(DashBoardModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlHome(token: token), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        DashBoardModel res =
            DashBoardModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> filterApi({
    var params,
    Function()? beforeSend,
    Function(FilterPageModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlfilterList, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        FilterPageModel res =
            FilterPageModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> filterResultApi(
      {Function()? beforeSend,
      Function(FilterResultModel data)? onSuccess,
      Function(dynamic error)? onError,
      catList,
      year,
      months,
      authors}) async {
    var body = {
      "category_id": jsonEncode(catList),
      "month": jsonEncode(months),
      "year": jsonEncode(year),
      "author_name": jsonEncode(authors)
    };
    await ApiRequest(
      url: urlFilterResult(),
      formdataParams: body,
    ).postWithData2(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        FilterResultModel res =
            FilterResultModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> searchResultApi(
      {var params,
      Function()? beforeSend,
      Function(SearchResultModel data)? onSuccess,
      Function(dynamic error)? onError,
      keyword}) async {
    await ApiRequest(url: urlSearchResult(keyword: keyword), params: params)
        .get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        SearchResultModel res =
            SearchResultModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> bookPageApi(
      {var params,
      Function()? beforeSend,
      Function(ReadingPageModel data)? onSuccess,
      Function(dynamic error)? onError,
      id}) async {
    await ApiRequest(url: urlbookPage(id: id), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        ReadingPageModel res =
            ReadingPageModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> photoPageAPi({
    var params,
    Function()? beforeSend,
    Function(ComicViewModel data)? onSuccess,
    Function(dynamic error)? onError,
    int? id,
  }) async {
    await ApiRequest(url: urlbookPage(id: id), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        ComicViewModel res =
            ComicViewModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> introPageApi(
      {var params,
      Function()? beforeSend,
      Function(BookIntroModel data)? onSuccess,
      Function(dynamic error)? onError,
      id}) async {
    await ApiRequest(url: urlBookIntro(id: id), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        BookIntroModel res =
            BookIntroModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> articleVisitApi({
    var params,
    Function()? beforeSend,
    Function(ArticleVisitModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlArticleVisit, formdataParams: params).postWithData(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        ArticleVisitModel res =
            ArticleVisitModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> articleRatingApi({
    var params,
    Function()? beforeSend,
    Function(RatingResultModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlArticleRating, formdataParams: params)
        .postWithData(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        RatingResultModel res =
            RatingResultModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> favoriteBooksAPI({
    var params,
    Function()? beforeSend,
    Function(FavoriteBooksModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlFavourites, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        FavoriteBooksModel res =
            FavoriteBooksModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> addToCartAPI({
    var params,
    Function()? beforeSend,
    Function(AddFavouriteModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlAddFavourite, params: params).postWithQuery(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        final AddFavouriteModel res =
            AddFavouriteModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> removeFromFavouriteAPI({
    var params,
    int? id,
    Function()? beforeSend,
    Function(RemoveFavouriteModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlRemoveFavourite(id: id), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        final RemoveFavouriteModel res =
            RemoveFavouriteModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> clearFavouritesAPI({
    var params,
    Function()? beforeSend,
    Function(ClearFavouriteModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlClearFavourite(), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        final ClearFavouriteModel res =
            ClearFavouriteModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> profileAPI({
    var params,
    Function()? beforeSend,
    Function(ProfileModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlProfile, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        ProfileModel res = ProfileModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> profileUpdateAPI({
    var params,
    Function()? beforeSend,
    Function(PasswordUpdateModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlProfileUpdate, formdataParams: params)
        .postWithData(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        PasswordUpdateModel res =
            PasswordUpdateModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> passwordUpdateAPI({
    var params,
    Function()? beforeSend,
    Function(ProfileUpdateModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlPasswordUpdate, formdataParams: params)
        .postWithData(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        ProfileUpdateModel res =
            ProfileUpdateModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> categoryWiseBooksApi({
    var params,
    Function()? beforeSend,
    Function(CategoryWiseBookModel data)? onSuccess,
    Function(dynamic error)? onError,
    int? id,
  }) async {
    await ApiRequest(url: urlCategoryWiseBook(id: id), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        CategoryWiseBookModel res =
            CategoryWiseBookModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> categoryListAPI({
    var params,
    Function()? beforeSend,
    Function(CategoryListModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlCatgoryList, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        CategoryListModel res =
            CategoryListModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> monthwiseListAPI({
    var params,
    Function()? beforeSend,
    Function(MonthwiseModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlMonthwise, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        MonthwiseModel res =
            MonthwiseModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> monthWiseBooksApi({
    var params,
    Function()? beforeSend,
    Function(MonthwiseBooksModel data)? onSuccess,
    Function(dynamic error)? onError,
    String? month,
  }) async {
    await ApiRequest(url: urlMonthwiseResult(month: month), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        MonthwiseBooksModel res =
            MonthwiseBooksModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> TagSearchResultApi({
    var params,
    Function()? beforeSend,
    Function(TagSearchResultModel data)? onSuccess,
    Function(dynamic error)? onError,
    String? tag,
  }) async {
    await ApiRequest(url: urlTagSearchResultPage(tag: tag), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        TagSearchResultModel res =
            TagSearchResultModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> notificationAPI({
    var params,
    Function()? beforeSend,
    Function(NotificationListModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlNotification, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        NotificationListModel res =
            NotificationListModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> recommandBooksApi({
    var params,
    Function()? beforeSend,
    Function(ListWiseBookModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlRecommandBooks, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        ListWiseBookModel res =
            ListWiseBookModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> popularBooksApi({
    var params,
    Function()? beforeSend,
    Function(ListWiseBookModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlPopularBooks, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        ListWiseBookModel res =
            ListWiseBookModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> notificationReadAPI({
    var params,
    Function()? beforeSend,
    Function(NotificationReadModel data)? onSuccess,
    Function(dynamic error)? onError,
    int? id,
  }) async {
    await ApiRequest(url: urlNotificationRead(id: id), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        NotificationReadModel res =
            NotificationReadModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> notificationClearAPI({
    var params,
    Function()? beforeSend,
    Function(NotificationClearModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlNotificationClear, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        NotificationClearModel res =
            NotificationClearModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> aboutUsAPI({
    var params,
    Function()? beforeSend,
    Function(AboutUsModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlAboutUs, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        AboutUsModel res = AboutUsModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> donateAPI({
    var params,
    Function()? beforeSend,
    Function(DonateModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlDonatePage, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        DonateModel res = DonateModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> donateSuccessAPI({
    var params,
    Function()? beforeSend,
    Function(DonateSuccessModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlDonateSuccessPage, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        DonateSuccessModel res =
            DonateSuccessModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> subscribePageAPI({
    var params,
    Function()? beforeSend,
    Function(SubscriptionModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlSubscribePage, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        SubscriptionModel res =
            SubscriptionModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> subscribePaymentAPI({
    var params,
    Function()? beforeSend,
    Function(SubscribeSuccessModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlSubscribeSuccessPage, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        SubscribeSuccessModel res =
            SubscribeSuccessModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
