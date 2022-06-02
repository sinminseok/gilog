

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MVP/View/Account/login.dart';
import 'Utils/constants.dart';


void main() async {
  runApp(
    MultiProvider(providers: [
      // ChangeNotifierProvider(create: (context) => Http_services()),
      // ChangeNotifierProvider(create: (context) => FU_Http_services()),
    ], child: MyApp()),
  );

}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //StreamProvider 하단에 있는 widget 들은 value 값이 변경될때마다 감지가 가능하다.
    return MaterialApp(

        theme: ThemeData(
          primaryColor: kPrimaryColor,
          // textTheme: GoogleFonts.roboTextTheme(Theme.of(context).textTheme)
        ),
        //Start_page()
        home: Login_Screen());
  }
}