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
  Uint8List? image_url;

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
    // TODO: implement dispose
    // check_today_WRITE == true ? print("이미 기록함 ㅅㄱ") : sub_controller_text();
    super.dispose();
  }

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
                width: size.width * 0.1,
              ),
              Text(
                datetime,
                style: TextStyle(
                    fontFamily: "gilogfont", fontSize: 32, color: Colors.black),
              ),
              SizedBox(
                width: size.width * 0.1,
              ),
              InkWell(
                onTap: () {
                  check_today_WRITE == true
                      ? print("이미 기록함 ㅅㄱ")
                      : sub_controller_text(context);
                },
                child: Container(
                  width: size.width * 0.2,
                  height: size.height * 0.045,
                  decoration: BoxDecoration(
                      color: kButtonColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                      child: Text(
                    "기록",
                    style:
                        TextStyle(fontFamily: "gilogfont", color: Colors.black),
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
                      child: Image.asset("assets/images/yellow_icon.psd")),
                ),
                Container(
                  width: size.width * 0.7,
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                      color: kProfileColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "${widget.question}",
                      style: TextStyle(fontFamily: "gilogfont", fontSize: 18),
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
    print(messages.length);

    if (messages.length == 0) {
      return showAlertDialog(context, "알림", "내용을 입력해주세요");
    } else {
      for (var i = 0; messages.length > i; i++) {
        test += "${messages[i].text}\n";
      }
      print(test);
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


    var token = await Http_Presenter().read_token();
    var return_value = await Http_Presenter()
        .post_test_gilog(datetime, final_text, widget.question, token,context);
    var check_return_bool =await Http_Presenter().post_gilog(widget.image_file, return_value, token,context);

    print("return_value$return_value");

    if(check_return_bool == true){
      DBHelper sd = DBHelper();
      sd.database;
      check_id_fun();

      var fido = POST(
        id: check_id,
        question: widget.question,
        datetime: datetime,
        content: final_text,
        image_url: widget.image_url,
      );

      await sd.insertPOST(fido);

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: Frame_Screen(Login_method: null,)));
    }else{
      showAlertDialog(context, "알림", "사진 용량이 너무 큽니다.");
    }


  }
}
