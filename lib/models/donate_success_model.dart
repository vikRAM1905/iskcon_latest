class DonateSuccessModel {
  bool? status;
  String? message;
  Result? result;

  DonateSuccessModel({this.status, this.message, this.result});

  DonateSuccessModel.fromJson(Map<String, dynamic> json) {
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
  UserDetail? userDetail;
  String? title;
  String? content;

  Result({this.userDetail, this.title, this.content});

  Result.fromJson(Map<String, dynamic> json) {
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}

class UserDetail {
  int? id;
  String? firstName;
  String? lastName;
  int? mobileNo;
  String? email;
  String? gender;
  String? profilePhotoPath;
  String? plan;
  String? startDate;
  String? expiryDate;
  int? status;

  UserDetail(
      {this.id,
      this.firstName,
      this.lastName,
      this.mobileNo,
      this.email,
      this.gender,
      this.profilePhotoPath,
      this.plan,
      this.startDate,
      this.expiryDate,
      this.status});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    gender = json['gender'];
    profilePhotoPath = json['profile_photo_path'];
    plan = json['plan'];
    startDate = json['start_date'];
    expiryDate = json['expiry_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['plan'] = this.plan;
    data['start_date'] = this.startDate;
    data['expiry_date'] = this.expiryDate;
    data['status'] = this.status;
    return data;
  }
}
