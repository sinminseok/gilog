

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../Utils/constants.dart';
import '../../Account/start_setting_profile .dart';

class Setting_Profile extends StatefulWidget {
  const Setting_Profile({Key? key}) : super(key: key);

  @override
  _Setting_ProfileState createState() => _Setting_ProfileState();
}

class _Setting_ProfileState extends State<Setting_Profile> {

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _name_controller = TextEditingController();
  final TextEditingController _age_controller = TextEditingController();

  PickedFile? _image;


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
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: InkWell(
          onTap: (){
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeftWithFade, child: Profile_Setting(login_method: 'kakao',)));
          },
          child: Text(
            "프로필 수정",
            style: TextStyle(color: Colors.black, fontFamily: "gilogfont"),
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //색변경
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height*0.07,),

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
                        child: _image == null ?CircleAvatar(
                      backgroundColor: kProfileColor,
                      radius: 75,
                      backgroundImage:AssetImage('assets/images/user_img.png')):CircleAvatar(
                            backgroundColor: kProfileColor,
                            radius: 75,
                            backgroundImage:FileImage(File(_image!.path))),
                      ),
                      //AssetImage('assets/images/user_img.png')),
                      Column(
                        children: [
                          SizedBox(height: size.height*0.1,),
                          Row(

                            children: [
                              SizedBox(width: size.width*0.57,),
                              InkWell(
                                  onTap: (){
                                    getImageFromGallery();
                                  },
                                  child: Container(
                                      width: size.width*0.13,
                                      height: size.height*0.13,
                                      decoration: BoxDecoration(
                                        color: kIconColor,
                                        shape: BoxShape.circle
                                      ),
                                      child: Icon(Icons.camera_alt,size: 38,color: kPrimaryColor,))),
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
                      width: size.width*0.7,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '회원 이름',
                          hintText: '이름을 입력하세요!',
                          labelStyle: TextStyle(color: Colors.purple),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.purple),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.purple),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width*0.7,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '닉네임',
                          hintText: '닉네임을 입력해주세요!',
                          labelStyle: TextStyle(color: Colors.purple),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.purple),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.purple),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width*0.7,
                      child: DropdownButtonFormField<String?>(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.purple),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.purple),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          labelText: '성별',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        // underline: Container(height: 1.4, color: Color(0xffc0c0c0)),
                        onChanged: (String? newValue) {
                          print(newValue);
                        },
                        items:
                        [null, 'M', 'F'].map<DropdownMenuItem<String?>>((String? i) {
                          return DropdownMenuItem<String?>(
                            value: i,
                            child: Text({'M': '남성', 'F': '여성'}[i] ?? '비공개'),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width*0.7,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '나이',
                          hintText: '나이를 입력해주세요',
                          labelStyle: TextStyle(color: Colors.purple),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.purple),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.purple),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),

                 SizedBox(height: size.height*0.1,),
                  InkWell(
                    onTap: () {

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.purple),
                      width: size.width * 0.7,
                      height: size.height * 0.06,
                      child: Center(
                          child: Text(
                            "수정 하기",
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
