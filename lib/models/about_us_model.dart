class AboutUsModel {
  bool? status;
  String? message;
  Result? result;

  AboutUsModel({this.status, this.message, this.result});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
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
  String? image;
  String? about;
  Contact? contact;

  Result({this.image, this.about, this.contact});

  Result.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    about = json['about'];
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['about'] = this.about;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    return data;
  }
}

class Contact {
  Landline? landline;
  Mobile? mobile;
  CustomerSupport? customerSupport;
  WhatsApp? whatsApp;
  Email? email;

  Contact(
      {this.landline,
      this.mobile,
      this.customerSupport,
      this.whatsApp,
      this.email});

  Contact.fromJson(Map<String, dynamic> json) {
    landline = json['landline'] != null
        ? new Landline.fromJson(json['landline'])
        : null;
    mobile =
        json['mobile'] != null ? new Mobile.fromJson(json['mobile']) : null;
    customerSupport = json['customer_support'] != null
        ? new CustomerSupport.fromJson(json['customer_support'])
        : null;
    whatsApp = json['whatsApp'] != null
        ? new WhatsApp.fromJson(json['whatsApp'])
        : null;
    email = json['email'] != null ? new Email.fromJson(json['email']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.landline != null) {
      data['landline'] = this.landline!.toJson();
    }
    if (this.mobile != null) {
      data['mobile'] = this.mobile!.toJson();
    }
    if (this.customerSupport != null) {
      data['customer_support'] = this.customerSupport!.toJson();
    }
    if (this.whatsApp != null) {
      data['whatsApp'] = this.whatsApp!.toJson();
    }
    if (this.email != null) {
      data['email'] = this.email!.toJson();
    }
    return data;
  }
}

class Landline {
  String? landlineName;
  String? landlineNumber;

  Landline({this.landlineName, this.landlineNumber});

  Landline.fromJson(Map<String, dynamic> json) {
    landlineName = json['landline_name'];
    landlineNumber = json['landline_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['landline_name'] = this.landlineName;
    data['landline_number'] = this.landlineNumber;
    return data;
  }
}

class Mobile {
  String? mobile;
  String? mobileNumber;

  Mobile({this.mobile, this.mobileNumber});

  Mobile.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    mobileNumber = json['mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['mobile_number'] = this.mobileNumber;
    return data;
  }
}

class CustomerSupport {
  String? customerSupport;
  String? customerSupportNumber;

  CustomerSupport({this.customerSupport, this.customerSupportNumber});

  CustomerSupport.fromJson(Map<String, dynamic> json) {
    customerSupport = json['customer_support'];
    customerSupportNumber = json['customer_support_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_support'] = this.customerSupport;
    data['customer_support_number'] = this.customerSupportNumber;
    return data;
  }
}

class WhatsApp {
  String? whatsApp;
  String? whatsAppName;

  WhatsApp({this.whatsApp, this.whatsAppName});

  WhatsApp.fromJson(Map<String, dynamic> json) {
    whatsApp = json['whatsApp'];
    whatsAppName = json['whatsApp_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['whatsApp'] = this.whatsApp;
    data['whatsApp_name'] = this.whatsAppName;
    return data;
  }
}

class Email {
  String? email;
  String? emailName;

  Email({this.email, this.emailName});

  Email.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    emailName = json['email_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['email_name'] = this.emailName;
    return data;
  }
}
