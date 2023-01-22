class FilterPageModel {
  bool? status;
  String? message;
  Result? result;

  FilterPageModel({this.status, this.message, this.result});

  FilterPageModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? tagList;
  List<AuthorName>? authorName;
  List<Category>? category;
  List<String>? month;
  List<String>? year;

  Result({this.tagList, this.authorName, this.category, this.month, this.year});

  Result.fromJson(Map<String, dynamic> json) {
    tagList = json['tag_list'].cast<String>();
    if (json['author_name'] != null) {
      authorName = <AuthorName>[];
      json['author_name'].forEach((v) {
        authorName!.add(new AuthorName.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    month = json['month'].cast<String>();
    year = json['year'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_list'] = this.tagList;
    if (this.authorName != null) {
      data['author_name'] = this.authorName!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    data['month'] = this.month;
    data['year'] = this.year;
    return data;
  }
}

class AuthorName {
  String? authorName;

  AuthorName({this.authorName});

  AuthorName.fromJson(Map<String, dynamic> json) {
    authorName = json['author_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author_name'] = this.authorName;
    return data;
  }
}

class Category {
  int? id;
  String? title;

  Category({this.id, this.title});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
