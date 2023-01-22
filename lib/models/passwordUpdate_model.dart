class PasswordUpdateModel {
  bool? status;
  String? message;
  Result? result;

  PasswordUpdateModel({this.status, this.message, this.result});

  PasswordUpdateModel.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  int? mobileNo;
  String? email;
  String? gender;
  String? profilePhotoPath;
  String? plan;
  String? startDate;
  String? deviceId;
  String? accessToken;
  String? createdAt;
  String? profilePhotoUrl;

  Result(
      {this.id,
      this.firstName,
      this.lastName,
      this.mobileNo,
      this.email,
      this.gender,
      this.profilePhotoPath,
      this.plan,
      this.startDate,
      this.deviceId,
      this.accessToken,
      this.createdAt,
      this.profilePhotoUrl});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    gender = json['gender'];
    profilePhotoPath = json['profile_photo_path'];
    plan = json['plan'];
    startDate = json['start_date'];
    deviceId = json['device_id'];
    accessToken = json['access_token'];
    createdAt = json['created_at'];
    profilePhotoUrl = json['profile_photo_url'];
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
    data['device_id'] = this.deviceId;
    data['access_token'] = this.accessToken;
    data['created_at'] = this.createdAt;
    data['profile_photo_url'] = this.profilePhotoUrl;
    return data;
  }
}
