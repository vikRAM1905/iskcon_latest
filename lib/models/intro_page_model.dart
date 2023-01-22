class BookIntroModel {
  bool? status;
  String? message;
  Result? result;

  BookIntroModel({this.status, this.message, this.result});

  BookIntroModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  Article? article;

  Result({this.article});

  Result.fromJson(Map<String, dynamic> json) {
    article =
        json['article'] != null ? new Article.fromJson(json['article']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.article != null) {
      data['article'] = this.article!.toJson();
    }
    return data;
  }
}

class Article {
  int? id;
  int? categoryId;
  String? category;
  String? title;
  String? authorName;
  String? time;
  int? type;
  String? festival;
  String? mainPicture;
  String? description;
  String? showDate;
  String? month;
  String? year;
  int? pages;
  int? view;
  String? rating;
  String? userRating;
  String? userFavourite;

  Article(
      {this.id,
      this.categoryId,
      this.category,
      this.title,
      this.authorName,
      this.time,
      this.type,
      this.festival,
      this.mainPicture,
      this.description,
      this.showDate,
      this.month,
      this.year,
      this.pages,
      this.view,
      this.rating,
      this.userRating,
      this.userFavourite});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    category = json['category'];
    title = json['title'];
    authorName = json['author_name'];
    time = json['time'];
    type = json['type'];
    festival = json['festival'];
    mainPicture = json['main_picture'];
    description = json['description'];
    showDate = json['show_date'];
    month = json['month'];
    year = json['year'];
    pages = json['pages'];
    view = json['view'];
    rating = json['rating'];
    userRating = json['user_rating'];
    userFavourite = json['user_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['category'] = this.category;
    data['title'] = this.title;
    data['author_name'] = this.authorName;
    data['time'] = this.time;
    data['type'] = this.type;
    data['festival'] = this.festival;
    data['main_picture'] = this.mainPicture;
    data['description'] = this.description;
    data['show_date'] = this.showDate;
    data['month'] = this.month;
    data['year'] = this.year;
    data['pages'] = this.pages;
    data['view'] = this.view;
    data['rating'] = this.rating;
    data['user_rating'] = this.userRating;
    data['user_favourite'] = this.userFavourite;
    return data;
  }
}
