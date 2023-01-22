class CategoryListModel {
  bool? status;
  String? message;
  Result? result;

  CategoryListModel({this.status, this.message, this.result});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
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
  List<Category>? category;

  Result({this.category});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? title;
  int? type;
  String? authorName;
  String? mainPicture;
  String? month;
  String? year;
  String? festival;

  Category(
      {this.id,
      this.title,
      this.type,
      this.authorName,
      this.mainPicture,
      this.month,
      this.year,
      this.festival});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    authorName = json['author_name'];
    mainPicture = json['main_picture'];
    month = json['month'];
    year = json['year'];
    festival = json['festival'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['author_name'] = this.authorName;
    data['main_picture'] = this.mainPicture;
    data['month'] = this.month;
    data['year'] = this.year;
    data['festival'] = this.festival;
    return data;
  }
}
