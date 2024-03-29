import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/View/Pages/frame.dart';
import 'package:gilog/Utils/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../Local_DB/db.dart';
import '../../../Local_DB/profile_local_db.dart';
import '../../../Utils/constants.dart';
import '../../Model/user_profile.dart';
import '../../Presenter/Http/http_presenter.dart';
import '../../Presenter/Http/user_http.dart';

class Profile_Setting extends StatefulWidget {
  String? login_method;

  Profile_Setting({required this.login_method});

  @override
  _Profile_SettingState createState() => _Profile_SettingState();
}

class _Profile_SettingState extends State<Profile_Setting> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _username_controller = TextEditingController();
  final TextEditingController _nickname_controller = TextEditingController();
  final TextEditingController _age_controller = TextEditingController();
  String? gender = "";

  PickedFile? _image;
  var imim;

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

  Future<void> savedb() async {
    DB_USER_Helper sd = DB_USER_Helper();
    sd.database;

    if (imim == null) {
      return;
    } else {
      var fido = User_profile_image(id: 1, profile_image: imim);

      print(fido);

      await sd.insertIMG(fido);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "프로필 설정",
          style: TextStyle(color: Colors.black, fontFamily: "gilogfont"),
        ),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //색변경
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: kPrimaryColor),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: _image == null
                            ? CircleAvatar(
                                backgroundColor: kProfileColor,
                                radius: 75,
                                backgroundImage:
                                    AssetImage('assets/images/user_img.png'))
                            : CircleAvatar(
                                backgroundColor: kProfileColor,
                                radius: 75,
                                backgroundImage: FileImage(File(_image!.path))),
                      ),
                      //AssetImage('assets/images/user_img.png')),
                      Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.57,
                              ),
                              InkWell(
                                  onTap: () {
                                    getImageFromGallery();
                                  },
                                  child: Container(
                                      width: size.width * 0.13,
                                      height: size.height * 0.13,
                                      decoration: BoxDecoration(
                                          color: kIconColor,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 38,
                                        color: kPrimaryColor,
                                      ))),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width * 0.7,
                      child: TextField(
                        controller: _username_controller,
                        decoration: InputDecoration(
                          labelText: '닉네임',
                          hintText: '어플에서 사용할 닉네임을 입력하세요!',
                          labelStyle: TextStyle(color: Colors.purple),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.purple),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.purple),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width * 0.7,
                      child: DropdownButtonFormField<String?>(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.purple),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.purple),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          labelText: '성별',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle:
                              TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        // underline: Container(height: 1.4, color: Color(0xffc0c0c0)),
                        onChanged: (String? newValue) {
                          setState(() {
                            gender = newValue;
                          });
                          print(newValue);
                        },
                        items: ["비공개", '남자', '여자']
                            .map<DropdownMenuItem<String?>>((String? i) {
                          return DropdownMenuItem<String?>(
                            value: i,
                            child: Text({'남자': '남성', '여자': '여성'}[i] ?? '비공개'),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.24,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_username_controller.text == "") {
                        print(_age_controller.text);

                        showtoast("정보를 모두 입력해주세요");
                      } else {
                        savedb();

                        var token = await Http_Presenter().read_token();
                        await User_Http().post_user_info(token,
                            _username_controller.text, 10, gender, context);
                        await Provider.of<User_Http>(context, listen: false)
                            .get_user_info(token, context);
                        //Http 회원 정보 등록

                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: Frame_Screen(
                                  Login_method: '${widget.login_method}',
                                )));
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
                        "완료",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "numberfont",
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
