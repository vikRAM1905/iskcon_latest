class ReadingPageModel {
  bool? status;
  String? message;
  Result? result;

  ReadingPageModel({this.status, this.message, this.result});

  ReadingPageModel.fromJson(Map<String, dynamic> json) {
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
  List<Pages>? pages;

  Result({this.article, this.pages});

  Result.fromJson(Map<String, dynamic> json) {
    article =
        json['article'] != null ? new Article.fromJson(json['article']) : null;
    if (json['pages'] != null) {
      pages = <Pages>[];
      json['pages'].forEach((v) {
        pages!.add(new Pages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.article != null) {
      data['article'] = this.article!.toJson();
    }
    if (this.pages != null) {
      data['pages'] = this.pages!.map((v) => v.toJson()).toList();
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
  String? showDate;
  String? month;
  String? year;
  String? description;
  int? pages;
  int? view;
  String? rating;
  String? userRating;

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
      this.showDate,
      this.month,
      this.year,
      this.description,
      this.pages,
      this.view,
      this.rating,
      this.userRating});

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
    showDate = json['show_date'];
    month = json['month'];
    year = json['year'];
    description = json['description'];
    pages = json['pages'];
    view = json['view'];
    rating = json['rating'];
    userRating = json['user_rating'];
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
    data['show_date'] = this.showDate;
    data['month'] = this.month;
    data['year'] = this.year;
    data['description'] = this.description;
    data['pages'] = this.pages;
    data['view'] = this.view;
    data['rating'] = this.rating;
    data['user_rating'] = this.userRating;
    return data;
  }
}

class Pages {
  int? id;
  int? articleId;
  String? title;
  String? description;

  Pages({this.id, this.articleId, this.title, this.description});

  Pages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    articleId = json['article_id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['article_id'] = this.articleId;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
