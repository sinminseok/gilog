import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/View/Pages/Deliver/deliver_three.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../Utils/constants.dart';
import '../../../../Utils/toast.dart';

class Deliver_Two_Screen extends StatefulWidget {
  String? data; //ex)사진만 OR 글도함께

  Deliver_Two_Screen({required this.data});

  @override
  _Deliver_Two_Screen createState() => _Deliver_Two_Screen();
}

class _Deliver_Two_Screen extends State<Deliver_Two_Screen> {
  bool check_one = false;
  bool check_two = false;
  int book_count = 0;

  bool check_count_one = false;
  bool check_count_two = false;
  bool check_count_three = false;
  bool check_count_four = false;
  bool check_count_five = false;

  @override void dispose() {
    // TODO: implement dispose
    print("dispose deliver2");

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 0.1,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black12, width: 5)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 0.1,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Color(0xfff76707), width: 5)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 0.1,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 5)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 0.1,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 5)),
                    ),
                  ),
                ),

                 */
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Text("메모리북 내지 수",style: TextStyle(fontFamily: "gilogfont",fontSize: 32),),
            SizedBox(height: size.height*0.02,),
            Text("(2주 or 4주)",style: TextStyle(fontFamily: "gilogfont",fontSize: 20),),
            SizedBox(height: size.height*0.03,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (check_two == true) {
                          check_one = !check_one;
                          check_two = false;
                        } else {
                          check_one = !check_one;
                        }
                      });
                    },
                    child: Container(
                      width: size.width * 0.41,
                      height: size.height * 0.07,
                      decoration: BoxDecoration(
                          color: kButtonColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "14개의 기-록",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "gilogfont"),
                            ),
                          ),
                          check_one == true

                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : Container(),


                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (check_one == true) {
                        check_two = !check_two;
                        check_one = false;
                      } else {
                        check_two = !check_two;
                      }
                    });
                  },
                  child: Container(
                    width: size.width * 0.41,
                    height: size.height * 0.07,
                    decoration: BoxDecoration(
                        color: Color(0xffF6E0CF),
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "28개의 기-록",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "gilogfont"),
                          ),
                        ),
                        check_two == true
                            ? Icon(
                                Icons.check,
                                color: Color(0xfff76707),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0,bottom: 30.0),
              child: Container(
                width: size.width*0.9,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.5, color: Colors.black12),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text("메모리북 신청 부수",style: TextStyle(fontFamily: "gilogfont",fontSize: 32),),
            //Text("신청 부수",style: TextStyle(fontFamily: "gilogfont",fontSize: 32),),
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      book_count = 1;
                      if (check_count_five == true ||
                          check_count_two == true ||
                          check_count_three == true ||
                          check_count_four == true) {
                        check_count_five = false;
                        check_count_two = false;
                        check_count_three = false;
                        check_count_four = false;
                        check_count_one = !check_count_one;
                      } else {
                        check_count_one = !check_count_one;
                      }
                    });
                  },
                  child: Container(
                    width: size.width * 0.17,
                    height: size.height * 0.07,
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(10),
                    decoration: check_count_one == true
                        ? BoxDecoration(
                            color: kButtonColor,
                            borderRadius: BorderRadius.circular(100))
                        : BoxDecoration(
                            color: Color(0xffF6E0CF),
                            borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Text(
                      "1권",
                      style: TextStyle(fontFamily: "gilogfont",fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      book_count = 2;
                      if (check_count_five == true ||
                          check_count_one == true ||
                          check_count_three == true ||
                          check_count_four == true) {
                        check_count_five = false;
                        check_count_one = false;
                        check_count_three = false;
                        check_count_four = false;
                        check_count_two = !check_count_two;
                      } else {
                        check_count_two = !check_count_two;
                      }
                    });
                  },
                  child: Container(
                    width: size.width * 0.17,
                    height: size.height * 0.07,
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(10),
                    decoration: check_count_two == true
                        ? BoxDecoration(
                        color: kButtonColor,
                        borderRadius: BorderRadius.circular(100))
                        : BoxDecoration(
                        color: Color(0xffF6E0CF),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Text(
                      "2권",
                      style: TextStyle(fontFamily: "gilogfont",fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      book_count = 3;
                      if (check_count_five == true ||
                          check_count_two == true ||
                          check_count_one == true ||
                          check_count_four == true) {
                        check_count_five = false;
                        check_count_two = false;
                        check_count_one = false;
                        check_count_four = false;
                        check_count_three = !check_count_three;
                      } else {
                        check_count_three = !check_count_three;
                      }
                    });
                  },
                  child: Container(
                    width: size.width * 0.17,
                    height: size.height * 0.07,
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(10),
                    decoration: check_count_three == true
                        ? BoxDecoration(
                        color: kButtonColor,
                        borderRadius: BorderRadius.circular(100))
                        : BoxDecoration(
                        color: Color(0xffF6E0CF),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Text(
                      "3권",
                      style: TextStyle(fontFamily: "gilogfont",fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      book_count = 4;
                      if (check_count_five == true ||
                          check_count_two == true ||
                          check_count_three == true ||
                          check_count_one == true) {
                        check_count_five = false;
                        check_count_two = false;
                        check_count_three = false;
                        check_count_one = false;
                        check_count_four = !check_count_four;
                      } else {
                        check_count_four = !check_count_four;
                      }
                    });
                  },
                  child: Container(
                    width: size.width * 0.17,
                    height: size.height * 0.07,
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(10),
                    decoration: check_count_four == true
                        ? BoxDecoration(
                        color: kButtonColor,
                        borderRadius: BorderRadius.circular(100))
                        : BoxDecoration(
                        color: Color(0xffF6E0CF),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Text(
                      "4권",
                      style: TextStyle(fontFamily: "gilogfont",fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      book_count = 5;
                      if (check_count_one == true ||
                          check_count_two == true ||
                          check_count_three == true ||
                          check_count_four == true) {
                        check_count_one = false;
                        check_count_two = false;
                        check_count_three = false;
                        check_count_four = false;
                        check_count_five = !check_count_five;
                      } else {
                        check_count_five = !check_count_five;
                      }
                    });
                  },
                  child: Container(
                    width: size.width * 0.17,
                    height: size.height * 0.07,
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(10),
                    decoration: check_count_five == true
                        ? BoxDecoration(
                        color: kButtonColor,
                        borderRadius: BorderRadius.circular(100))
                        : BoxDecoration(
                        color: Color(0xffF6E0CF),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Text(
                      "5권",
                      style: TextStyle(fontFamily: "gilogfont",fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.07,
            ),
            InkWell(
              onTap: () {
                if (check_one == false && check_two == false) {
                  showAlertDialog(context, "알림", "인화할 페이지 수를 선택해주세요");
                  return;
                }
                if (check_one == true) {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: Deliver_Three_Screen(
                              post_or_write:widget.data,

                              book_page: 14, book_count: book_count)));
                }
                if (check_two == true) {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: Deliver_Three_Screen(
                              post_or_write:widget.data,
                              book_page: 28, book_count: book_count)));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kButtonColor),
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
            )
          ],
        ),
      ),
    );
  }
}
