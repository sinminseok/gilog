import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/Local_DB/db.dart';
import 'package:gilog/MVP/Model/post.dart';
import 'package:gilog/MVP/View/Pages/frame.dart';
import 'package:gilog/MVP/View/Pages/home_screen.dart';
import 'package:gilog/Utils/calendar_utils/datetime.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:gilog/Utils/toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class Post_Write extends StatefulWidget {
  String? question;
  Uint8List? image_url;

  Post_Write({required this.question, this.image_url});

  @override
  _Post_WriteState createState() => _Post_WriteState();
}

class _Post_WriteState extends State<Post_Write> {
  TextEditingController _content_controller = TextEditingController();
  var datetime;
  var check_id;

  @override
  void initState() {
    datetime = DateTime.now().toString().substring(0, 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //색변경
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    child: Text("${widget.question}"),
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Container(
              width: size.width * 1,
              child: Center(
                  child: Text(
                "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                style: TextStyle(color: Colors.grey),
              )),
            ),
            SizedBox(
              height: size.height * 0.25,
              child: TextFormField(
                //
                controller: _content_controller,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 5, bottom: 5, top: 5, right: 5),
                    hintText: '...여기에 내용을 기록해보세요!'),
                minLines: 1,
                maxLines: 5,
                maxLengthEnforced: true,
              ),
            ),
            SizedBox(
              height: size.height * 0.14,
            ),
            InkWell(
              onTap: () async {
                if (_content_controller.text == "") {
                  return showtoast("내용을 입력해주세요");
                } else {
                  savedb();
                  showtoast("기-록 되었습니다");
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: Frame_Screen()));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.purple),
                width: size.width * 0.7,
                height: size.height * 0.06,
                child: Center(
                    child: Text(
                  "기-록하기",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "numberfont",
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ],
        ),
      ),
    );
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

  Future<void> savedb() async {
    DBHelper sd = DBHelper();
    sd.database;
    check_id_fun();

    var fido = POST(
      id: check_id,
      question: widget.question,
      datetime: datetime,
      content: _content_controller.text,
      image_url: widget.image_url,
    );

    await sd.insertPOST(fido);
  }
}
