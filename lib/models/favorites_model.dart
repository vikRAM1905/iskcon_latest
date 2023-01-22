class FavoriteBooksModel {
  bool? status;
  String? message;
  Result? result;

  FavoriteBooksModel({this.status, this.message, this.result});

  FavoriteBooksModel.fromJson(Map<String, dynamic> json) {
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
  List<Favourite>? favourite;

  Result({this.favourite});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['favourite'] != null) {
      favourite = <Favourite>[];
      json['favourite'].forEach((v) {
        favourite!.add(new Favourite.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.favourite != null) {
      data['favourite'] = this.favourite!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Favourite {
  int? id;
  int? blogId;
  String? title;
  int? categoryId;
  String? category;
  String? mainPicture;
  String? authorName;
  int? type;
  String? month;
  String? year;
  String? time;
  String? showDate;
  String? bookId;
  String? rating;
  String? visitor;
  String? pages;

  Favourite(
      {this.id,
      this.blogId,
      this.title,
      this.categoryId,
      this.category,
      this.mainPicture,
      this.authorName,
      this.type,
      this.month,
      this.year,
      this.time,
      this.showDate,
      this.bookId,
      this.rating,
      this.visitor,
      this.pages});

  Favourite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    blogId = json['blog_id'];
    title = json['title'];
    categoryId = json['category_id'];
    category = json['category'];
    mainPicture = json['main_picture'];
    authorName = json['author_name'];
    type = json['type'];
    month = json['month'];
    year = json['year'];
    time = json['time'];
    showDate = json['show_date'];
    bookId = json['book_id'];
    rating = json['rating'];
    visitor = json['visitor'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['blog_id'] = this.blogId;
    data['title'] = this.title;
    data['category_id'] = this.categoryId;
    data['category'] = this.category;
    data['main_picture'] = this.mainPicture;
    data['author_name'] = this.authorName;
    data['type'] = this.type;
    data['month'] = this.month;
    data['year'] = this.year;
    data['time'] = this.time;
    data['show_date'] = this.showDate;
    data['book_id'] = this.bookId;
    data['rating'] = this.rating;
    data['visitor'] = this.visitor;
    data['pages'] = this.pages;
    return data;
  }
}
