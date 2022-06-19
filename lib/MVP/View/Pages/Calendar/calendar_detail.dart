import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/Utils/constants.dart';
import 'dart:math' as math;

class Calendar_detail extends StatefulWidget {
  String? date_time;

  Calendar_detail({required this.date_time});

  @override
  _Calendar_detailState createState() => _Calendar_detailState();
}

class _Calendar_detailState extends State<Calendar_detail> {
  @override
  void initState() {
    // TODO: implement initState
    //get http datetime detail

    super.initState();
  }

  double degrees = 90;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //색변경
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width * 1,
              height: size.height * 0.4,
              child: Image.asset(
                "assets/images/calendar_img1.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 3),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      width: size.width * 0.9,
                      height: size.height * 0.11,
                      child: Center(
                          child: Text(
                        "오늘 날씨는 어땠나요?",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "gilogfont",
                            fontSize: 19),
                      )),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: size.width * 0.88),
                    Transform.rotate(
                      angle: degrees * math.pi / -48,
                      child: Container(
                        width: size.width * 0.07,
                        child:
                            Image.asset("assets/images/yellow_pencil_icon.psd"),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              width: size.width * 0.9,
              height: size.height * 0.4,
              child: Text(
                  "테스트용 content 입니다테스트용 content 입니다테스트용 ",style: TextStyle(fontFamily: "gilogfont",fontSize: 20),)
            ),
          ],
        ),
      ),
    );
  }
}
