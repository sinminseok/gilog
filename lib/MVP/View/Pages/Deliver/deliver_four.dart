import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gilog/MVP/Presenter/Http/http_presenter.dart';
import 'package:gilog/MVP/View/Pages/Deliver/deliver_two.dart';
import 'package:gilog/MVP/View/Pages/frame.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:gilog/Utils/toast.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../Utils/calendar_utils/datetime.dart';
import '../../../Presenter/Http/deliver_http.dart';
import 'deliver_finish.dart';

class Deliver_Four_Screen extends StatefulWidget {
  String? post_or_write;
  int? book_page;
  int? book_count;
  List<String?>? pick_datetime;

  Deliver_Four_Screen(
      {required this.post_or_write,
      this.book_page,
      this.book_count,
      this.pick_datetime});

  @override
  _Deliver_Four_Screen createState() => _Deliver_Four_Screen();
}

class _Deliver_Four_Screen extends State<Deliver_Four_Screen> {
  String? subString;
  var datetime;
  int? total_price;
  String? product = "";
  DateTime dateTime = DateTime.now();
  TextEditingController _destination_controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    datetime = full_getToday();
    Calculate_price();
    make_product();
    super.initState();
  }

  Calculate_price() {
    if (widget.book_page == 14) {
      total_price = 4900 * (widget.book_count!.toInt());
    } else {
      total_price = 5900 * (widget.book_count!.toInt());
    }
  }

  make_product() {
    product = "${widget.book_page}(${widget.post_or_write})";
  }

  String? test_string;
  filter_string(){
    final pos = widget.pick_datetime!.toString().length - 1;
    test_string = widget.pick_datetime!.toString().substring(1,pos);
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                          bottom: BorderSide(color: Colors.purple, width: 5)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            InkWell(
              onTap: (){
                filter_string();
              },
              child: Text(
                "추억을 집 앞에 잘 배송하기 위해",
                style: TextStyle(fontFamily: "gilogfont", fontSize: 23),
              ),
            ),
            Text(
              "다음 사항을 꼭 확인해주세요",
              style: TextStyle(fontFamily: "gilogfont", fontSize: 23),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              width: size.width * 0.9,
              height: size.height * 0.47,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                    child: Text(
                      "주문자: 쭈구밍",
                      style: TextStyle(fontFamily: "gilogfont", fontSize: 21),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 30),
                    child: Text(
                      "주문일시: $datetime",
                      style: TextStyle(fontFamily: "gilogfont", fontSize: 21),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                    child: Text(
                      "주문사항",
                      style: TextStyle(fontFamily: "gilogfont", fontSize: 21),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                    child: Text(
                      "${widget.post_or_write} - ${widget.book_count}권 - ${widget.book_page}일치 기록",
                      style: TextStyle(fontFamily: "gilogfont", fontSize: 21),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                    child: Text(
                      "배송지 정보",
                      style: TextStyle(fontFamily: "gilogfont", fontSize: 23),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          hintText: "배송지를 상세 주소 까지 입력해주세요!",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: "gilogfont",
                            fontSize: 18,
                          )),
                      controller: _destination_controller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 20),
                    child: Text(
                      "주문 금액: ${total_price}",
                      style: TextStyle(fontFamily: "gilogfont", fontSize: 21),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                "110-445-151150(신한)심소연으로",
                style: TextStyle(
                    fontFamily: "gilogfont",
                    fontSize: 18,
                    color: Colors.deepPurple),
              ),
            ),
            Text(
              "입급금액을 주문자명으로 1시간이내에",
              style: TextStyle(
                  fontFamily: "gilogfont",
                  fontSize: 18,
                  color: Colors.deepPurple),
            ),
            Text(
              "입금해주세요!",
              style: TextStyle(
                  fontFamily: "gilogfont",
                  fontSize: 18,
                  color: Colors.deepPurple),
            ),
            Text(
              "입금이 되지 않으면 자동 취소 됩니다ㅜㅜ",
              style: TextStyle(
                  fontFamily: "gilogfont",
                  fontSize: 18,
                  color: Colors.deepPurple),
            ),
            Text(
              "주문 현황은 마이페이지에서 확인할 수 있습니다!",
              style: TextStyle(
                  fontFamily: "gilogfont",
                  fontSize: 18,
                  color: Colors.deepPurple),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: InkWell(
                onTap: () async {
                  print(_destination_controller.text == "");
                  if (_destination_controller.text == "") {
                    showAlertDialog(context, "알림", "배송지 정보를 입력해주세요");
                  } else {
                    filter_string();
                    var token = await Http_Presenter().read_token();
                    //  showAlertDialog(context,"주문이 완료 되었습니다.","주문 정보는 마이페이지 에서 확인할 수 있습니다.");
                    var test = await Deliver_Http().post_deliver_info(
                        product,
                        dateTime.toString().substring(0, 10),
                        widget.book_count,
                        test_string,
                        total_price,
                        _destination_controller.text,
                        token);
                    if (test == true) {
                      print("성공");
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: Deliver_Finish_Screen()));
                    } else {
                      print("실패");
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: kButtonColor),
                  width: size.width * 0.7,
                  height: size.height * 0.06,
                  child: Center(
                      child: Text(
                    "완료!",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "numberfont",
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
