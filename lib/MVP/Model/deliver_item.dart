import 'dart:typed_data';


class Deliver_item {
  final int? id;
  final List<String>? ontap_datetime_list;
  final String? order_date_time;


  Deliver_item({this.id,this.ontap_datetime_list,this.order_date_time});

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'order_date_time':order_date_time,
      'ontap_datetime_list' : ontap_datetime_list,
    };
  }
}