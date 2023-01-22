class NotificationListModel {
  bool? status;
  String? message;
  List<Result>? result;

  NotificationListModel({this.status, this.message, this.result});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  int? customerId;
  String? title;
  String? description;
  int? status;
  String? createdAt;

  Result(
      {this.id,
      this.customerId,
      this.title,
      this.description,
      this.status,
      this.createdAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
