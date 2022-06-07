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
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

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
                Text(
                  "멀티 프로필",
                  style: TextStyle(fontSize: 21),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: Icon(Icons.settings),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: size.height * 0.3,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: size.height * 0.1,
                        color: Colors.white12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(child: Image.asset("assets/images/gi_icon.png"),),
                            SizedBox(width: size.width*0.05,),
                            Text("멀티프로필"),
                            SizedBox(width: size.width*0.4,),
                            Icon(Icons.arrow_forward_ios_outlined)
                          ],
                        )
                      );
                    }),
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
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
