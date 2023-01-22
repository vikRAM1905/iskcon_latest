class ComicViewModel {
  bool? status;
  String? message;
  Result? result;

  ComicViewModel({this.status, this.message, this.result});

  ComicViewModel.fromJson(Map<String, dynamic> json) {
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
  int? view;
  String? rating;
  String? userRating;
  int? pages;

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
      this.view,
      this.rating,
      this.userRating,
      this.pages});

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
    view = json['view'];
    rating = json['rating'];
    userRating = json['user_rating'];
    pages = json['pages'];
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
    data['view'] = this.view;
    data['rating'] = this.rating;
    data['user_rating'] = this.userRating;
    data['pages'] = this.pages;
    return data;
  }
}

class Pages {
  int? id;
  int? articleId;
  String? title;
  List<Description>? description;
  String? photoDescription;

  Pages(
      {this.id,
      this.articleId,
      this.title,
      this.description,
      this.photoDescription});

  Pages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    articleId = json['article_id'];
    title = json['title'];
    if (json['description'] != null) {
      description = <Description>[];
      json['description'].forEach((v) {
        description!.add(new Description.fromJson(v));
      });
    }
    photoDescription = json['photo_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['article_id'] = this.articleId;
    data['title'] = this.title;
    if (this.description != null) {
      data['description'] = this.description!.map((v) => v.toJson()).toList();
    }
    data['photo_description'] = this.photoDescription;
    return data;
  }
}

class Description {
  String? viewType;
  String? picture;
  String? width;
  String? height;
  String? size;
  int? orderNo;

  Description(
      {this.viewType,
      this.picture,
      this.width,
      this.height,
      this.size,
      this.orderNo});

  Description.fromJson(Map<String, dynamic> json) {
    viewType = json['view_type'];
    picture = json['picture'];
    width = json['width'];
    height = json['height'];
    size = json['size'];
    orderNo = json['order_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['view_type'] = this.viewType;
    data['picture'] = this.picture;
    data['width'] = this.width;
    data['height'] = this.height;
    data['size'] = this.size;
    data['order_no'] = this.orderNo;
    return data;
  }
}
