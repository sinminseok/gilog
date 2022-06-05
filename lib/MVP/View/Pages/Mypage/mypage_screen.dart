import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/multi_profile_widget.dart';

class Mypage_Screen extends StatefulWidget {
  const Mypage_Screen({Key? key}) : super(key: key);

  @override
  _Mypage_ScreenState createState() => _Mypage_ScreenState();
}

class _Mypage_ScreenState extends State<Mypage_Screen> {
  List<String?> people = ["애기1", "애기2"];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(
                      'https://www.woolha.com/media/2020/03/eevee.png'),
                ),
                Text(
                  "신민석",
                  style: TextStyle(fontSize: 23),
                ),
                Container(
                  width: size.width * 0.3,
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.1,
                ),
                Text("멀티 프로필"),
                Icon(Icons.settings)
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3), color: Colors.purple),
              width: size.width * 0.7,
              height: size.height * 0.06,
              child: Center(
                  child: Text(
                "수정하기",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
