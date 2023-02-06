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

  final List<String> images = <String>['review1.png','review2.png'];

  @override void dispose() {
    // TODO: implement dispose
    print("dispose deliver1");

    super.dispose();
  }

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
            Container(
              height: size.height * 0.35,

              child: PageView.builder(
                controller: PageController(initialPage: images.length),
              itemCount: images.length,
                itemBuilder: (BuildContext context,int index){
                return Container(width: size.width*1,height: size.height*0.2,
                child: Image.asset('assets/images/${images[index]}',fit: BoxFit.contain,),);
                },
              ),
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
                                    color: Color(0xfff76707),
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
                        child: Image.asset("assets/images/only_image.png",fit: BoxFit.cover,),
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
                                    color: kButtonColor,
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
                        child: Image.asset("assets/images/image_and_write.png",fit: BoxFit.cover,),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.06,
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
                          child: Deliver_Two_Screen(data: "사진+글")));
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
            ),
          ],
        ),
      ),
    );
  }
}
