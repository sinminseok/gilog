import 'dart:typed_data';

class Deliver_item {
  final int? id;
  final String? product;
  final String? orderDate;
  final int? amount;
  final int? price;
  final String? address;
  final int? payState;

  Deliver_item(
      {this.id,
      this.product,
      this.orderDate,
      this.amount,
      this.price,
      this.address,
      this.payState});

  factory Deliver_item.fromJson(Map<String, dynamic> json) {
    return Deliver_item(
      id: json['id'],
      product: json['product'],
      orderDate: json['orderDate'],
      amount: json['amount'],
      price: json['price'],
      address: json['address'],
      payState: json['payState'],
    );
  }
}
