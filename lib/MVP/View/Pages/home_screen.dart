import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:gilog/Local_DB/Utility.dart';
import 'package:gilog/MVP/Presenter/image_controller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/Model/question.dart';
import 'package:gilog/MVP/View/Pages/Post/post_write.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:gilog/Utils/toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/calendar_utils/check_datetime.dart';
import '../../../Utils/calendar_utils/datetime.dart';
import '../../../Utils/permission.dart';
import 'dart:math' as math;
import 'package:image_picker/image_picker.dart';
import 'package:network_handler/network_handler.dart';
import '../../Presenter/Http/http_presenter.dart';
import 'package:cached_network_image/cached_network_image.dart';


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
  File? file;
  bool bottom_sheet_controller = false;
  var imim;
  String? question_disk;
  Future? myFuture;
  double degrees = 90;
  String? token;
  var ttt;

  @override
  void initState() {
    // TODO: implement initState

    today = getToday();
    myFuture = read_today_question();
    super.initState();
  }




  @override
  void dispose(){
    //token = null;
    print("dispose homescreen");
    _question_controller.dispose();
    _image = null;
    today = null;
    myFuture = null;
    super.dispose();
  }





  read_today_question() async {
    token = await Http_Presenter().read_token();
    var check = await Check_Datetime().check_Today();

    final prefs = await SharedPreferences.getInstance();

    if (check == "notchange") {
      print("not change");
      // counter 키에 해당하는 데이터 읽기를 시도합니다. 만약 존재하지 않는 다면 0을 반환합니다.
      question_disk = prefs.getString('question');

      if (question_disk == null) {
        question_disk = "질문을 만들어보세요!";
        return question_disk;
      } else {
        return question_disk;
      }
    } else {
      print("date change$token");
      //원래 있던 질문 삭제(어제 질문)
      prefs.remove('question');
      //디스크에 question 저장
      http_get_question = await Http_Presenter().get_question(token, context);

      print("http_get_question");
      print(http_get_question);

      if (http_get_question == null) {
        prefs.setString('question', http_get_question!.question!);
        question_disk = "질문을 만들어보세요!";
        return question_disk;
      } else {
        prefs.setString('question', http_get_question!.question!);
        question_disk = http_get_question!.question;
        return question_disk;
      }
    }

    return check;
  }
  Uint8List? image_test;
  var image_picked;
  //이미지 선택 함수
  Future getImageFromGallery() async {
    // for gallery
     image_picked =
    await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if(mounted){
      setState(() {
        _image = image_picked!;
      });
    }

    imim = convert_img();

  }
  ttttt(strURL)async{
    final http.Response responseData = await http.get(Uri.parse(strURL));
    var uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/img').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    print(file.runtimeType);
    convert_img2(file);
    print("filefile");
  }

  //이미지 Uint8 변환 함수
  convert_img() async {
    Uint8List test = await _image!.readAsBytes();
    imim = test;
    return test;
  }
  Uint8List? test;

  convert_img2(_image) async {
     test = await _image!.readAsBytes();
    print(test);

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Image(image: CachedNetworkImageProvider(
                    //     "http://ec2-43-200-33-232.ap-northeast-2.compute.amazonaws.com:8080/api/gi-log/image/20220718105524162.jpg",
                    //     headers: {"Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyMjcwMDc2OTAxIiwicm9sZXMiOiJVU0VSIiwiaWF0IjoxNjY1NjgxMjczLCJleHAiOjE2NjU2ODMwNzN9.amNHZf86vDMqm6oPTuILXl0m1aW4USXITjrtp-sDOCc",
                    //       "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"}
                    //    ),
                    //   fit: BoxFit.cover,
                    //
                    // ),
                    SizedBox(height: size.height*0.08,),

                    Container(

                      child: Center(
                          child: Text(
                            "${today}",
                            style: TextStyle(
                              fontSize: 42,
                              fontFamily: "gilogfont",
                            ),
                          )),
                    ),
                    // FileImage("ÿØÿà"),

                    // image_test==null?Container():Container(
                    //   height: 240,
                    //   width: 240,
                    //   child: FittedBox(
                    //     fit: BoxFit.cover,
                    //     child: Image.as
                    //   ),
                    // ),


                    InkWell(
                      onTap: ()async{
                        var token =  await Http_Presenter().read_token();
                        Image_Controller().download(token);
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
                    SizedBox(height: size.height*0.03,),


                    Container(
                      height: size.height * 0.35,
                      width: size.width * 1,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white12,
                            style: BorderStyle.solid,
                            width: 0),
                      ),
                      child: Center(
                        child: image_picked == null
                            ? Image.asset(
                          "assets/images/photo_null_image.png",
                          width: size.width * 0.6,
                        )
                            : Container(
                          height: size.height*0.35,
                              width: size.width*0.7,
                              child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.file(
                              File(image_picked!.path),
                              fit: BoxFit.fitWidth,
                          ),
                        ),
                            ),
                      ),
                    ),
                    SizedBox(height: size.height*0.05,),



                    InkWell(
                      onTap: () async {

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
                            color: kButtonColor),
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
                      height: size.height * 0.03,
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
                                      image_file: File(_image!.path),
                                      image_url: Utility.base64String(File(_image!.path)!.readAsBytesSync()))));
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
                            height: size.height * 0.12,
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
                                      fontSize: 17,
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
                              height: size.height * 0.12,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                      "${question_disk}",
                                      style: TextStyle(
                                          fontFamily: "gilogfont",
                                          fontSize: 17,
                                          color: Colors.black),
                                    )),
                              ),
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
                                print(_question_controller.text);
                                setState(() {
                                  question_disk =
                                      _question_controller.text;
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
