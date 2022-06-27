
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../Utils/constants.dart';
class Setting_Profile extends StatefulWidget {
  const Setting_Profile({Key? key}) : super(key: key);

  @override
  _Setting_ProfileState createState() => _Setting_ProfileState();
}

class _Setting_ProfileState extends State<Setting_Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(

        backgroundColor: kProfileColor,
        title: Text("프로필 수정",style: TextStyle(color: Colors.black,fontFamily: "gilogfont"),),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //색변경
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: kProfileColor,
              height: size.height * 0.03,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: kProfileColor),
              height: size.height * 0.25,
              child: Column(

                children: [
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage(
                        'https://www.woolha.com/media/2020/03/eevee.png'),
                  ),
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "신민석",
                            style: TextStyle(
                                fontSize: 23, fontFamily: "gilogfont"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "기로기",
                              style: TextStyle(
                                  fontSize: 17, fontFamily: "gilogfont"),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                  Container(
                    width: size.width * 0.1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
