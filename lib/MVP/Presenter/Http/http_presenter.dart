import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/Utils/http_url.dart';
import 'package:gilog/Utils/toast.dart';
import 'package:http/http.dart' as http;

class Http_Presenter with ChangeNotifier {
  Future<void> kakao_login_http() async {}

  //http post
  Future post_gilog(id, datetime, imageFile, content, question) async {
    //pumbId 는 노르딕에서 가져오는 것 (메모리 할당)
    //url 로 post(이메일 컨트롤러 , 패스워드 컨트롤러)
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    var res = await http.post(
      Uri.parse(Http_URL().post_gilog_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, // this header is essential to send json data
      body: jsonEncode([
        {'image': '$base64Image'}
      ]),
    );

    if (res.statusCode == 200) {
      showtoast("기-록 되었습니다");
      return res;
    } else {
      showtoast("예상치 못한 오류로 기록되지 않았습니다.");
      return null;
    }
  }
}
