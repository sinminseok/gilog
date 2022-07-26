import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

import '../../../Utils/http_url.dart';
import '../../../Utils/toast.dart';
import '../../Model/deliver_item.dart';
import '../../Model/deliver_list_item.dart';
import '../../View/Account/login.dart';

class Deliver_Http {
//주문 정보 post
  Future<bool?> post_deliver_info(
      product, orderDate, amount, dateList, price, address, token) async {
    var res = await http.post(Uri.parse(Http_URL().post_deliver_info),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'product': product,
          'orderDate': orderDate,
          'amount': amount,
          'dateList': dateList.toString(),
          'price': price,
          'address': address
        }));


    //statusCode 확인해볼것
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

//user 주문 내역 list get
  Future<List<dynamic>?> get_item_list(token, context) async {
    var data_list = [];
    final response = await http.get(
      Uri.parse(Http_URL().get_item_list_url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      //한글 깨지는거 인코딩으로 감싸줌
      final decodeData = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decodeData);

      for (int i = 0; i < data.length; i++) {
        Deliver_list_item item;
        item = Deliver_list_item.fromJson(data[i]);
        data_list.add(item);
      }

      return data_list;
    }
    if (response.statusCode == 403) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: Login_Screen()));
    } else {
      return null;
    }
  }

//주문 상세 내역
  Future<Deliver_item?> get_item_detail(id, token, context) async {

    Deliver_item? item;
    //date_time url에 추가
    var res = await http.get(
        Uri.parse(
            "http://ec2-43-200-33-232.ap-northeast-2.compute.amazonaws.com:8080/api/order/${id}"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);





    //statusCode 확인해볼것
    if (res.statusCode == 200) {
      item = Deliver_item.fromJson(data);
      return item;
    }
    if (res.statusCode == 403) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: Login_Screen()));
    } else {
      showtoast("서버 꺼짐");
      return null;
    }
  }
}
