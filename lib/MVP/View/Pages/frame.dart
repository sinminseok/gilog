import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:gilog/MVP/View/Pages/Calendar/calendar.dart';
import 'package:gilog/MVP/View/Pages/Deliver/deliver.dart';
import 'package:gilog/MVP/View/Pages/home_screen.dart';
import 'package:gilog/MVP/View/Pages/Mypage/mypage_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/calendar_utils/check_datetime.dart';
import 'Widgets/bottom_nav_widget.dart';

class Frame_Screen extends StatefulWidget {
  String? Login_method;
    Frame_Screen({required this.Login_method});
  @override
  _Frame_Screen createState() => _Frame_Screen();
}

class _Frame_Screen extends State<Frame_Screen> {

  @override
  void initState() {
    check_login_method();
    FlutterAppBadger.removeBadge();
    super.initState();
  }

  check_login_method()async{
    if(widget.Login_method == "kakao"){
      print("kakao");
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('kakao', true);
    }if(widget.Login_method == "apple"){
      print("apple");
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('apple', true);
    }
  }


  int _selectedItem = 0;
  final screens = [
    Home_Screen(),
    Calendar_Screen(),
    Deliver_Screen(),
    Mypage_Screen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,

        bottomNavigationBar: CustomBottomNavigationBar(


          iconList: [
            Icons.home,
            Icons.calendar_today,
            Icons.local_shipping,
            Icons.person,
          ],
          onChange: (val) {
            setState(() {
              _selectedItem = val;
            });
          },
          defaultSelectedIndex: 0,
        ),
        body: screens[_selectedItem]);
  }
}
