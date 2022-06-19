import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/View/Pages/Post/post_write.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:gilog/Utils/toast.dart';
import 'package:page_transition/page_transition.dart';
import '../../../Utils/calendar_utils/datetime.dart';
import '../../../Utils/permission.dart';
import 'dart:math' as math;
import 'package:image_picker/image_picker.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  String? question = "오늘 하루는 어땠나요?";
  String? today;
  TextEditingController _question_controller = TextEditingController();
  PickedFile? _image;
  bool bottom_sheet_controller = false;
  var imim;

  double degrees = 90;


  @override
  void initState() {
    // TODO: implement initState
    today = getToday();
    Permission_handler().requestNotifcation(context);
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
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
                  style: TextStyle(fontSize: 30, fontFamily: "Gilogfont"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: size.height * 0.34,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white12,
                      style: BorderStyle.solid,
                      width: 0),
                ),
                child: Center(
                  child: _image == null
                      ? Image.asset(
                          "assets/images/gilog.png",
                          width: size.width * 0.6,
                        )
                      : Image.file(
                          File(_image!.path),
                          height: size.height * 0.5,
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: InkWell(
                onTap: () {
                  Permission_handler().requestCameraPermission(context);

                  getImageFromGallery();
                },
                child: Text(
                  "여기를 눌러 사진을 골라보세요!",
                  style: TextStyle(fontFamily: "Gilogfont", fontSize: 23),
                ),
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
                              question: '${question}', image_url: imim)));
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
                                  hintText: "${question}",
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
                                "${question}",
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
                              question = _question_controller.text;
                              bottom_sheet_controller =
                                  !bottom_sheet_controller;
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
        ),
      ),
    );
  }
}
