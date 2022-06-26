import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../Utils/calendar_utils/check_datetime.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/toast.dart';

import '../Pages/frame.dart';
import 'login_oauth_page.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    Check_Datetime().check_Today();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WebViewController? _controller;

    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
        ),
        backgroundColor: kPrimaryColor,
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
                    style: TextStyle(fontSize: 52, fontFamily: "Gilogfont"),
                  )),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                    "나만의 추억 장소",
                    style: TextStyle(fontSize: 21, fontFamily: "Gilogfont"),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Container(
                    width: size.width * 0.7,
                    child: Image.asset("assets/images/pencils_icon.png"),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  InkWell(
                    onTap: () async{
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: Frame_Screen(Login_method: null,)));

                    //   final prefs = await SharedPreferences.getInstance();
                    //   // counter 키에 해당하는 데이터 읽기를 시도합니다. 만약 존재하지 않는 다면 0을 반환합니다.
                    //   final login_check = prefs.getBool('kakao');
                    //   print(login_check);
                    //
                    //   if(login_check == null){
                    //     showtoast("소셜로그인을 진행해주세요");
                    //   }else{
                    //     const String _REST_API_KEY =
                    //         "ee4ee61f1ea69f5a8d5f5924343083f7";
                    //
                    //     const String _REDIRECT =
                    //         "http://ec2-3-39-195-205.ap-northeast-2.compute.amazonaws.com:8080/api/oauth2/code/kakao";
                    //
                    //     final _host = "https://kauth.kakao.com";
                    //     final _url =
                    //         "/oauth/authorize?client_id=${_REST_API_KEY}&redirect_uri=${_REDIRECT}&response_type=code";
                    //     await Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (BuildContext context) => Scaffold(
                    //
                    //           body: WebView(
                    //             javascriptMode: JavascriptMode.unrestricted,
                    //             initialUrl: _host + _url,
                    //             onWebViewCreated:
                    //                 (WebViewController webviewController){
                    //               _controller = webviewController;
                    //             },
                    //             javascriptChannels: Set.from([
                    //               JavascriptChannel(
                    //                   name: "JavaScriptChannel",
                    //                   onMessageReceived:
                    //                       (JavascriptMessage result) {
                    //                     print(result.message);
                    //
                    //                     if (result.message != null) {
                    //
                    //                       Navigator.of(context)
                    //                           .pushAndRemoveUntil(
                    //                           MaterialPageRoute(
                    //                               builder: (context) =>
                    //                                   Frame_Screen(Login_method: 'kakao',)),
                    //                               (Route r) => false);
                    //                       return;
                    //                     }
                    //                     Navigator.of(context).pop();
                    //                     return;
                    //                   }),
                    //             ]),
                    //           ),
                    //         )));
                    //   }
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
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.black,
                            fontFamily: "Gilogfont"),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: InkWell(
                      onTap: () {
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
                          style: TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                              fontFamily: "Gilogfont"),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                  Text(
                    "@copyright 2022 by Sso-young",
                    style: TextStyle(color: Colors.grey),
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
