import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

import '../../../Utils/http_url.dart';
import '../../../Utils/toast.dart';
import '../../Model/user.dart';
import 'package:http/http.dart' as http;

import '../../View/Account/login.dart';

class User_Http with ChangeNotifier {
  Gilog_User? _gilog_user;

  Gilog_User? get gilog_user => _gilog_user;

  //회원탈퇴
  Future<bool?> resign(token, context) async {
    var res = await http.post(
      Uri.parse(Http_URL().logout_url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);



    //statusCode 확인해볼것
    if (res.statusCode == 200) {
      showtoast("회원 탈퇴 완료");
      return true;
    }
    if (res.statusCode == 403) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: Login_Screen()));
    } else {
      showtoast("회원 탈퇴 실패");
      return false;
    }
  }



  //http userinformation 가져오기
  Future<Gilog_User?> get_user_info(token, context) async {
    var res = await http.get(Uri.parse(Http_URL().get_user_info), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);


    //statusCode 확인해볼것
    if (res.statusCode == 200) {
      if(data['nickname'] == null){
        return null;
      }
      _gilog_user = Gilog_User.fromJson(data);
      notifyListeners();
      return _gilog_user;
    }
    if (res.statusCode == 403) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: Login_Screen()));
    } else {
      return null;
    }
    notifyListeners();
  }

  //http 사용자 정보 수정
  post_user_info(token, name, age, gender, context) async {


    if(gender == "비공개"){
      gender = "비공";
    }

    var res = await http.post(Uri.parse(Http_URL().post_user_info),
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
      return "data";
    }
    if (res.statusCode == 403) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: Login_Screen()));
      return null;
    } else {
      return null;
    }
  }

  //http 사용자 정보 수정
  Future<Gilog_User?> post_edit_user(token, name, age, gender, context) async {
    var res = await http.post(Uri.parse(Http_URL().get_user_info),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'nickname': name, 'age': age, 'gender': gender}));

    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);
    print(data);

    //statusCode 확인해볼것
    if (res.statusCode == 200) {
      _gilog_user = Gilog_User.fromJson(data);
      notifyListeners();
      return _gilog_user;
    }
    if (res.statusCode == 403) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: Login_Screen()));
    } else {
      return null;
    }
  }
}
