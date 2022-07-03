import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';


class Deliver_Item extends StatefulWidget {
  final int? id;
  final int? prcie;
  final String? datetime;
  Deliver_Item({required this.id,required this.prcie,required this.datetime});

  @override
  _Deliver_ItemState createState() => _Deliver_ItemState();
}

class _Deliver_ItemState extends State<Deliver_Item> {

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
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close)),
              Text(
                "주문 상세",
                style: TextStyle(fontSize: 19),
              ),
              SizedBox(
                width: size.width * 0.03,
              ),
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
                SizedBox(
                  height: size.height * 0.02,
                ),
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
    return Container(
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
                              "${widget.datetime}",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: size.width * 0.1,
                            ),
                            Text(
                              "${widget.prcie}원",
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
                                        style: TextStyle(fontSize: 16),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0),
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
        ));
  }
}
