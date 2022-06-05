

import 'package:flutter/cupertino.dart';
import 'package:gilog/MVP/Presenter/Kakao_Oauth/social_login.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'kakao_login_http.dart';


class Kakao_User_ViewModel{
  final KaKao_Social_Login? socialLogin;
  bool isLogined = false;
  User? user;

  Kakao_User_ViewModel(this.socialLogin);

  Future<bool?> login() async {


    isLogined = await socialLogin!.login();
    if (isLogined) {
      user = await UserApi.instance.me();
      print("Login in");
      print(user!.id);
      print(user!.kakaoAccount);
      //Kakao_User_Http().kakao_login(user!.id);
      return true;
      //추후 여기서 http kakao login request 후 http 클래스에서 provider 생성
    }else{
      return false;
    }
  }

  Future logout() async {
    await socialLogin!.logout();
    isLogined = false;
    user = null;
  }
}