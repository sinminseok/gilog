import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/Presenter/Http/http_presenter.dart';

import '../MVP/Model/deliver_item.dart';
import '../MVP/Presenter/Http/deliver_http.dart';
import 'constants.dart';

class Deliver_Item extends StatefulWidget {
  final int? id;
  final int? prcie;
  final String? datetime;
  final int? payState;

  Deliver_Item(
      {required this.id,
      required this.prcie,
      required this.datetime,
      required this.payState});

  @override
  _Deliver_ItemState createState() => _Deliver_ItemState();
}

class _Deliver_ItemState extends State<Deliver_Item> {
  Deliver_item? _deliver_item;
  String? paystate = "";

  change_state() {
    switch (widget.payState) {
      case 1:
        paystate = "입급전";
        break;
      case 2:
        paystate = "추가입금대기";
        break;
      case 3:
        paystate = "입금완료";
        break;
      case 4:
        paystate = "결제완료";
        break;
    }
  }

  get_detail_info() async {
    var token = await Http_Presenter().read_token();
    var return_value =
        await Deliver_Http().get_item_detail(widget.id, token, context);
    return return_value;
  }

  void _showDialog(
      Size size, product, orderDate, amount, address, price, payState) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: DefaultTextStyle(
              style: TextStyle(fontSize: 16, color: Colors.black),
              child: Container(
                width: MediaQuery.of(context).size.width - size.width * 0.1,
                height: MediaQuery.of(context).size.height - size.height * 0.2,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(23.0),
                        child: Center(
                            child: Text(
                          "주문 상세",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        )),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "· ${product.toString().substring(0, 2)}개의 기록",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("· ${product.toString().substring(2)} "),
                      ),
                      Container(
                        height: size.height * 0.01,
                        width: size.width * 1,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.06))),
                      ),
                      Container(
                        width: size.width * 1,
                        height: size.height * 0.05,
                        color: Colors.grey.shade100,
                        child: Center(
                          child: Text("배송 정보"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "배송지",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "$address",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey.shade200)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "배송상태",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "$payState",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width * 1,
                        height: size.height * 0.05,
                        color: Colors.grey.shade100,
                        child: Center(
                          child: Text("결제 정보"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "결제 금액",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "$price",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey.shade200)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "주문 날짜",
                              style: TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            Text(
                              "$orderDate",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey.shade200)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "주문 계좌 정보",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "110-445-151150\n(신한)심소연",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey.shade300)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Center(
                          child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "닫기",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.15,
        width: size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              change_state();
              _deliver_item = await get_detail_info();
              _showDialog(
                size,
                _deliver_item?.product,
                _deliver_item?.orderDate,
                _deliver_item?.amount,
                _deliver_item?.address,
                _deliver_item?.price,
                paystate,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 0.15,
                  )),
              width: size.width * 0.85,
              height: size.height * 0.15,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          bottom: BorderSide(width: 0.8, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("주문 상세 확인"),
                        SizedBox(
                          width: size.width * 0.3,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 0.8, color: Colors.grey),
                                ),
                              ),
                              child: Text("$paystate"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
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
        ));
  }
}
