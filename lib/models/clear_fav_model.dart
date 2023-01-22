class ClearFavouriteModel {
  bool? status;
  String? message;
  // List<Null>? result;

  ClearFavouriteModel({this.status, this.message});

  ClearFavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // if (json['result'] != null) {
    //   result = new List<Null>();
    //   json['result'].forEach((v) {
    //     result.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    //   if (this.result != null) {
    //     data['result'] = this.result.map((v) => v.toJson()).toList();
    //   }
    return data;
  }
}
