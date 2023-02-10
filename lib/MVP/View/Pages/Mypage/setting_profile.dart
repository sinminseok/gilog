import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/Utils/toast.dart';
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


  local_data_filter_year() async {

    DB_USER_Helper sd = DB_USER_Helper();
    sd.database;
    data = await sd.user_img();

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
        DB_USER_Helper sd = DB_USER_Helper();
        sd.database;
        var fido = User_profile_image(id: 1, profile_image: imim);


        await sd.insertIMG(fido);
      } else {
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

  List<String> dropdownList = ['비공개','남자', '여자'];
  String? selectedDropdown;

  @override
  void initState() {
    // TODO: implement initState
    _username_controller.text = widget.user.nickname!;
    gender = widget.user.gender;

    //밑에 주석 코드가 초기 회원 성별 가져오는 로직 주석 지우면 초기 회원 성별 가져옴
    // if(gender == "M" || gender=="남자"){
    //   print("남자로 setstate");
    //   setState(() {
    //     selectedDropdown ="남자";
    //   });
    //
    // }if(gender == "F" || gender=="여자"){
    //   print("여자로 setstate");
    //   setState(() {
    //     selectedDropdown="여자";
    //   });
    //
    // }if(gender == "비공"){
    //   print("비공개");
    //   setState(() {
    //     selectedDropdown="비공개";
    //   });
    // }

    _age_controller.text = widget.user.age.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title:  Text(
          "프로필 수정",
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
                          labelText: '닉네임',
                          hintText: '닉네임을 입력하세요!',
                          labelStyle: TextStyle(color: kButtonColor),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: kButtonColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: kButtonColor),
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
                      decoration: BoxDecoration(
                        border: Border.all(color: kButtonColor),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      width: size.width * 0.7,
                      height: size.height*0.07,

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          isExpanded:true,
                          icon: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.keyboard_arrow_down_sharp),
                          ),

                          underline: SizedBox.shrink(),

                          value: selectedDropdown,
                          items: dropdownList.map((String item) {
                            return DropdownMenuItem<String>(


                              child: Text('$item'),
                              value: item,
                            );
                          }).toList(),
                          onChanged: (dynamic value) {
                            setState(() {
                              selectedDropdown = value;
                              gender = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),


                  SizedBox(
                    height: size.height * 0.24,
                  ),
                  InkWell(
                    onTap: () async {
                     update_db();

                      var token = await Http_Presenter().read_token();
                      var gg = await User_Http().post_user_info(
                          token,
                          _username_controller.text,
                          _age_controller.text,
                          gender,
                          context);
                      if(gg != null){
                        await Provider.of<User_Http>(context, listen: false)
                            .get_user_info(token, context);
                        Navigator.pop(context);
                        showtoast("수정 되었습니다");
                      }else{
                        showtoast("수정 실패");
                      }

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
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
