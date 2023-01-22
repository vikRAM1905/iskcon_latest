// const urlBase = 'https://admin.nnroll.in/api/';
const urlBase =
    'https://tamilbtg.in/api/'; //'https://demo.twics.in/iskcon/api/'

/*LOGIN PAGE*/
const urlLogin = urlBase + 'v1/login';
const urlRegister = urlBase + 'v1/register';
const urlForgot = urlBase + 'v1/forget_password';
const urlReset = urlBase + 'v1/reset_password';
String urlHome({required String token}) =>
    urlBase + 'v1/dashboard?fcm_token=$token';
String urlbookPage({int? id}) => urlBase + 'v1/article-pages/$id';
const urlArticleVisit = urlBase + 'v1/article_visit';
const urlArticleRating = urlBase + 'v1/article_rating';
const urlPhotoPage = urlBase + 'v1/photo-magazine';
const urlProfile = urlBase + 'v1/profile';
const urlProfileUpdate = urlBase + 'v1/profile-update';
const urlPasswordUpdate = urlBase + 'v1/reset_password';
const urlLogout = urlBase + 'v1/logout';
const urlCatgoryList = urlBase + 'v1/category';
const urlfilterList = urlBase + 'v1/filter';
String urlSearchResult({String? keyword}) =>
    urlBase + 'v1/article?keyword=$keyword';
String urlFilterResult(
        {dynamic catList,
        dynamic monthList,
        dynamic year,
        dynamic authorsName}) =>
    urlBase + 'v1/filter-result';
String urlBookIntro({int? id}) => urlBase + 'v1/article-detail/$id';
const String urlMonthwise = urlBase + 'v1/month-wise-article';
String urlMonthwiseResult({String? month}) =>
    urlBase + 'v1/month-wise-article/$month';
//const urlTakeTestFilter = urlBase+'v1/take-test-filter/2';
String urlCategoryWiseBook({int? id}) => urlBase + 'v1/article/$id';
const urlPopularBooks = urlBase + 'v1/popular-list';
const urlRecommandBooks = urlBase + 'v1/recent';
const urlNotification = urlBase + 'v1/notification';
String urlNotificationRead({int? id}) => urlBase + 'v1/notification-read/$id';
const urlNotificationClear = urlBase + 'v1/notification-clear';
const urlFavourites = urlBase + 'v1/favourite';
const String urlAddFavourite = urlBase + 'v1/add-favourite';
String urlRemoveFavourite({int? id}) => urlBase + 'v1/remove-favourite/$id';
String urlClearFavourite() => urlBase + 'v1/clear-all-favourite';
const String urlHelp = urlBase + 'v1/help';
const String urlPrivacyPolicy = urlBase + 'v1/privacy_policy';
const String urlTerms = urlBase + 'v1/terms';
const String urlAboutUs = urlBase + 'v1/about';
const String urlCreateOrder = urlBase + 'v1/order-element';
const String urlPaymentVerify = urlBase + 'v1/payment-verification';
const String urlDonatePage = urlBase + 'v1/donate';
const String urlDonateSuccessPage = urlBase + 'v1/donate-success';
String urlTagSearchResultPage({String? tag}) =>
    urlBase + 'v1/filter-tag?festival_tags=$tag';
const String urlCreateOrderForSubscribe =
    urlBase + 'v1/subscription-payment-initiate';
const String urlSubscribePage = urlBase + 'v1/subscription-plan';
const String urlSubscribeSuccessPage =
    urlBase + 'v1/subscription-payment-success';
