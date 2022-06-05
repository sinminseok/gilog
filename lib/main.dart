

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'MVP/Presenter/Kakao_Oauth/kakao_login_http.dart';
import 'MVP/Presenter/Kakao_Oauth/kakao_login_presenter.dart';
import 'MVP/View/Account/login.dart';
import 'Utils/constants.dart';


void main() async {
  KakaoSdk.init(nativeAppKey:'c4ddd110fec9eaab625667112de706fb');
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => Kakao_User_Http()),
    ], child: MyApp()),
  );

}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //StreamProvider 하단에 있는 widget 들은 value 값이 변경될때마다 감지가 가능하다.
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          // ... app-specific localization delegate[s] here
          SfGlobalLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('ko')
          // ... other locales the app supports
        ],
        locale: const Locale('ko'),
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          // textTheme: GoogleFonts.roboTextTheme(Theme.of(context).textTheme)
        ),
        //Start_page()
        home: Login_Screen());
  }
}