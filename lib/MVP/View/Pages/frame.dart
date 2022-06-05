import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/View/Pages/Calendar/calendar.dart';
import 'package:gilog/MVP/View/Pages/Deliver/deliver.dart';
import 'package:gilog/MVP/View/Pages/home_screen.dart';
import 'package:gilog/MVP/View/Pages/Mypage/mypage_screen.dart';
import 'Widgets/bottom_nav_widget.dart';

class Frame_Screen extends StatefulWidget {
  const Frame_Screen({Key? key}) : super(key: key);

  @override
  _Frame_Screen createState() => _Frame_Screen();
}

class _Frame_Screen extends State<Frame_Screen> {
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
