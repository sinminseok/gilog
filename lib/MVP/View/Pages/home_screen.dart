import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/Model/question.dart';
import 'package:gilog/MVP/View/Pages/Post/post_write.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:gilog/Utils/toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/calendar_utils/check_datetime.dart';
import '../../../Utils/calendar_utils/datetime.dart';
import '../../../Utils/permission.dart';
import 'dart:math' as math;
import 'package:image_picker/image_picker.dart';

import '../../Presenter/Http/http_presenter.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  String? today;
  Question? http_get_question;
  Future<String?>? check_datetime_change;
  TextEditingController _question_controller = TextEditingController();
  PickedFile? _image;
  bool bottom_sheet_controller = false;
  var imim;
  String? question_disk;
  Future? myFuture;
  double degrees = 90;

  @override
  void initState() {
    // TODO: implement initState
    today = getToday();
    myFuture = read_today_question();

    super.initState();
  }

  read_today_question() async {

    String? token = await Http_Presenter().read_token();
    var check = await Check_Datetime().check_Today();

    final prefs = await SharedPreferences.getInstance();

    if (check == "notchange") {
      print("not change");
      // counter 키에 해당하는 데이터 읽기를 시도합니다. 만약 존재하지 않는 다면 0을 반환합니다.
      question_disk = prefs.getString('question');
      print(question_disk);
      if(question_disk == null){
        return "오늘 가장 생각났던 사람은 누구인가요?";
      }
      else{
        return question_disk;
      }

    } else {
      print("date change");
      //디스크에 question 저장
      http_get_question = await Http_Presenter().get_question(token);
      prefs.remove('question');
      prefs.setString('question', http_get_question!.question!);
      print(http_get_question!.question);
      question_disk = http_get_question!.question;
      return question_disk;
    }

    return check;
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: myFuture,
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
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        "${today}",
                        style: TextStyle(
                          fontSize: 42,
                          fontFamily: "gilogfont",
                        ),
                      )),
                    ),
                    InkWell(
                      onTap: () async {
                        await convert_img();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "오늘의 기-록",
                          style:
                              TextStyle(fontSize: 30, fontFamily: "Gilogfont"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: size.height * 0.34,
                        width: size.width * 1,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white12,
                              style: BorderStyle.solid,
                              width: 0),
                        ),
                        child: Center(
                          child: _image == null
                              ? Image.asset(
                                  "assets/images/photo_null_image.png",
                                  width: size.width * 0.6,
                                )
                              : Image.file(
                                  File(_image!.path),
                                  height: size.height * 0.34,
                                  width: size.width * 1,
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // var token = await Http_Presenter().read_token();
                        // print("FF$token");
                        // Http_Presenter().get_question(token);
                        Permission_handler().requestCameraPermission(context);
                        getImageFromGallery();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                            color: Colors.purple),
                        width: size.width * 0.3,
                        height: size.height * 0.05,
                        child: Center(
                            child: Text(
                          "사진 선택",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "numberfont",
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    InkWell(
                      onTap: () {
                        if (_image == null) {
                          showtoast("사진을 선택해주세요");
                        } else {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: Post_Write(
                                      question: '${question_disk}',
                                      image_url: imim)));
                        }
                      },
                      child: bottom_sheet_controller == true
                          ? InkWell(
                              onTap: () {},
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black,
                                          style: BorderStyle.solid,
                                          width: 3),
                                      borderRadius: BorderRadius.circular(10),
                                      color: kPrimaryColor),
                                  width: size.width * 0.9,
                                  height: size.height * 0.1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                          hintText: "${question_disk}",
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "gilogfont",
                                            fontSize: 21,
                                          )),
                                      controller: _question_controller,
                                    ),
                                  )),
                            )
                          : Stack(
                              children: [
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black,
                                            style: BorderStyle.solid,
                                            width: 3),
                                        borderRadius: BorderRadius.circular(10),
                                        color: kPrimaryColor),
                                    width: size.width * 0.9,
                                    height: size.height * 0.1,
                                    child: Center(
                                        child: Text(
                                      "${question_disk}",
                                      style: TextStyle(
                                          fontFamily: "gilogfont",
                                          fontSize: 21,
                                          color: Colors.black),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            bottom_sheet_controller = !bottom_sheet_controller;
                            print(bottom_sheet_controller);
                          });
                        },
                        child: bottom_sheet_controller == true
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_question_controller.text == "") {
                                      bottom_sheet_controller =
                                          !bottom_sheet_controller;
                                    } else {
                                      print(
                                          _question_controller.text);
                                      setState(() {
                                        question_disk = _question_controller.text;
                                        bottom_sheet_controller =
                                        !bottom_sheet_controller;
                                      });

                                    }
                                  });
                                },
                                child: Text(
                                  "질문 수정이 완료 되면 여기를 눌러주세요",
                                  style: TextStyle(
                                      fontFamily: "numberfont",
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Text(
                                "새로운 질문을 만들래요",
                                style: TextStyle(
                                    fontFamily: "numberfont",
                                    fontWeight: FontWeight.bold),
                              )),
                  ],
                );
              }
            }),
      ),
    );
  }
}
