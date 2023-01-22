class MonthwiseModel {
  bool? status;
  String? message;
  Result? result;

  MonthwiseModel({this.status, this.message, this.result});

  MonthwiseModel.fromJson(Map<String, dynamic> json) {
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
  List<Article>? article;

  Result({this.article});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['article'] != null) {
      article = <Article>[];
      json['article'].forEach((v) {
        article!.add(new Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.article != null) {
      data['article'] = this.article!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Article {
  int? id;
  String? month;
  String? category;
  String? mainPicture;
  String? showDate;

  Article(
      {this.id, this.month, this.category, this.mainPicture, this.showDate});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    month = json['month'];
    category = json['category'];
    mainPicture = json['main_picture'];
    showDate = json['show_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['month'] = this.month;
    data['category'] = this.category;
    data['main_picture'] = this.mainPicture;
    data['show_date'] = this.showDate;
    return data;
  }
}
