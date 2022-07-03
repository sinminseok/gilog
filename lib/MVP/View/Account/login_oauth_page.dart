import 'dart:async';
import 'dart:io' show Platform;
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/View/Account/start_setting_profile%20.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:webview_flutter/platform_interface.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Presenter/Http/http_presenter.dart';
import '../Pages/Deliver/deliver_finish.dart';
import '../Pages/frame.dart';
import 'login.dart';
import 'dart:convert';

class Login_Oauth_Screen extends StatefulWidget {
  const Login_Oauth_Screen({Key? key}) : super(key: key);

  @override
  _Login_Oauth_Screen createState() => _Login_Oauth_Screen();
}

class _Login_Oauth_Screen extends State<Login_Oauth_Screen> {
// WebViewController를 선언합니다.
  WebViewController? _controller;
  var check;
  check_before_signup()async{

    final prefs = await SharedPreferences.getInstance();
    check = prefs.getString('login_method');

  }

  @override
  void initState() {
    // TODO: implement initState
    check_before_signup();
    super.initState();
  }


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
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: Deliver_Finish_Screen(

                            )));

                  },
                  child: Text(
                    "나만의 추억 장소",
                    style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontFamily: "Gilogfont"),
                  ),
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
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: InkWell(
                    onTap: () async {

                      if(check == null){
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
                                    (WebViewController webviewController) {
                                  _controller = webviewController;
                                },
                                javascriptChannels: Set.from([
                                  JavascriptChannel(
                                      name: "JavaScriptChannel",
                                      onMessageReceived:
                                          (JavascriptMessage result) {
                                        print(result.message);

                                        if (result.message != null) {
                                          Http_Presenter()
                                              .set_token(result.message);
                                          //http user get

                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Profile_Setting(
                                                        login_method:
                                                        'kakao',
                                                      )),
                                                  (Route r) => false);
                                          return;
                                        }
                                        Navigator.of(context).pop();
                                        return;
                                      }),
                                ]),
                              ),
                            )));
                      }else{
                        return showAlertDialog(context, "알림", "이미 카카오톡으로 로그인했습니다.");
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
                      height: size.height * 0.065,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.chat_bubble,
                              size: 18,
                            ),
                          ),
                          Center(
                              child: Text(
                            "Katalk으로 로그인",
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                            ),
                          )),
                          SizedBox(
                            width: size.width * 0.03,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Platform.isAndroid?Container():InkWell(
                  onTap: () {
                    signInWithApple();
                  },
                  child: Container(
                    width: size.width * 0.7,
                    height: size.height * 0.09,
                    child: Image.asset("assets/images/apple_oauth.png"),
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

  signInWithApple() async {
    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    print("${AppleIDAuthorizationScopes.fullName}");
    print("${AppleIDAuthorizationScopes.values}");
    //access token
    print("FFFdd${appleCredential.authorizationCode}");
    //idToken (JWT)
    print("ㅎㅎㅎ${appleCredential.identityToken}");




    // print("appleCredential");
    // print(appleCredential);
    //
    // // Create an `OAuthCredential` from the credential returned by Apple.
    // final oauthCredential = OAuthProvider("apple.com").credential(
    //   idToken: appleCredential.identityToken,
    //   accessToken: appleCredential.authorizationCode,
    //
    // );
    // print("oauthCredential");
    // print(oauthCredential.accessToken);
    // print(oauthCredential.idToken);
    // print(oauthCredential.token);
    //
    // // Sign in the user with Firebase. If the nonce we generated earlier does
    // // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    // return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }
}
