import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/Model/question.dart';
import 'package:gilog/Utils/http_url.dart';
import 'package:gilog/Utils/toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/deliver_item.dart';
import '../../Model/deliver_list_item.dart';
import '../../Model/user.dart';

class Http_Presenter with ChangeNotifier {
  Gilog_User? _gilog_user;

  Gilog_User? get gilog_user => _gilog_user;

  set_token(String token) async {
    print("set token");
    print("token is $token");
    // shared preferences 얻기
    final prefs = await SharedPreferences.getInstance();
    final before_token = prefs.getString('token');

    if (before_token == null) {
      print("이전에 저장된 토큰이 없습니다.");
      prefs.setString('token', token);
    } else {
      print("이전에 저장된 토큰이 있습니다..");
      prefs.remove('token');
      prefs.setString('token', token);
    }
  }

  read_token() async {
    final prefs = await SharedPreferences.getInstance();

// counter 키에 해당하는 데이터 읽기를 시도합니다. 만약 존재하지 않는 다면 0을 반환합니다.
    final token = prefs.getString('token');

    return token;
  }

  //http post
  Future post_gilog(File? imageFile, id, token) async {
    var request =
        new http.MultipartRequest("POST", Uri.parse(Http_URL().post_gilog_img));

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    request.headers.addAll(headers);

    request.fields['id'] = id;

    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile!.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      showtoast("기록 되었습니다!");
      return;
    } else {
      print("기록 실패");
      return;
    }
  }

  //http 사용자 정보 수정
  Future post_test_gilog(datetime, content, question, token) async {
    var res = await http.post(Uri.parse(Http_URL().post_gilog),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(
            {'writeDate': datetime, 'request': content, 'question': question}));

    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);

    print(res.body);
    print(res.statusCode);

    //statusCode 확인해볼것
    if (res.statusCode == 200) {
      return res.body;
    } else {
      return null;
    }
  }

  //http userinformation 가져오기
  Future<Question?> get_question(token) async {
    Question? question;
    var res = await http.get(Uri.parse(Http_URL().get_question), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);

    print("SE");
    print(res.body);
    print(data);

    //statusCode 확인해볼것
    if (res.statusCode == 200) {
      question = Question.fromJson(data);
      print("questionddd $question");

      print("get http question${question.question}");

      return question;
    } else {
      return null;
    }
  }

  //http userinformation 가져오기
  Future<Gilog_User?> get_user_info(token) async {
    var res = await http.get(Uri.parse(Http_URL().get_user_info), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);

    print("get user_info $data");

    //statusCode 확인해볼것
    if (res.statusCode == 200) {
      _gilog_user = Gilog_User.fromJson(data);
      print("G");
      print(_gilog_user!.username);
      notifyListeners();
      return _gilog_user;
    } else {
      return null;
    }
    notifyListeners();
  }

  //http 사용자 정보 수정
  post_user_info(token, name, age, gender) async {
    var res = await http.post(Uri.parse(Http_URL().post_user_info),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'nickname': name, 'age': age, 'gender': gender}));

    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);

    print("data$data");

    //statusCode 확인해볼것
    if (res.statusCode == 200) {
      return showtoast("정보 등록 완료");
    } else {
      return null;
    }
  }

  //http 사용자 정보 수정
  Future<Gilog_User?> post_edit_user(token, name, age, gender) async {
    var res = await http.post(Uri.parse(Http_URL().get_user_info),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'nickname': name, 'age': age, 'gender': gender}));

    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);

    //statusCode 확인해볼것
    if (res.statusCode == 200) {
      _gilog_user = Gilog_User.fromJson(data);
      notifyListeners();
      return _gilog_user;
    } else {
      return null;
    }
  }

  //주문 정보 post
  Future<bool?> post_deliver_info(
      product, orderDate, amount, dateList, price, address, token) async {
    print(product);
    print(orderDate);
    print(amount);
    print(dateList.toString());
    print(price);
    print(address);

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

    print(res.body);

    //statusCode 확인해볼것
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //user 주문 내역 list get
  Future<List<dynamic>?> get_item_list(token) async {
    var data_list = [];
    final response = await http.get(
      Uri.parse(Http_URL().get_item_list_url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      //한글 깨지는거 인코딩으로 감싸줌
      final decodeData = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decodeData);

      print("${data[0]}");
      for (int i = 0; i < data.length; i++) {
        Deliver_list_item item;
        item = Deliver_list_item.fromJson(data[i]);
        print("$i $item");
        data_list.add(item);
      }

      // print(data_list);
      return data_list;
    } else {
      return null;
    }
  }

  //주문 상세 내역
  Future<Deliver_item?> get_item_detail(date_time, token) async {
    //date_time url에 추가
    var res = await http.get(Uri.parse(Http_URL().get_user_info), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);

    //statusCode 확인해볼것
    if (res.statusCode == 200) {
      // _gilog_user = Gilog_User.fromJson(data);
      // notifyListeners();
      // return _gilog_user;
    } else {
      return null;
    }
  }
}
