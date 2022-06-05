import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../Utils/constants.dart';
import '../../../Utils/toast.dart';
import '../../Presenter/Kakao_Oauth/kakao_login_presenter.dart';
import '../../Presenter/Kakao_Oauth/kakao_login.dart';
import '../Pages/frame.dart';
import 'login_oauth_page.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final viewModel = Kakao_User_ViewModel(KakaoLogin());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Center(
                      child: Text(
                    "기 - log",
                    style: TextStyle(fontSize: 52, fontFamily: "Mainfont"),
                  )),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Text("나만의 추억 장소"),
                  SizedBox(
                    height: size.height * 0.35,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: Frame_Screen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 3),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      width: size.width * 0.5,
                      height: size.height * 0.07,
                      child: Center(
                          child: Text(
                        "저번에 왔어요!",
                        style: TextStyle(color: Colors.black),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: Login_Oauth_Screen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black),
                        width: size.width * 0.5,
                        height: size.height * 0.07,
                        child: Center(
                            child: Text(
                          "새로왔어요!",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.12,),
                  Text("@copyright 2022 by comumu",style: TextStyle(color: Colors.grey),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void get_info()async{
    print(viewModel.user!.kakaoAccount!.name);
  }
}

