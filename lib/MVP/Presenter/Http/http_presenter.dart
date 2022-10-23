import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:gilog/Local_DB/Utility.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/Model/question.dart';
import 'package:gilog/Utils/deliver_item_widget.dart';
import 'package:gilog/Utils/http_url.dart';
import 'package:gilog/Utils/toast.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../../../Local_DB/db.dart';
import '../../Model/deliver_item.dart';
import '../../Model/deliver_list_item.dart';
import '../../Model/post.dart';
import '../../Model/user.dart';
import '../../View/Account/login.dart';

class Http_Presenter with ChangeNotifier {
//
  var check_id;
  post_apple_token(identityToken, authorizationCode) async {

    var res = await http.post(
      Uri.parse(Http_URL().post_apple_token_url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'social-token': '$identityToken',
      },
    );

    //statusCode 확인해볼것
    if (res.statusCode == 200) {
      return res.body;
    } else {
      return null;
    }
  }

  get_server_image2(token,context)async{

    List? img_list_data = [];
    var res = await http.get(Uri.parse(Http_URL().get_server_data), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);


    for(int i=0;i<data.length;i++){

        // final http.Response responseData = await http.get(Uri.parse("http://ec2-43-200-33-232.ap-northeast-2.compute.amazonaws.com:8080/api/gi-log/image/${data[i]['image']}"), headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // });
        img_list_data.add(data[i]['image']);

    }


    return img_list_data;

  }

  get_server_image(token,context,month,year)async{
    List img_list_data =[];
    String this_month = month.toString();


    var res = await http.get(Uri.parse(Http_URL().get_server_data), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);



    if(this_month.toString().length == 1){
      this_month = "0"+month.toString();
    }


    for(int i=0;i<data.length;i++){


      if(data[i]["writeDate"].substring(5,7) == this_month && data[i]["writeDate"].substring(0,4) == year.toString() ){
        img_list_data.add(data[i]['image']);

      }

    }
    print(img_list_data);

    return img_list_data;

  }
  get_server_data2(token,context)async{

    var res = await http.get(Uri.parse(Http_URL().get_server_data), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);
    print(data);
    print("datadatadata");


    for(int i=0;i<data.length;i++){
      print(data[i]);
      print("check_id");




    }

  }

  get_server_data(token,context)async{

    var res = await http.get(Uri.parse(Http_URL().get_server_data), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);
    print(data);
    print("datadatadata");

    for(int i=0;i<data.length;i++){
      print(data[i]['writeDate']);
    }


    for(int i=0;i<data.length;i++){
      print(check_id);
      print("check_id");

      var return_id = await check_id_fun();

      var fido = POST(
          id: return_id,
          question: data[i]['question'],
          datetime: data[i]['writeDate'],
          content: data[i]['request'],
          image_url:"data"
      );



      DBHelper sd = DBHelper();
      //일단 지워보고 추후 다시 리백
      sd.database;
      await sd.insertPOST(fido);
    }

  }

   check_id_fun() async {
    final prefs = await SharedPreferences.getInstance();
    check_id = prefs.getInt('id');

    if (check_id == null) {
      check_id = 1;
       prefs.setInt('id', check_id);
       return check_id;

    } else {
      check_id += 1;
      prefs.remove('id');
      prefs.setInt('id', check_id);
      return check_id;
    }
  }

  set_token(String token) async {
    // shared preferences 얻기
    final prefs = await SharedPreferences.getInstance();
    final before_token = prefs.getString('token');

    if (before_token == null) {
      prefs.setString('token', token);
    } else {
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

  break_token() async {
    final prefs = await SharedPreferences.getInstance();

// counter 키에 해당하는 데이터 읽기를 시도합니다. 만약 존재하지 않는 다면 0을 반환합니다.
    final returntoken =await prefs.remove('token');


    if (returntoken != null) {
      return true;
    } else {
      return false;
    }
  }

  //기록 등록
  Future<bool> post_gilog_imageData(File? imageFile, id, token, context) async {
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

    print("이미지 변경 서버전송");
    print(response.statusCode);

    if (response.statusCode == 200) {
      showtoast("기록 되었습니다!");
      return true;
    }
    if (response.statusCode == 403) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: Login_Screen()));

      return false;
    } else {
      return false;
    }
  }

  //
  Future post_gilog_data(datetime, content, question, token, context) async {

    var res = await http.post(Uri.parse(Http_URL().post_gilog),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(
            {'writeDate': datetime, 'request': content, 'question': question}));

    //statusCode 확인해볼것
    print(res.body);
    print("GGG");
    if (res.statusCode == 200) {
      return res.body;
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

  Future post_update_gilog(datetime, content, question, token, context) async {


    var res = await http.post(Uri.parse(Http_URL().update_gilog),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(
            {'writeDate': datetime, 'request': content, 'question': question}));

    print("FGASGFASG");
    print(res.body);

    //statusCode 확인해볼것

    if (res.statusCode == 200) {
      return res.body;
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

  //http userinformation 가져오기
  Future<Question?> get_question(token, context) async {
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
      return question;
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
