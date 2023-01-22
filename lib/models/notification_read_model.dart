class NotificationReadModel {
  bool? status;
  String? message;
  Result? result;

  NotificationReadModel({this.status, this.message, this.result});

  NotificationReadModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? customerId;
  int? type;
  String? title;
  String? description;
  String? createdAt;

  Result(
      {this.id,
      this.customerId,
      this.type,
      this.title,
      this.description,
      this.createdAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['type'] = this.type;
    data['title'] = this.title;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    return data;
  }
}
