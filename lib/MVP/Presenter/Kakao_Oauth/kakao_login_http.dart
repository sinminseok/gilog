
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Model/user.dart';

class Kakao_User_Http with ChangeNotifier{
  //로그인후 반환할 user 객체
  Gilog_Model? _gilog_model;

  Gilog_Model? get gilog_model => _gilog_model;

  //http 로그인
  Future<Gilog_Model?> kakao_login(id) async {
    //url 로 post(이메일 컨트롤러 , 패스워드 컨트롤러)
    var res = await http.post(Uri.parse(""),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': id}));


    //정상 로그인 http statuscode 200
    if (res.statusCode == 200) {
      var gilog_user_kakao = Gilog_Model.fromJson(json.decode(res.body));
      return gilog_user_kakao;
    }else{
      return null;
    }

    }





  }