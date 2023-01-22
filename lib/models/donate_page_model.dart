class DonateModel {
  bool? status;
  String? message;
  Result? result;

  DonateModel({this.status, this.message, this.result});

  DonateModel.fromJson(Map<String, dynamic> json) {
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
  String? donationContent;
  AppDetail? appDetail;
  String? amountContent;
  List<Amount>? amount;

  Result(
      {this.donationContent, this.appDetail, this.amountContent, this.amount});

  Result.fromJson(Map<String, dynamic> json) {
    donationContent = json['donation_content'];
    appDetail = json['app_detail'] != null
        ? new AppDetail.fromJson(json['app_detail'])
        : null;
    amountContent = json['amount_content'];
    if (json['amount'] != null) {
      amount = <Amount>[];
      json['amount'].forEach((v) {
        amount!.add(new Amount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['donation_content'] = this.donationContent;
    if (this.appDetail != null) {
      data['app_detail'] = this.appDetail!.toJson();
    }
    data['amount_content'] = this.amountContent;
    if (this.amount != null) {
      data['amount'] = this.amount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppDetail {
  String? appIcon;
  String? appTitle;

  AppDetail({this.appIcon, this.appTitle});

  AppDetail.fromJson(Map<String, dynamic> json) {
    appIcon = json['app_icon'];
    appTitle = json['app_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_icon'] = this.appIcon;
    data['app_title'] = this.appTitle;
    return data;
  }
}

class Amount {
  String? name;
  String? amount;

  Amount({this.name, this.amount});

  Amount.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    return data;
  }
}
