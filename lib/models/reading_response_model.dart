class BookViewModel {
  String? id;
  String? bookName;
  String? titleImage;
  String? author;
  String? type;
  List<Pagess>? pages;

  BookViewModel(
      {this.id,
        this.bookName,
        this.titleImage,
        this.author,
        this.type,
        this.pages});

  BookViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookName = json['BookName'];
    titleImage = json['title_image'];
    author = json['author'];
    type = json['type'];
    if (json['pages'] != null) {
      pages = <Pagess>[];
      json['pages'].forEach((v) {
        pages?.add(new Pagess.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['BookName'] = this.bookName;
    data['title_image'] = this.titleImage;
    data['author'] = this.author;
    data['type'] = this.type;
    if (this.pages != null) {
      data['pages'] = this.pages?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagess {
  String? title;
  String? text;
  String? image;

  Pagess({this.title, this.text, this.image});

  Pagess.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['text'] = this.text;
    data['image'] = this.image;
    return data;
  }
}