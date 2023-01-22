class DashBoardModel {
  bool? status;
  bool? subscription;
  String? message;
  Result? result;

  DashBoardModel({this.status, this.subscription, this.message, this.result});

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subscription = json['subscription'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['subscription'] = this.subscription;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? name;
  String? subscriptionId;
  String? appVersion;
  List<Banner>? banner;
  List<Catergory>? catergory;
  List<Popular>? popular;
  List<Recommend>? recommend;

  Result(
      {this.name,
      this.subscriptionId,
      this.appVersion,
      this.banner,
      this.catergory,
      this.popular,
      this.recommend});

  Result.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subscriptionId = json['subscription_id'];
    appVersion = json['app_version'];
    if (json['banner'] != null) {
      banner = <Banner>[];
      json['banner'].forEach((v) {
        banner!.add(new Banner.fromJson(v));
      });
    }
    if (json['catergory'] != null) {
      catergory = <Catergory>[];
      json['catergory'].forEach((v) {
        catergory!.add(new Catergory.fromJson(v));
      });
    }
    if (json['popular'] != null) {
      popular = <Popular>[];
      json['popular'].forEach((v) {
        popular!.add(new Popular.fromJson(v));
      });
    }
    if (json['recommend'] != null) {
      recommend = <Recommend>[];
      json['recommend'].forEach((v) {
        recommend!.add(new Recommend.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['subscription_id'] = this.subscriptionId;
    data['app_version'] = this.appVersion;
    if (this.banner != null) {
      data['banner'] = this.banner!.map((v) => v.toJson()).toList();
    }
    if (this.catergory != null) {
      data['catergory'] = this.catergory!.map((v) => v.toJson()).toList();
    }
    if (this.popular != null) {
      data['popular'] = this.popular!.map((v) => v.toJson()).toList();
    }
    if (this.recommend != null) {
      data['recommend'] = this.recommend!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banner {
  int? id;
  String? title;
  String? mainPicture;
  String? month;
  String? year;
  String? authorName;
  String? time;
  int? type;
  String? category;
  String? showDate;
  String? festival;
  String? bookId;
  String? rating;
  String? visitor;
  String? pages;

  Banner(
      {this.id,
      this.title,
      this.mainPicture,
      this.month,
      this.year,
      this.authorName,
      this.time,
      this.type,
      this.category,
      this.showDate,
      this.festival,
      this.bookId,
      this.rating,
      this.visitor,
      this.pages});

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    mainPicture = json['main_picture'];
    month = json['month'];
    year = json['year'];
    authorName = json['author_name'];
    time = json['time'];
    type = json['type'];
    category = json['category'];
    showDate = json['show_date'];
    festival = json['festival'];
    bookId = json['book_id'];
    rating = json['rating'];
    visitor = json['visitor'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['main_picture'] = this.mainPicture;
    data['month'] = this.month;
    data['year'] = this.year;
    data['author_name'] = this.authorName;
    data['time'] = this.time;
    data['type'] = this.type;
    data['category'] = this.category;
    data['show_date'] = this.showDate;
    data['festival'] = this.festival;
    data['book_id'] = this.bookId;
    data['rating'] = this.rating;
    data['visitor'] = this.visitor;
    data['pages'] = this.pages;
    return data;
  }
}

class Catergory {
  int? id;
  String? title;
  String? picture;
  String? mainPicture;

  Catergory({this.id, this.title, this.picture, this.mainPicture});

  Catergory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    picture = json['picture'];
    mainPicture = json['main_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['picture'] = this.picture;
    data['main_picture'] = this.mainPicture;
    return data;
  }
}

class Popular {
  int? id;
  String? title;
  String? mainPicture;
  String? month;
  String? year;
  String? authorName;
  String? time;
  int? type;
  String? category;
  String? showDate;
  String? festival;
  String? bookId;
  String? rating;
  String? visitor;
  String? pages;

  Popular(
      {this.id,
      this.title,
      this.mainPicture,
      this.month,
      this.year,
      this.authorName,
      this.time,
      this.type,
      this.category,
      this.showDate,
      this.festival,
      this.bookId,
      this.rating,
      this.visitor,
      this.pages});

  Popular.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    mainPicture = json['main_picture'];
    month = json['month'];
    year = json['year'];
    authorName = json['author_name'];
    time = json['time'];
    type = json['type'];
    category = json['category'];
    showDate = json['show_date'];
    festival = json['festival'];
    bookId = json['book_id'];
    rating = json['rating'];
    visitor = json['visitor'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['main_picture'] = this.mainPicture;
    data['month'] = this.month;
    data['year'] = this.year;
    data['author_name'] = this.authorName;
    data['time'] = this.time;
    data['type'] = this.type;
    data['category'] = this.category;
    data['show_date'] = this.showDate;
    data['festival'] = this.festival;
    data['book_id'] = this.bookId;
    data['rating'] = this.rating;
    data['visitor'] = this.visitor;
    data['pages'] = this.pages;
    return data;
  }
}

class Recommend {
  int? id;
  String? title;
  String? mainPicture;
  String? month;
  String? year;
  String? authorName;
  String? time;
  int? type;
  String? category;
  String? showDate;
  String? festival;
  String? bookId;
  String? rating;
  String? visitor;
  String? pages;

  Recommend(
      {this.id,
      this.title,
      this.mainPicture,
      this.month,
      this.year,
      this.authorName,
      this.time,
      this.type,
      this.category,
      this.showDate,
      this.festival,
      this.bookId,
      this.rating,
      this.visitor,
      this.pages});

  Recommend.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    mainPicture = json['main_picture'];
    month = json['month'];
    year = json['year'];
    authorName = json['author_name'];
    time = json['time'];
    type = json['type'];
    category = json['category'];
    showDate = json['show_date'];
    festival = json['festival'];
    bookId = json['book_id'];
    rating = json['rating'];
    visitor = json['visitor'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['main_picture'] = this.mainPicture;
    data['month'] = this.month;
    data['year'] = this.year;
    data['author_name'] = this.authorName;
    data['time'] = this.time;
    data['type'] = this.type;
    data['category'] = this.category;
    data['show_date'] = this.showDate;
    data['festival'] = this.festival;
    data['book_id'] = this.bookId;
    data['rating'] = this.rating;
    data['visitor'] = this.visitor;
    data['pages'] = this.pages;
    return data;
  }
}
