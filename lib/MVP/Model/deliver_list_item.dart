import 'dart:typed_data';

class Deliver_list_item {
  final int? id;
  final int? price;
  final String? orderDate;
  final int? payState;
  final int? deliveryState;

  Deliver_list_item({this.id, this.price, this.orderDate,this.payState,this.deliveryState});

  factory Deliver_list_item.fromJson(Map<String, dynamic> json) {
    return Deliver_list_item(
      id: json['id'],
      price: json['price'],
      orderDate: json['orderDate'],
        payState : json['payState'],
        deliveryState : json['deliveryState']
    );
  }
}
