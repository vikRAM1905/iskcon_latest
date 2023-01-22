class LoginModel {
  bool? status;
  String? message;
  String? tokenType;
  String? jwtToken;
  List<UserDetail>? userDetail;

  LoginModel(
      {this.status,
      this.message,
      this.tokenType,
      this.jwtToken,
      this.userDetail});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    tokenType = json['token_type'];
    jwtToken = json['jwt_token'];
    if (json['user_detail'] != null) {
      userDetail = <UserDetail>[];
      json['user_detail'].forEach((v) {
        userDetail?.add(new UserDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token_type'] = this.tokenType;
    data['jwt_token'] = this.jwtToken;
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail?.map((v) => v.toJson()).toList();
    }
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
