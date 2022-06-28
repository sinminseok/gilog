import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Utils/constants.dart';

class Deliver_liver_page extends StatefulWidget {
  const Deliver_liver_page({Key? key}) : super(key: key);

  @override
  _Deliver_liver_pageState createState() => _Deliver_liver_pageState();
}

class _Deliver_liver_pageState extends State<Deliver_liver_page> {
  void _showDialog(Size size) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kPrimaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close)),
              Text("주문 상세",style: TextStyle(fontSize: 19),),
              SizedBox(width: size.width*0.03,),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                ),
                SizedBox(height: size.height*0.02,),
                Text("글만 선택 - 14개의 기록 -2권"),
                Container(
                  height: size.height * 0.03,
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.06))),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  "배송지 : 경기도 안산시 오목로 11길 5",
                ),
                Container(
                  height: size.height * 0.03,
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.06))),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  "주문금액 : 18400원",
                ),
                Container(
                  height: size.height * 0.03,
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.06))),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  "주문 현황 : 배송중",
                ),
                Container(
                  height: size.height * 0.03,
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.06))),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),

                Text("입금 계좌: 110-445-151150 신한은행 심소연")
              ],
            ),
          ),

        );
      },
    );
  }

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.7, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Text(("주문/배송 조회"),style: TextStyle(fontSize: 21),),
          SizedBox(
            height: size.height * 0.03,
          ),
          Container(
            width: size.width*1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  width: size.width*0.2,
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: size.width*0.06,),
                          Text("0"),
                          SizedBox(width: size.width*0.04,),
                          Icon(Icons.arrow_forward_ios_outlined,size: 18,color: Colors.grey.shade400,),
                        ],
                      ),
                      SizedBox(height: size.height*0.02,),
                      Row(
                        children: [
                          Text("결제 완료"),
                          SizedBox(width: size.width*0.04,),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: size.width*0.24,
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: size.width*0.06,),
                          Text("0"),
                          SizedBox(width: size.width*0.07,),
                          Icon(Icons.arrow_forward_ios_outlined,size: 18,color: Colors.grey.shade400,),
                        ],
                      ),
                      SizedBox(height: size.height*0.02,),
                      Row(
                        children: [
                          Text("상품 준비중"),
                          SizedBox(width: size.width*0.04,),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: size.width*0.2,
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: size.width*0.06,),
                          Text("0"),
                          SizedBox(width: size.width*0.04,),
                          Icon(Icons.arrow_forward_ios_outlined,size: 18,color: Colors.grey.shade400,),
                        ],
                      ),
                      SizedBox(height: size.height*0.02,),
                      Row(
                        children: [
                          SizedBox(width: size.width*0.025,),
                          Text("배송중"),
                          SizedBox(width: size.width*0.04,),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: size.width*0.2,
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: size.width*0.06,),
                          Text("0"),
                          SizedBox(width: size.width*0.04,),

                        ],
                      ),
                      SizedBox(height: size.height*0.02,),
                      Row(
                        children: [
                          Text("배송완료"),
                          SizedBox(width: size.width*0.04,),
                        ],
                      )
                    ],
                  ),
                ),



              ],
            ),
          ),
          SizedBox(height: size.height*0.05,),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.grey),
              ),
            ),
          ),
          Container(
            width: size.width*1,
            height: size.height * 0.64,
            color: Colors.grey.shade200,
            child: Column(
              children: [
                Container(
                    height: size.height * 0.6,
                    width: size.width * 0.9,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              _showDialog(size);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.15,
                                  )),
                              width: size.width * 0.85,
                              height: size.height * 0.1,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "2022_06_05",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.1,
                                        ),
                                        Text(
                                          "18500원",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 0.8, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "나의 첫번째 기록",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.1,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: size.width * 0.2,
                                              height: size.height * 0.03,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: Colors.purple)),
                                              child: Center(
                                                  child: Text(
                                                    "배송중",
                                                    style: TextStyle(

                                                        fontSize: 16),
                                                  )),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(left: 10.0),
                                              child: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 21,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),

              ],
            ),
          ),



        ],
      ),
    );
  }
}
