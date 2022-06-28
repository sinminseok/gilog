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

import '../../Model/user.dart';

class Http_Presenter with ChangeNotifier {
  Gilog_User? _gilog_user;

  Gilog_User? get gilog_user => _gilog_user;

  read_token() async {
    final prefs = await SharedPreferences.getInstance();

// counter 키에 해당하는 데이터 읽기를 시도합니다. 만약 존재하지 않는 다면 0을 반환합니다.
    final token = prefs.getString('token');

    return token;
  }

  //http post
  Future post_gilog(datetime, File imageFile, content, question, token) async {
    var request =
        new http.MultipartRequest("POST", Uri.parse(Http_URL().post_gilog));

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    request.headers.addAll(headers);

    request.fields['datetime'] = datetime;
    request.fields['content'] = content;
    request.fields['question'] = question;

    request.files
        .add(await http.MultipartFile.fromPath('imageFile', imageFile.path));

    var response = await request.send();

    print(response);
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

    //statusCode 확인해볼것
    if (res.statusCode == 200) {
      question = Question.fromJson(data);

      print(question.question);

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

    //statusCode 확인해볼것
    if (res.statusCode == 200) {
      _gilog_user = Gilog_User.fromJson(data);
      notifyListeners();
      return _gilog_user;
    } else {
      return null;
    }
  }
}
