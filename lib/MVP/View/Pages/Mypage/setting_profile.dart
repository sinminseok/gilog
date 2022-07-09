import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../Local_DB/profile_local_db.dart';
import '../../../../Utils/constants.dart';
import '../../../Model/user.dart';
import '../../../Model/user_profile.dart';
import '../../../Presenter/Http/http_presenter.dart';
import '../../../Presenter/Http/user_http.dart';
import '../../Account/start_setting_profile .dart';

class Setting_Profile extends StatefulWidget {
  Gilog_User user;
  Setting_Profile({required this.user});

  @override
  _Setting_ProfileState createState() => _Setting_ProfileState();
}

class _Setting_ProfileState extends State<Setting_Profile> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _username_controller = TextEditingController();
  final TextEditingController _age_controller = TextEditingController();
  String? gender;
  var imim;

  PickedFile? _image;
  var data;

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

  convert_img() async {
    Uint8List test = await _image!.readAsBytes();
    imim = test;
    return test;
  }

  // local_data_filter_year() async {
  //   DB_USER_Helper sd = DB_USER_Helper();
  //   sd.database;
  //   data = await sd.user_img();
  //   if(data == null){
  //     return null;
  //   }else{
  //     return data;
  //   }
  //
  // }

  local_data_filter_year() async {
    print("ST");
    DB_USER_Helper sd = DB_USER_Helper();
    sd.database;
    data = await sd.user_img();
    print(data);
    if(data == null){
      return "notrelode";
    }else{
      return data;
    }

  }


  update_db() async {
    if (imim == null) {
      return;
    } else {
      if (data == null) {
        print("image insert");
        DB_USER_Helper sd = DB_USER_Helper();
        sd.database;

        var fido = User_profile_image(id: 1, profile_image: imim);

        print(fido);

        await sd.insertIMG(fido);
      } else {
        print("image update");
        DB_USER_Helper sd = DB_USER_Helper();
        sd.database;

        var fido = User_profile_image(
          id: 1,
          profile_image: imim,
        );

        await sd.updatePOST(fido);
      }
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    _username_controller.text = widget.user.nickname!;
    gender = widget.user.gender;
    _age_controller.text = widget.user.age.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // Gilog_User? user = Provider.of<User_Http>(context).gilog_user;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    child: Profile_Setting(
                      login_method: 'kakao',
                    )));
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
                            ? FutureBuilder(
                                future: local_data_filter_year(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState == false) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasData == false) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  //error가 발생하게 될 경우 반환하게 되는 부분
                                  else if (snapshot.hasError) {
                                    return Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator()),
                                    );
                                  } else {
                                    return data == null
                                        ? CircleAvatar(
                                            backgroundColor: kPrimaryColor,
                                            radius: 75.0,
                                            backgroundImage: AssetImage(
                                                'assets/images/user_img.png') //here
                                            )
                                        : CircleAvatar(
                                            radius: 75.0,
                                            backgroundImage: MemoryImage(
                                              data.profile_image,
                                            ), //here
                                          );
                                  }
                                },
                              )
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
                          labelText: '${widget.user.nickname}',
                          hintText: '이름을 입력하세요!',
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
                          print(newValue);
                          setState(() {
                            gender = newValue;
                          });
                        },
                        items: [null, 'M', 'F']
                            .map<DropdownMenuItem<String?>>((String? i) {
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
                      width: size.width * 0.7,
                      child: TextField(
                        controller: _age_controller,
                        decoration: InputDecoration(
                          labelText: '${widget.user.age}',
                          hintText: '나이를 입력해주세요',
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
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  InkWell(
                    onTap: () async {
                     update_db();

                     print(_username_controller.text);
                     print( _age_controller.text);
                     print(gender);



                      var token = await Http_Presenter().read_token();
                      await User_Http().post_user_info(
                          token,
                          _username_controller.text,
                          _age_controller.text,
                          gender,
                          context);
                      await Provider.of<User_Http>(context, listen: false)
                          .get_user_info(token, context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: kButtonColor),
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
