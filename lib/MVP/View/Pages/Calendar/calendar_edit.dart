import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:math' as math;
import '../../../../Local_DB/Utility.dart';
import '../../../../Local_DB/db.dart';
import '../../../../Utils/constants.dart';
import '../../../../Utils/toast.dart';
import '../../../Model/post.dart';
import '../../../Presenter/Http/http_presenter.dart';
import 'calendar_detail.dart';

class Calendar_Edit extends StatefulWidget {
  int check;
  POST? this_post;
  String? date_time;
  var img_obj;
  List<POST?> remember_date_list = [];
  String? remember_datetime;
  int? remember_month;
  int? remember_year;

  Calendar_Edit(
      {required this.check,
      required this.img_obj,
      required this.this_post,
      required this.date_time,
      required this.remember_date_list,
      required this.remember_datetime,
      required this.remember_month,
      required this.remember_year});

  @override
  _Calendar_EditState createState() => _Calendar_EditState();
}

class _Calendar_EditState extends State<Calendar_Edit> {
  TextEditingController? _content_controller = TextEditingController();
  PickedFile? _image;
  double degrees = 90;
  var imim;
  Future? myfuture;
  var token;

  var image_picked;

  @override
  void initState() {
    myfuture = _init();

    //myfuture = _init();
    super.initState();
  }

  _init() async {
    _content_controller!.text = widget.this_post!.content!;
    token = await Http_Presenter().read_token();
    return token;
  }

  @override
  void dispose() {
    _content_controller!.dispose();
    super.dispose();
  }

  //이미지 선택 함수
  Future getImageFromGallery() async {
    // for gallery
    image_picked =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image_picked!;
    });
  }

  edit_void() async {
    var token = await Http_Presenter().read_token();

    if (_content_controller!.text == "") {
      return showtoast("내용을 입력해 주세요");
    }
    if (_image == null) {
      DBHelper sd = DBHelper();
      sd.database;

      var fido = POST(
        id: widget.this_post!.id,
        question: widget.this_post!.question,
        datetime: widget.this_post!.datetime,
        content: _content_controller!.text,
        image_url: "data",
      );

      await sd.updatePOST(fido);

      var return_value = await Http_Presenter().post_update_gilog(
          widget.this_post!.datetime,
          _content_controller!.text,
          widget.this_post!.question,
          token,
          context);

      if (return_value != null) {
        Navigator.pop(context);
        return;
      } else {

        return showtoast("수정 오류");
      }
    } else {
      DBHelper sd = DBHelper();
      sd.database;

      var fido = POST(
        id: widget.this_post!.id,
        question: widget.this_post!.question,
        datetime: widget.this_post!.datetime,
        content: _content_controller!.text,
        image_url: "data",
      );

      await sd.updatePOST(fido);

      var return_value = await Http_Presenter().post_update_gilog(
          widget.this_post!.datetime,
          _content_controller!.text,
          widget.this_post!.question,
          token,
          context);

      var check_return_bool = await Http_Presenter().post_gilog_imageData(
          File(_image!.path), return_value, token, context);

      // get_datetime_post();

      if (check_return_bool == true) {
        imim = null;
        _image = null;
        Navigator.pop(context);
        showtoast("수정 되었습니다");
      } else {
        showAlertDialog(context, "알림", "네트워크 오류");
      }
    }
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
          title: Row(
            children: [
              SizedBox(
                width: size.width * 0.54,
              ),
              InkWell(
                onTap: () {
                  edit_void();
                },
                child: Container(
                  width: size.width * 0.21,
                  height: size.height * 0.045,
                  decoration: BoxDecoration(
                      color: kButtonColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                      child: Text(
                    "수정 완료",
                    style: TextStyle(
                        fontFamily: "gilogfont",
                        color: Colors.black,
                        fontSize: 17),
                  )),
                ),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: myfuture,
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
                return SingleChildScrollView(
                    child: Column(
                  children: [
                    Text(
                      "${widget.date_time} 기-록",
                      style: TextStyle(fontFamily: "gilogfont", fontSize: 24),
                    ),
                    InkWell(
                        onTap: () {
                          getImageFromGallery();
                        },
                        child: _image != null
                            ? Container(
                                height: size.height * 0.55,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.file(
                                    // base64Decode(_image!.image_url.toString()),
                                    File(_image!.path),
                                    fit: BoxFit.fitHeight,

                                    // cacheWidth: size.width * 1 to ,
                                    // cacheHeight: size.height * 0.4,
                                  ),
                                ),
                              )
                            : Container(
                                height: size.height * 0.55,
                                child: Utility.networkimg_detail(
                                    widget.img_obj, token, size))),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
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
                                    "${widget.this_post!.question}",
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
                                      "assets/images/pencil_yellowpng.png"),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
                              width: size.width * 0.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: TextField(
                                      // textInputAction: TextInputAction.done,
                                      // onSubmitted: (_) =>
                                      //     FocusScope.of(context).nextFocus(),
                                      maxLines: 20,
                                      minLines: 2,
                                      controller: _content_controller,
                                      decoration: InputDecoration(
                                        hintText:
                                            "${widget.this_post!.content}",
                                        hintStyle: TextStyle(
                                            fontFamily: "gilogfont",
                                            fontSize: 20),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: size.width * 0.2,
                          )
                        ],
                      ),
                    ),
                  ],
                ));
              }
            }));
  }
}
