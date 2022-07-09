import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/Presenter/Http/http_presenter.dart';
import 'package:gilog/Utils/http_url.dart';
import 'package:gilog/Utils/toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Utils/constants.dart';
import '../../../Presenter/Http/user_http.dart';
import '../../Account/login.dart';

class Resign_Page extends StatefulWidget {
  const Resign_Page({Key? key}) : super(key: key);

  @override
  _Resign_PageState createState() => _Resign_PageState();
}

class _Resign_PageState extends State<Resign_Page> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "회원 탈퇴",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: kPrimaryColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //색변경
          ),
        ),
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("회원탈퇴 안내", style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: size.height*0.04,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width*0.92,
                    child: Text(
                        "지금 까지 기-log 서비스를 이용해 주셔서 감사합니다. \n 회원을 탈퇴하면 기-log서비스 내 나의 계정 정보 및 기록 내역이 삭제되고 복구할수 없습니다.")),
              ),
              SizedBox(height: size.height*0.03,),
              Row(
                children: [
                Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
                value: isChecked,
                shape: CircleBorder(),
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                    print(isChecked);
                  });
                },
              ),
                  Text("위 내용을 숙지 하였으며 동의합니다.")
                ],
              ),
              Center(
                child: InkWell(
                  onTap: ()async{

                    if(isChecked == true){
                      final prefs = await SharedPreferences.getInstance();
                      var login_metohd = prefs.getString("login_method");
                      print(login_metohd);
                      prefs.remove("login_method");
                      print(login_metohd);


                      var token = await Http_Presenter().read_token();
                      var return_value = await User_Http().resign(token, context);

                      await Http_Presenter().break_token();

                      showtoast("회원 탈퇴가 완료 되었습니다.");
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeftWithFade,
                              child: Login_Screen()));

                    }else{
                      showAlertDialog(context, "알림", "동의 항목을 선택해주세요");
                    }

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey),
                    width: size.width * 0.9,
                    height: size.height * 0.06,
                    child: Center(
                        child: Text(
                          "탈퇴 하기",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "numberfont",
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
