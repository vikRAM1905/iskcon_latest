class NotificationClearModel {
  bool? status;
  String? message;
//  List<Null>? result;

  NotificationClearModel({this.status, this.message /*, this.result*/});

  NotificationClearModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // if (json['result'] != null) {
    //   result = <Null>[];
    //   json['result'].forEach((v) {
    //     result!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    // if (this.result != null) {
    //   data['result'] = this.result!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
