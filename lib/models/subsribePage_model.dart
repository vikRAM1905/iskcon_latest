class SubscriptionModel {
  bool? status;
  String? message;
  Result? result;

  SubscriptionModel({this.status, this.message, this.result});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
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
  String? pageContent;
  List<SubscriptionPlan>? subscriptionPlan;

  Result({this.pageContent, this.subscriptionPlan});

  Result.fromJson(Map<String, dynamic> json) {
    pageContent = json['page_content'];
    if (json['subscription_plan'] != null) {
      subscriptionPlan = <SubscriptionPlan>[];
      json['subscription_plan'].forEach((v) {
        subscriptionPlan!.add(new SubscriptionPlan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_content'] = this.pageContent;
    if (this.subscriptionPlan != null) {
      data['subscription_plan'] =
          this.subscriptionPlan!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubscriptionPlan {
  int? id;
  String? plan;
  String? amount;
  int? year;
  String? description;

  SubscriptionPlan(
      {this.id, this.plan, this.amount, this.year, this.description});

  SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plan = json['plan'];
    amount = json['amount'];
    year = json['year'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan'] = this.plan;
    data['amount'] = this.amount;
    data['year'] = this.year;
    data['description'] = this.description;
    return data;
  }
}
