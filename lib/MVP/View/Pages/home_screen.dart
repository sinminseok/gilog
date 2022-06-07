import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gilog/MVP/View/Pages/Post/post_write.dart';
import 'package:gilog/Utils/check_datetime.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import '../../../Utils/datetime.dart';
import '../../../Utils/permission.dart';
import 'Widgets/top_widget.dart';
import 'package:image_picker/image_picker.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

  String? today;
  TextEditingController _content_controller = TextEditingController();
  PickedFile? _image;

  @override
  void initState() {
    // TODO: implement initState
    today = getToday();
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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Top_Widget(),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "${today}",
                style: TextStyle(
                    fontSize: 32,
                    fontFamily: "Numberfont",
                    fontWeight: FontWeight.bold),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "오늘의 기-록",
                style: TextStyle(fontSize: 32, fontFamily: "Gilogfont"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.height * 0.4,
                height: size.height * 0.4,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white12,
                        style: BorderStyle.solid,
                        width: 0),
                    color: Colors.white),
                child: Center(
                  child: _image == null
                      ? Image.asset(
                          "assets/images/gi_icon.png",
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
            InkWell(
              onTap: (){
                Check_Datetime().check_Today();
              },
              child: Text("TEST"),
            ),


            InkWell(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                        height: size.height * 0.4,
                        color: Colors.white12,
                        child: TextFormField(

                          controller: _content_controller,
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 5, bottom: 5, top: 5, right: 5),
                              hintText: '...여기에 내용을 기록해보세요!'),
                          minLines: 1,
                          maxLines: 5,
                          maxLengthEnforced: true,
                        ));
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 3),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                width: size.width * 0.9,
                height: size.height * 0.1,
                child: Center(
                    child: Text(
                  "오늘 하늘은 어땠나요?",
                  style: TextStyle(
                      fontFamily: "gilogfont",
                      fontSize: 21,
                      color: Colors.black),
                )),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            InkWell(onTap: () {}, child: Text("새로운 질문을 만들래요")),
          ],
        ),
      ),
    );
  }
}
