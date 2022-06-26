import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/View/Pages/Mypage/deliver_live.dart';
import 'package:gilog/MVP/View/Pages/Mypage/set_alarm_page.dart';
import 'package:gilog/MVP/View/Pages/Mypage/setting_profile.dart';
import 'package:gilog/MVP/View/Pages/Mypage/useage_page.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:page_transition/page_transition.dart';


class Mypage_Screen extends StatefulWidget {
  const Mypage_Screen({Key? key}) : super(key: key);

  @override
  _Mypage_ScreenState createState() => _Mypage_ScreenState();
}

class _Mypage_ScreenState extends State<Mypage_Screen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(
                        'https://www.woolha.com/media/2020/03/eevee.png'),
                  ),
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      Row(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.purple),
                            width: size.width * 0.4,
                            height: size.height * 0.05,
                            child: InkWell(
                              child: Center(
                                  child: Text(
                                "설정",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "numberfont",
                                    fontWeight: FontWeight.bold),
                              )),
                              onTap: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  constraints: BoxConstraints(
                                    maxWidth: 700,
                                  ),
                                  builder: (BuildContext context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: size.height * 0.35,
                                      width: size.width * 0.9,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0, bottom: 20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.black,
                                                          width: 6)),
                                                  color: Colors.grey),
                                              width: size.width * 0.1,
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.1)),
                                            ),
                                            child: ListTile(
                                              leading: new Icon(Icons.settings),
                                              title: new Text(
                                                '프로필 설정',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: "numberfont"),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType.rightToLeftWithFade, child: Setting_Profile()));
                                              },
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.1)),
                                            ),
                                            child: ListTile(
                                              leading: new Icon(Icons.logout),
                                              title: new Text(
                                                '로그아웃',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: "numberfont"),
                                              ),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.1)),
                                            ),
                                            child: ListTile(
                                              leading: new Icon(Icons
                                                  .assignment_late_outlined),
                                              title: new Text(
                                                '회원 탈퇴',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: "numberfont"),
                                              ),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            )),
                      )
                    ],
                  ),
                  Container(
                    width: size.width * 0.1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade, child: Useage_page()));
              },
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.black, width: 0.1)),
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.info_rounded,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(
                        "이용안내",
                        style: TextStyle(
                            color: Colors.black, fontFamily: "gilogfont"),
                      ),
                      SizedBox(
                        width: size.width * 0.6,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black54,
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){

                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade, child: Deliver_liver_page()));
              },
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.black, width: 0.1)),
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.local_shipping,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(
                        "배송조회",
                        style: TextStyle(
                            color: Colors.black, fontFamily: "gilogfont"),
                      ),
                      SizedBox(
                        width: size.width * 0.6,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black54,
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade, child: Set_Alarm()));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.1)),
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(
                        "알림 시간 설정",
                        style: TextStyle(
                            color: Colors.black, fontFamily: "gilogfont"),
                      ),
                      SizedBox(
                        width: size.width * 0.51,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black54,
                      )
                    ],
                  ),
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.black, width: 0.1)),
              ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "기-log 버전",
                        style: TextStyle(
                            color: Colors.black, fontFamily: "gilogfont"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                        "1.0.0",
                        style: TextStyle(fontFamily: "gilogfont"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Row(
            //   children: [
            //     SizedBox(
            //       width: size.width * 0.1,
            //     ),
            //     Text(
            //       "멀티 프로필",
            //       style: TextStyle(fontSize: 21),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 13.0),
            //       child: Icon(Icons.settings),
            //     )
            //   ],
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     height: size.height * 0.3,
            //     child: ListView.builder(
            //         padding: const EdgeInsets.all(8),
            //         itemCount: entries.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           return Container(
            //               height: size.height * 0.1,
            //               color: Colors.white12,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 children: [
            //                   Container(
            //                     child: Image.asset("assets/images/gi_icon.png"),
            //                   ),
            //                   SizedBox(
            //                     width: size.width * 0.05,
            //                   ),
            //                   Text("멀티프로필"),
            //                   SizedBox(
            //                     width: size.width * 0.4,
            //                   ),
            //                   Icon(Icons.arrow_forward_ios_outlined)
            //                 ],
            //               ));
            //         }),
            //   ),
            // ),
            SizedBox(
              height: size.height * 0.29,
            ),
            Text(
              "@copyright 2022 by Sso-young",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
