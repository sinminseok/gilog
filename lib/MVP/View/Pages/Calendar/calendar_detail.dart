import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/Model/post.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:gilog/Utils/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as math;

import '../../../../Local_DB/db.dart';
import '../../../Presenter/Http/http_presenter.dart';

class Calendar_detail extends StatefulWidget {
  String? date_time;

  Calendar_detail({required this.date_time});

  @override
  _Calendar_detailState createState() => _Calendar_detailState();
}

class _Calendar_detailState extends State<Calendar_detail> {
  POST? this_post;
  bool check_update = false;
  TextEditingController _content_controller = TextEditingController();

  PickedFile? _image;
  bool bottom_sheet_controller = false;
  var imim;

  @override
  void initState() {
    chekc_today_write();
    super.initState();
  }

  //이미지 선택 함수
  Future getImageFromGallery() async {
    // for gallery
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image!;
    });
    imim = convert_img();
  }

  //이미지 Uint8 변환 함수
  convert_img() async {
    Uint8List test = await _image!.readAsBytes();
    imim = test;
    return test;
  }

  chekc_today_write() async {
    DBHelper sd = DBHelper();
    sd.database;
    var data = await sd.posts();
    for (var i = 0; i < data.length; i++) {
      if (data[i].datetime == widget.date_time) {
        this_post = data[i];
      }
    }
    return this_post;
  }

  double degrees = 90;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: chekc_today_write(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == false) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData == false) {
              return Center(child: CircularProgressIndicator());
            }

            //error가 발생하게 될 경우 반환하게 되는 부분
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator()),
              );
            } else {
              return Column(
                children: [
                  Text(
                    "${widget.date_time} 기-록",
                    style: TextStyle(fontFamily: "gilogfont", fontSize: 24),
                  ),
                  check_update == true
                      ? InkWell(
                          onTap: () {
                            getImageFromGallery();
                          },
                          child: _image != null
                              ? Container(
                                  width: size.width * 1,
                                  height: size.height * 0.4,
                                  child: Image.file(File(_image!.path)))
                              : Container(
                                  width: size.width * 1,
                                  height: size.height * 0.4,
                                  child: Image.memory(
                                    this_post!.image_url as Uint8List,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                        )
                      : Container(
                          width: size.width * 1,
                          height: size.height * 0.4,
                          child: Image.memory(
                            this_post!.image_url as Uint8List,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                  InkWell(
                    onTap: () {
                      print(check_update);
                      setState(() {
                        check_update = !check_update;
                      });
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 3),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              width: size.width * 0.9,
                              height: size.height * 0.13,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 22.0, left: 20.0),
                                child: Center(
                                    child: Text(
                                  "${this_post!.question}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "gilogfont",
                                      fontSize: 18),
                                )),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: size.width * 0.88),
                            Transform.rotate(
                              angle: degrees * math.pi / -48,
                              child: Container(
                                width: size.width * 0.07,
                                child: Image.asset(
                                    "assets/images/yellow_pencil_icon.psd"),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  check_update == true
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                              width: size.width * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: TextField(
                                      maxLines: 5,
                                      controller: _content_controller,
                                      decoration: InputDecoration(
                                        hintText: "${this_post!.content}",
                                        hintStyle: TextStyle(
                                            fontFamily: "gilogfont",
                                            fontSize: 20),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                              width: size.width * 0.9,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${this_post!.content}",
                                      style: TextStyle(
                                          fontFamily: "gilogfont",
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                  check_update != true
                      ? Container()
                      : InkWell(
                          onTap: () async {
                            //(datetime, content, question, token, context

                            //아무런 변경이 없을때
                            if (_content_controller.text == "" &&
                                _image == null) {
                              setState(() {
                                check_update = !check_update;
                              });
                            } else {
                              var token = await Http_Presenter().read_token();
                              if(_image != null && _content_controller.text == ""){
                                var return_value = await Http_Presenter()
                                    .post_update_gilog(
                                    this_post!.datetime,
                                    this_post!.content,
                                    this_post!.question,
                                    token,
                                    context);

                                var check_return_bool = await Http_Presenter()
                                    .post_gilog_imageData(File(_image!.path),
                                    return_value, token, context);

                                if (check_return_bool == true) {
                                  DBHelper sd = DBHelper();
                                  sd.database;

                                  var fido = POST(
                                    id: this_post!.id,
                                    question: this_post!.question,
                                    datetime: this_post!.datetime,
                                    content: this_post!.content,
                                    image_url: imim,
                                  );

                                  await sd.updatePOST(fido);

                                  chekc_today_write();
                                } else {
                                  showAlertDialog(context, "알림", "네트워크 오류");
                                }

                                setState(() {
                                  check_update = !check_update;
                                });
                              }

                              //내용만 바뀌었을때
                              if (_image == null ) {
                                var return_value = await Http_Presenter()
                                    .post_update_gilog(
                                        this_post!.datetime,
                                        _content_controller.text,
                                        this_post!.question,
                                        token,
                                        context);

                                if (return_value != null) {
                                  DBHelper sd = DBHelper();
                                  sd.database;

                                  var fido = POST(
                                    id: this_post!.id,
                                    question: this_post!.question,
                                    datetime: this_post!.datetime,
                                    content: _content_controller.text,
                                    image_url: this_post!.image_url,
                                  );

                                  await sd.updatePOST(fido);

                                  chekc_today_write();
                                } else {
                                  showAlertDialog(context, "알림", "네트워크 오류");
                                }

                                setState(() {
                                  check_update = !check_update;
                                });
                              }
                              // 둘다 바뀌었을때 (사진 , 내용 )
                              else {


                                var return_value = await Http_Presenter()
                                    .post_update_gilog(
                                        this_post!.datetime,
                                        _content_controller.text,
                                        this_post!.question,
                                        token,
                                        context);

                                var check_return_bool = await Http_Presenter()
                                    .post_gilog_imageData(File(_image!.path),
                                        return_value, token, context);

                                if (check_return_bool == true) {
                                  DBHelper sd = DBHelper();
                                  sd.database;

                                  var fido = POST(
                                    id: this_post!.id,
                                    question: this_post!.question,
                                    datetime: this_post!.datetime,
                                    content: _content_controller.text,
                                    image_url: imim,
                                  );

                                  await sd.updatePOST(fido);

                                  chekc_today_write();
                                } else {
                                  showAlertDialog(context, "알림", "네트워크 오류");
                                }

                                setState(() {
                                  check_update = !check_update;
                                });
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                                color: kButtonColor),
                            width: size.width * 0.3,
                            height: size.height * 0.05,
                            child: Center(
                                child: Text(
                              "수정하기",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "numberfont",
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
