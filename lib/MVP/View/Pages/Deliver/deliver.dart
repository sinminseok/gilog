import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gilog/MVP/View/Pages/Deliver/deliver_two.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../Utils/toast.dart';

class Deliver_Screen extends StatefulWidget {
  const Deliver_Screen({Key? key}) : super(key: key);

  @override
  _Deliver_ScreenState createState() => _Deliver_ScreenState();
}

class _Deliver_ScreenState extends State<Deliver_Screen> {
  bool check_photo = false;
  bool check_write = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //색변경
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    height: size.height * 0.35,
                    width: size.width * 1,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10.0,
                          spreadRadius: 3.0,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/calendar_img1.jpeg",
                      fit: BoxFit.fill,
                    )),
                Container(
                  height: size.height*0.36,

                    child: Center(
                      child: Text(
                  "기-log 집으로 받아보기",
                  style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "gilogfont",
                        color: Colors.white),
                ),
                    ))
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (check_write == true) {
                        check_photo = !check_photo;
                        check_write = false;
                      } else {
                        check_photo = !check_photo;
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "사진만 할래요!",
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "numberfont"),
                            ),
                            check_photo == true
                                ? Icon(
                                    Icons.check,
                                    color: Colors.purple,
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        width: size.width * 0.43,
                        height: size.height * 0.2,
                        child: Image.asset("assets/images/photo.jpg",fit: BoxFit.fitHeight,),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (check_photo == true) {
                        check_photo = false;
                        check_write = !check_write;
                      } else {
                        check_write = !check_write;
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "글도 할래요!",
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "numberfont"),
                            ),
                            check_write == true
                                ? Icon(
                                    Icons.check,
                                    color: Colors.purple,
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        width: size.width * 0.43,
                        height: size.height * 0.2,
                        child: Image.asset("assets/images/write.jpg",fit: BoxFit.fitHeight,),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            InkWell(
              onTap: () {
                if (check_photo == false && check_write == false) {
                  showAlertDialog(context, "알림", "사진 또는 글을 선택해주세요");
                  return;
                }
                if (check_photo == true) {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: Deliver_Two_Screen(
                            data: "사진만",
                          )));
                }
                if (check_write == true) {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: Deliver_Two_Screen(data: "사진,글둘다")));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.purple),
                width: size.width * 0.7,
                height: size.height * 0.06,
                child: Center(
                    child: Text(
                  "다음으로",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "numberfont",
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
