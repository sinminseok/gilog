import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../Utils/constants.dart';
import '../../../Utils/toast.dart';
import '../../Presenter/Kakao_Oauth/kakao_login_presenter.dart';
import '../../Presenter/Kakao_Oauth/kakao_login.dart';
import '../Pages/frame.dart';
import 'login.dart';

class Login_Oauth_Screen extends StatefulWidget {
  const Login_Oauth_Screen({Key? key}) : super(key: key);

  @override
  _Login_Oauth_Screen createState() => _Login_Oauth_Screen();
}

class _Login_Oauth_Screen extends State<Login_Oauth_Screen> {
  final viewModel = Kakao_User_ViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,//색변경
        ),
      ),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Center(
                      child: Text(
                    "기 - log",
                        style: TextStyle(fontSize:52,color: Colors.black,fontFamily: "Gilogfont"),
                  )),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text("나만의 추억 장소",style: TextStyle(fontSize:21,color: Colors.black,fontFamily: "Gilogfont"),),
                  SizedBox(
                    height: size.height * 0.35,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: InkWell(
                      onTap: () async {
                        var check_login;
                        check_login = await viewModel.login();
                        get_info();
                        if (check_login) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: Frame_Screen()));
                        } else {
                          showAlertDialog(context, "로그인 실패", "다시 로그인 해주세요!");

                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: Login_Screen()));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 1,

                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber),
                        width: size.width * 0.7,
                        height: size.height * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.chat_bubble),
                            ),
                            Center(
                                child: Text(
                              "카카오톡으로 시작하기",
                                  style: TextStyle(fontSize:21,color: Colors.black,fontFamily: "Gilogfont"),
                            )),
                            SizedBox(width: size.width*0.03,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: InkWell(
                      onTap: () async {},
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 1,

                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white12),
                        width: size.width * 0.7,
                        height: size.height * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            Container(
                                width: size.width*0.1,
                                  child: Image.asset(
                                      "assets/images/apple_logo.png")),


                            Center(
                                child: Text(
                              "Apple로 시작하기",
                                  style: TextStyle(fontSize:21,color: Colors.black,fontFamily: "Gilogfont"),
                            )),
                            SizedBox(width: size.width*0.04,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                  Text(
                    "@copyright 2022 by comumu",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),

    );
  }

  void get_info() async {
    print(viewModel.user!.kakaoAccount!.name);
  }
}
