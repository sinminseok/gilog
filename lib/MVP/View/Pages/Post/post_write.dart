import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gilog/Local_DB/db.dart';
import 'package:gilog/MVP/Model/post.dart';
import 'package:gilog/MVP/Presenter/Http/http_presenter.dart';
import 'package:gilog/MVP/View/Pages/frame.dart';
import 'package:gilog/MVP/View/Pages/home_screen.dart';
import 'package:gilog/Utils/calendar_utils/datetime.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:gilog/Utils/toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../Model/message.dart';

class Post_Write extends StatefulWidget {
  String? question;
  File? image_file;
  String? image_url;

  Post_Write({required this.question, this.image_file, this.image_url});

  @override
  _Post_WriteState createState() => _Post_WriteState();
}

class _Post_WriteState extends State<Post_Write> {
  TextEditingController _content_controller = TextEditingController();
  var datetime;
  var check_id;
  String? final_text;
  bool check_today_WRITE = false;
  List<Messagge> messages = [];

  @override
  void initState() {
    datetime = DateTime.now().toString().substring(0, 10);
    print(datetime);
    chekc_today_write();
    super.initState();
  }

  List<String?> has_data_all_POST = [];

  chekc_today_write() async {
    DBHelper sd = DBHelper();
    sd.database;
    var data = await sd.posts();

    for (var i = 0; i < data.length; i++) {
      if (data[i].datetime == datetime) {
        setState(() {
          check_today_WRITE = true;
        });
      }
    }
  }

  @override
  void dispose() {
    datetime = null;
    _content_controller.dispose();
    messages = [];
    check_id = null;

    // TODO: implement dispose
    // check_today_WRITE == true ? print("이미 기록함 ㅅㄱ") : sub_controller_text();
    super.dispose();
  }

  bool? onTapPressed = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.03,
              ),
              InkWell(
                onTap: (){
                  print(datetime);
                },
                child: Text(
                  datetime,
                  style: TextStyle(
                      fontFamily: "gilogfont", fontSize: 28, color: Colors.black),
                ),
              ),
              SizedBox(
                width: size.width * 0.13,
              ),
              InkWell(
                onTap: () {
                  sub_controller_text(context);
                  // check_today_WRITE == true
                  //     ? showtoast("오늘은 이미 기록했습니다!")
                  //     : sub_controller_text(context);
                },
                child: Container(
                  width: size.width * 0.21,
                  height: size.height * 0.045,
                  decoration: BoxDecoration(
                      color: kButtonColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                      child: Text(
                    "기록 완료",
                    style: TextStyle(
                        fontFamily: "gilogfont",
                        color: Colors.black,
                        fontSize: 17),
                  )),
                ),
              )
            ],
          ),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //색변경
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: size.width * 0.15,
                      child: Image.asset("assets/images/smile_png.png")),
                ),
                Container(
                  width: size.width * 0.7,
                  height: size.height * 0.15,
                  decoration: BoxDecoration(
                      color: kProfileColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "${widget.question}",
                        style: TextStyle(fontFamily: "gilogfont", fontSize: 17),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Expanded(
                child: GroupedListView<Messagge, DateTime>(
              padding: const EdgeInsets.all(8),
              elements: messages,
              groupBy: (messages) => DateTime(2022),
              groupHeaderBuilder: (Messagge message) => SizedBox(),
              itemBuilder: (context, Messagge message) => Align(
                alignment: message.isSentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 0.6,
                    decoration: BoxDecoration(
                        color: kProfileColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "${message.text}",
                          style:
                              TextStyle(fontFamily: "gilogfont", fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
            Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
                height: size.height * 0.08,
                child: TextField(
                  maxLines: 10,
                  textInputAction: TextInputAction.done,
                  controller: _content_controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20, top: 20),
                    hintText: "내용을 입력하세요",
                    hintStyle: TextStyle(fontFamily: "gilogfont", fontSize: 21),
                    border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 10),
                      child: IconButton(
                        onPressed: () {
                          chekc_today_write();
                          if (check_today_WRITE == true) {
                            showtoast("기록은 하루에 한번만 할 수 있습니다!");
                          } else {
                            if (_content_controller.text == "") {
                              showtoast("내용을 입력해주세요");
                            } else {
                              final message = Messagge(
                                  text: _content_controller.text,
                                  isSentByMe: true);
                              setState(() {
                                messages.add(message);
                                _content_controller.clear();
                                FocusScope.of(context).unfocus();
                              });
                            }
                          }
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        ));
  }

  void sub_controller_text(context) {

    String test = "";

    if (messages.length == 0) {
      return showAlertDialog(context, "알림", "내용을 입력해주세요");
    } else {
      for (var i = 0; messages.length > i; i++) {
        test += "${messages[i].text}\n";
      }

      final_text = test;
      savedb(context);
    }
  }

  void check_id_fun() async {
    final prefs = await SharedPreferences.getInstance();
    check_id = prefs.getInt('id');

    if (check_id == null) {
      check_id = 1;
      prefs.setInt('id', check_id);
    } else {
      check_id += 1;
      prefs.remove('id');
      prefs.setInt('id', check_id);
    }
  }

  Future<void> savedb(BuildContext context) async {
    //토큰 가져옴
    var token = await Http_Presenter().read_token();
    //return value로 받아온 값을 담아 다음 요청에 이미지와 함께 보냄 영솔이가 이렇게 보내라함 난 모름 ㅋㅋ
    var return_value = await Http_Presenter()
        .post_gilog_data(datetime, final_text, widget.question, token, context);
    if(return_value == null){
       showtoast("오늘 이미 기록했습니다");
    }
    var check_return_bool = await Http_Presenter()
        .post_gilog_imageData(widget.image_file, return_value, token, context);
    if (check_return_bool == true) {

      DBHelper sd = DBHelper();
      //일단 지워보고 추후 다시 리백
      sd.database;

      check_id_fun();

      var fido = POST(
        id: check_id,
        question: widget.question,
        datetime: datetime,
        content: final_text,
        image_url: "data",
      );

     await sd.insertPOST(fido);

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: Frame_Screen(
                Login_method: null,
              )));
    } else {
      showAlertDialog(context, "알림", "사진 용량이 너무 큽니다.");
    }
  }
}
