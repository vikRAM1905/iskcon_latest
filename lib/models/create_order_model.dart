class CreateOrderModel {
  bool? status;
  String? message;
  String? orderId;
  int? amount;
  String? key;

  CreateOrderModel(
      {this.status, this.message, this.orderId, this.amount, this.key});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderId = json['order_id'];
    amount = json['amount'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['order_id'] = this.orderId;
    data['amount'] = this.amount;
    data['key'] = this.key;
    return data;
  }
}
