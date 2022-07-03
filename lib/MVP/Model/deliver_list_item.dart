import 'dart:typed_data';

class Deliver_list_item {
  final int? id;
  final int? price;
  final String? orderDate;

  Deliver_list_item({this.id, this.price, this.orderDate});

  factory Deliver_list_item.fromJson(Map<String, dynamic> json) {
    return Deliver_list_item(
      id: json['id'],
      price: json['price'],
      orderDate: json['orderDate'],
    );
  }
}
