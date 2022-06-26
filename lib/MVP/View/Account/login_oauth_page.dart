import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/platform_interface.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Pages/frame.dart';
import 'login.dart';

class Login_Oauth_Screen extends StatefulWidget {
  const Login_Oauth_Screen({Key? key}) : super(key: key);

  @override
  _Login_Oauth_Screen createState() => _Login_Oauth_Screen();
}

class _Login_Oauth_Screen extends State<Login_Oauth_Screen> {
// WebViewController를 선언합니다.
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(

        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //색변경
        ),
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
                  style: TextStyle(
                      fontSize: 52,
                      color: Colors.black,
                      fontFamily: "Gilogfont"),
                )),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Text(
                  "나만의 추억 장소",
                  style: TextStyle(
                      fontSize: 21,
                      color: Colors.black,
                      fontFamily: "Gilogfont"),
                ),
                SizedBox(
                  height: size.height * 0.35,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: InkWell(
                    onTap: () async {
                      const String _REST_API_KEY =
                          "ee4ee61f1ea69f5a8d5f5924343083f7";

                      const String _REDIRECT =
                          "http://ec2-3-39-195-205.ap-northeast-2.compute.amazonaws.com:8080/api/oauth2/code/kakao";

                      final _host = "https://kauth.kakao.com";
                      final _url =
                          "/oauth/authorize?client_id=${_REST_API_KEY}&redirect_uri=${_REDIRECT}&response_type=code";

                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Scaffold(
                                appBar: AppBar(

                                  backgroundColor: kPrimaryColor,
                                  elevation: 0,
                                  iconTheme: IconThemeData(
                                    color: Colors.black, //색변경
                                  ),
                                ),
                                body: WebView(
                                  javascriptMode: JavascriptMode.unrestricted,
                                  initialUrl: _host + _url,
                                  onWebViewCreated:
                                      (WebViewController webviewController){
                                    _controller = webviewController;
                                    },
                                  javascriptChannels: Set.from([
                                    JavascriptChannel(
                                        name: "JavaScriptChannel",
                                        onMessageReceived:
                                            (JavascriptMessage result) {
                                          print(result.message);

                                          if (result.message != null) {

                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Frame_Screen(Login_method: 'kakao',)),
                                                    (Route r) => false);
                                            return;
                                          }
                                          Navigator.of(context).pop();
                                          return;
                                        }),
                                  ]),
                                ),
                              )));
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
                            style: TextStyle(
                                fontSize: 21,
                                color: Colors.black,
                                fontFamily: "Gilogfont"),
                          )),
                          SizedBox(
                            width: size.width * 0.03,
                          )
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
                              width: size.width * 0.1,
                              child:
                                  Image.asset("assets/images/apple_logo.png")),
                          Center(
                              child: Text(
                            "Apple로 시작하기",
                            style: TextStyle(
                                fontSize: 21,
                                color: Colors.black,
                                fontFamily: "Gilogfont"),
                          )),
                          SizedBox(
                            width: size.width * 0.04,
                          )
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
