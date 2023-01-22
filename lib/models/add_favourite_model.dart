class AddFavouriteModel {
  bool? status;
  String? message;
  Result? result;

  AddFavouriteModel({this.status, this.message, this.result});

  AddFavouriteModel.fromJson(Map<String, dynamic> json) {
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
  Favourite? favourite;

  Result({this.favourite});

  Result.fromJson(Map<String, dynamic> json) {
    favourite = json['favourite'] != null
        ? new Favourite.fromJson(json['favourite'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.favourite != null) {
      data['favourite'] = this.favourite!.toJson();
    }
    return data;
  }
}

class Favourite {
  int? id;
  int? blogId;
  String? title;
  int? categoryId;
  String? mainPicture;
  String? authorName;
  int? type;
  String? month;
  String? year;
  String? time;
  String? showDate;

  Favourite(
      {this.id,
      this.blogId,
      this.title,
      this.categoryId,
      this.mainPicture,
      this.authorName,
      this.type,
      this.month,
      this.year,
      this.time,
      this.showDate});

  Favourite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    blogId = json['blog_id'];
    title = json['title'];
    categoryId = json['category_id'];
    mainPicture = json['main_picture'];
    authorName = json['author_name'];
    type = json['type'];
    month = json['month'];
    year = json['year'];
    time = json['time'];
    showDate = json['show_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['blog_id'] = this.blogId;
    data['title'] = this.title;
    data['category_id'] = this.categoryId;
    data['main_picture'] = this.mainPicture;
    data['author_name'] = this.authorName;
    data['type'] = this.type;
    data['month'] = this.month;
    data['year'] = this.year;
    data['time'] = this.time;
    data['show_date'] = this.showDate;
    return data;
  }
}
