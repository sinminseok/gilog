import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/Model/question.dart';
import 'package:gilog/Utils/http_url.dart';
import 'package:gilog/Utils/toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Http_Presenter with ChangeNotifier {

  read_token()async{
    final prefs = await SharedPreferences.getInstance();

// counter 키에 해당하는 데이터 읽기를 시도합니다. 만약 존재하지 않는 다면 0을 반환합니다.
    final token = prefs.getString('token');

    return token;
  }
  //http post
  Future post_gilog(id, datetime, imageFile, content, question,token) async {
    //pumbId 는 노르딕에서 가져오는 것 (메모리 할당)
    //url 로 post(이메일 컨트롤러 , 패스워드 컨트롤러)
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    var res = await http.post(
      Uri.parse(Http_URL().post_gilog),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
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

  //http userinformation 가져오기
  Future<Question?> get_question(token) async {
    Question? question;
    print(token);

    var res = await http.get(Uri.parse(Http_URL().get_question), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });


    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);
    print(data);



    //statusCode 확인해볼것
    if (res.statusCode == 200) {

      question = Question.fromJson(data);

      print(question.question);

      return question;
    } else {
      return null;
    }
  }
}
