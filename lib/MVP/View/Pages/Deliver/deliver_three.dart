import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gilog/MVP/View/Pages/Deliver/deliver_four.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:page_transition/page_transition.dart';

import 'package:date_utils/date_utils.dart' as dt;

import '../../../../Local_DB/db.dart';
import '../../../Model/post.dart';
import '../Calendar/calendar_detail.dart';

class Deliver_Three_Screen extends StatefulWidget {
  String? post_or_write;
  int? book_page;
  int? book_count;

  Deliver_Three_Screen(
      {required this.post_or_write, this.book_page, this.book_count});

  @override
  _Deliver_Three_Screen createState() => _Deliver_Three_Screen();
}

class _Deliver_Three_Screen extends State<Deliver_Three_Screen> {
  //
  List<String?> plus_book_page = [];

  //해당 달에 포함되는 일 List
  List<String?> date_list = [];

  //로컬에 기록된 정보 img local url만 담을 함수
  List<Uint8List?> img_list = [];

  //로컬에 저장된 모든 POST 리스트
  List<POST?> has_data_all_POST = [];

  DateTime? now;

  var daysinmonth;

  //init에서 가져올 현재 날짜에 해당하는 달,월
  var this_month;
  var this_year;

  //해당 년도 달에 포함된 POST데이터 LISt
  List<POST?> test_Data_list = [];

  filter_string_date(String date) {
    if (date.substring(0, 1) == "0") {
      return date.substring(1, 2);
    } else {
      return date;
    }
  }

  //해당 날짜에 해당하는 날짜 가져오는 함수

  local_data_filter_year() async {
    DBHelper sd = DBHelper();
    sd.database;
    var data = await sd.posts();
    has_data_all_POST = [];
    print("has_data_all_POST ${has_data_all_POST}");
    for (var i = 0; i < data.length; i++) {
      has_data_all_POST.add(data[i]);
    }

    for (var i = 0; i < has_data_all_POST.length; i++) {
      if (has_data_all_POST[i]!.datetime!.substring(0, 4) ==
          this_year.toString()) {
        //03,04~~
        if (has_data_all_POST[i]!.datetime!.substring(5, 6) == "0") {
          if (has_data_all_POST[i]!.datetime!.substring(6, 7) ==
              this_month.toString()) {
            test_Data_list.add(has_data_all_POST[i]);
          }
        }
        //12,11,10
        else {
          if (has_data_all_POST[i]!.datetime!.substring(6, 7) ==
              this_month.toString()) {
            test_Data_list.add(has_data_all_POST[i]);
          }
        }
      }
    }

    get_date_list();

    return test_Data_list;
  }

  @override
  void initState() {
    print(
        "post_or_write${widget.post_or_write} book_page${widget.book_page} book_count${widget.book_count}");
    img_list = [];
    has_data_all_POST = [];
    test_Data_list = [];
    date_list = [];
    get_datetime();
    get_date_list();
    local_data_filter_year();

    super.initState();
  }

  get_datetime() {
    now = DateTime.now();
    daysinmonth = dt.DateUtils.daysInMonth(now!);

    this_month = now!.month;
    this_year = now!.year;
  }

  get_date_list() {
    img_list = [];

    for (var i = 0; i < daysinmonth.length; i++) {
      var this_date;
      this_date =
          filter_string_date(daysinmonth[i].toString().substring(8, 10));
      date_list.add(this_date);

      if (test_Data_list.length == 0) {
        img_list.add(null);
      }

      for (var j = 0; j < test_Data_list.length; j++) {
        if (test_Data_list[j]!.datetime!.substring(8, 9) == "0") {
          if (this_date == test_Data_list[j]!.datetime!.substring(9, 10)) {
            img_list.add(test_Data_list[j]!.image_url);
            break;
          } else {
            if (j == test_Data_list.length - 1) {
              img_list.add(null);
              break;
            }
          }
        } else {
          if (this_date == test_Data_list[j]!.datetime!.substring(8, 10)) {
            img_list.add(test_Data_list[j]!.image_url);
            break;
          } else {
            if (j == test_Data_list.length - 1) {
              img_list.add(null);
              break;
            }
          }
        }
      }
    }
  }

//다음달로 넘기는 함수
  set_dateplus_list() {
    img_list = [];
    has_data_all_POST = [];
    test_Data_list = [];
    date_list = [];

    setState(() {
      if (this_month + 1 == 13) {
        this_year = this_year + 1;
        this_month = 1;
      } else {
        this_month += 1;
      }


      DateTime date_time = DateTime(this_year, this_month);
      daysinmonth = dt.DateUtils.daysInMonth(date_time);
      date_list = [];
      for (var i = 0; i < daysinmonth.length; i++) {
        var this_date;
        this_date =
            filter_string_date(daysinmonth[i].toString().substring(8, 10));
        date_list.add(this_date);
      }
    });

    local_data_filter_year();
  }

  //저번달로 넘기는 함수
  set_datesub_list() {
    img_list = [];
    has_data_all_POST = [];
    test_Data_list = [];
    date_list = [];

    setState(() {
      if (this_month - 1 == 0) {
        this_year = this_year - 1;
        this_month = 12;
      } else {
        this_month -= 1;
      }
      DateTime date_time = DateTime(this_year, this_month);
      daysinmonth = dt.DateUtils.daysInMonth(date_time);
      date_list = [];
      for (var i = 0; i < daysinmonth.length; i++) {
        var this_date;
        this_date =
            filter_string_date(daysinmonth[i].toString().substring(8, 10));
        date_list.add(this_date);
      }
    });
    local_data_filter_year();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.chevron_left,
                        size: 40,
                      )),
                  SizedBox(
                    width: size.width * 0.12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 5)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 5)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.purple, width: 5)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            set_datesub_list();
                          },
                          child: Icon(
                            Icons.arrow_left,
                            size: 50,
                          )),
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$this_year 년 $this_month 월",
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                      InkWell(
                          onTap: () {
                            set_dateplus_list();
                          },
                          child: Icon(
                            Icons.arrow_right,
                            size: 50,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    width: size.width * 1,
                    height: size.height * 0.66,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "일",
                              style: TextStyle(color: Colors.red),
                            ),
                            Text("월"),
                            Text("화"),
                            Text("수"),
                            Text("목"),
                            Text("금"),
                            Text("토"),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        FutureBuilder(
                            future: local_data_filter_year(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (img_list.length == 0) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.connectionState == false) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasData == false) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              //error가 발생하게 될 경우 반환하게 되는 부분
                              else if (snapshot.hasError) {
                                return Center(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator()),
                                );
                              }
                              // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                              else {
                                return Column(
                                  children: [
                                    daysinmonth.length == 42
                                        ? date_list[6] == "31" ||
                                                date_list[6] == "30"
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      print(date_list[0]);
                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child:
                                                                  Calendar_detail(
                                                                date_time:
                                                                    date_list[
                                                                        0],
                                                              )));
                                                    },
                                                    child: Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.height * 0.1,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                                "${date_list[0]}"),
                                                            date_list[0] ==
                                                                        "25" ||
                                                                    date_list[
                                                                            0] ==
                                                                        "26" ||
                                                                    date_list[
                                                                            0] ==
                                                                        "27" ||
                                                                    date_list[
                                                                            0] ==
                                                                        "28" ||
                                                                    date_list[
                                                                            0] ==
                                                                        "29" ||
                                                                    date_list[
                                                                            0] ==
                                                                        "30" ||
                                                                    date_list[
                                                                            0] ==
                                                                        "31"
                                                                ? Container()
                                                                : img_list[
                                                                            0] ==
                                                                        null
                                                                    ? Container()
                                                                    : Container(
                                                                        width: size
                                                                                .width *
                                                                            0.1,
                                                                        height: size.height *
                                                                            0.07,
                                                                        child: Image.memory(img_list[0]
                                                                            as Uint8List)),
                                                          ],
                                                        )),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      print(date_list[1]);
                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child:
                                                                  Calendar_detail(
                                                                date_time:
                                                                    date_list[
                                                                        1],
                                                              )));
                                                    },
                                                    child: Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.height * 0.1,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                                "${date_list[1]}"),
                                                            date_list[1] ==
                                                                        "25" ||
                                                                    date_list[
                                                                            1] ==
                                                                        "26" ||
                                                                    date_list[
                                                                            1] ==
                                                                        "27" ||
                                                                    date_list[
                                                                            1] ==
                                                                        "28" ||
                                                                    date_list[
                                                                            1] ==
                                                                        "29" ||
                                                                    date_list[
                                                                            1] ==
                                                                        "30" ||
                                                                    date_list[
                                                                            1] ==
                                                                        "31"
                                                                ? Container()
                                                                : img_list[
                                                                            1] ==
                                                                        null
                                                                    ? Container()
                                                                    : Container(
                                                                        width: size
                                                                                .width *
                                                                            0.1,
                                                                        height: size.height *
                                                                            0.07,
                                                                        child: Image.memory(img_list[1]
                                                                            as Uint8List)),
                                                          ],
                                                        )),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      print(date_list[2]);
                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child:
                                                                  Calendar_detail(
                                                                date_time:
                                                                    date_list[
                                                                        2],
                                                              )));
                                                    },
                                                    child: Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.height * 0.1,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                                "${date_list[2]}"),
                                                            date_list[2] ==
                                                                        "25" ||
                                                                    date_list[
                                                                            2] ==
                                                                        "26" ||
                                                                    date_list[
                                                                            2] ==
                                                                        "27" ||
                                                                    date_list[
                                                                            2] ==
                                                                        "28" ||
                                                                    date_list[
                                                                            2] ==
                                                                        "29" ||
                                                                    date_list[
                                                                            2] ==
                                                                        "30" ||
                                                                    date_list[
                                                                            2] ==
                                                                        "31"
                                                                ? Container()
                                                                : img_list[
                                                                            2] ==
                                                                        null
                                                                    ? Container()
                                                                    : Container(
                                                                        width: size
                                                                                .width *
                                                                            0.1,
                                                                        height: size.height *
                                                                            0.07,
                                                                        child: Image.memory(img_list[3]
                                                                            as Uint8List)),
                                                          ],
                                                        )),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      print(date_list[3]);
                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child:
                                                                  Calendar_detail(
                                                                date_time:
                                                                    date_list[
                                                                        3],
                                                              )));
                                                    },
                                                    child: Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.height * 0.1,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                                "${date_list[3]}"),
                                                            date_list[3] ==
                                                                        "25" ||
                                                                    date_list[
                                                                            3] ==
                                                                        "26" ||
                                                                    date_list[
                                                                            3] ==
                                                                        "27" ||
                                                                    date_list[
                                                                            3] ==
                                                                        "28" ||
                                                                    date_list[
                                                                            3] ==
                                                                        "29" ||
                                                                    date_list[
                                                                            3] ==
                                                                        "30" ||
                                                                    date_list[
                                                                            3] ==
                                                                        "31"
                                                                ? Container()
                                                                : img_list[
                                                                            3] ==
                                                                        null
                                                                    ? Container()
                                                                    : Container(
                                                                        width: size
                                                                                .width *
                                                                            0.1,
                                                                        height: size.height *
                                                                            0.07,
                                                                        child: Image.memory(img_list[3]
                                                                            as Uint8List)),
                                                          ],
                                                        )),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      print(date_list[4]);
                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child:
                                                                  Calendar_detail(
                                                                date_time:
                                                                    date_list[
                                                                        4],
                                                              )));
                                                    },
                                                    child: Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.height * 0.1,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                                "${date_list[4]}"),
                                                            date_list[4] ==
                                                                        "25" ||
                                                                    date_list[
                                                                            4] ==
                                                                        "26" ||
                                                                    date_list[
                                                                            4] ==
                                                                        "27" ||
                                                                    date_list[
                                                                            4] ==
                                                                        "28" ||
                                                                    date_list[
                                                                            4] ==
                                                                        "29" ||
                                                                    date_list[
                                                                            4] ==
                                                                        "30" ||
                                                                    date_list[
                                                                            4] ==
                                                                        "31"
                                                                ? Container()
                                                                : img_list[
                                                                            4] ==
                                                                        null
                                                                    ? Container()
                                                                    : Container(
                                                                        width: size
                                                                                .width *
                                                                            0.1,
                                                                        height: size.height *
                                                                            0.07,
                                                                        child: Image.memory(img_list[4]
                                                                            as Uint8List)),
                                                          ],
                                                        )),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      print(date_list[5]);
                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child:
                                                                  Calendar_detail(
                                                                date_time:
                                                                    date_list[
                                                                        5],
                                                              )));
                                                    },
                                                    child: Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.height * 0.1,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                                "${date_list[5]}"),
                                                            date_list[5] ==
                                                                        "25" ||
                                                                    date_list[
                                                                            5] ==
                                                                        "26" ||
                                                                    date_list[
                                                                            5] ==
                                                                        "27" ||
                                                                    date_list[
                                                                            5] ==
                                                                        "28" ||
                                                                    date_list[
                                                                            5] ==
                                                                        "29" ||
                                                                    date_list[
                                                                            5] ==
                                                                        "30" ||
                                                                    date_list[
                                                                            5] ==
                                                                        "31"
                                                                ? Container()
                                                                : img_list[
                                                                            5] ==
                                                                        null
                                                                    ? Container()
                                                                    : Container(
                                                                        width: size
                                                                                .width *
                                                                            0.1,
                                                                        height: size.height *
                                                                            0.07,
                                                                        child: Image.memory(img_list[5]
                                                                            as Uint8List)),
                                                          ],
                                                        )),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      print(date_list[6]);
                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child:
                                                                  Calendar_detail(
                                                                date_time:
                                                                    date_list[
                                                                        6],
                                                              )));
                                                    },
                                                    child: Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.height * 0.1,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                                "${date_list[6]}"),
                                                            date_list[6] ==
                                                                        "25" ||
                                                                    date_list[
                                                                            6] ==
                                                                        "26" ||
                                                                    date_list[
                                                                            6] ==
                                                                        "27" ||
                                                                    date_list[
                                                                            6] ==
                                                                        "28" ||
                                                                    date_list[
                                                                            6] ==
                                                                        "29" ||
                                                                    date_list[
                                                                            6] ==
                                                                        "30" ||
                                                                    date_list[
                                                                            6] ==
                                                                        "31"
                                                                ? Container()
                                                                : img_list[
                                                                            6] ==
                                                                        null
                                                                    ? Container()
                                                                    : Container(
                                                                        width: size
                                                                                .width *
                                                                            0.1,
                                                                        height: size.height *
                                                                            0.07,
                                                                        child: Image.memory(img_list[6]
                                                                            as Uint8List)),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  print(date_list[0]);
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail(
                                                            date_time:
                                                                date_list[0],
                                                          )));
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text("${date_list[0]}"),
                                                        date_list[0] == "25" ||
                                                                date_list[0] ==
                                                                    "26" ||
                                                                date_list[0] ==
                                                                    "27" ||
                                                                date_list[0] ==
                                                                    "28" ||
                                                                date_list[0] ==
                                                                    "29" ||
                                                                date_list[0] ==
                                                                    "30" ||
                                                                date_list[0] ==
                                                                    "31"
                                                            ? Container()
                                                            : img_list[0] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child: Image.memory(
                                                                        img_list[0]
                                                                            as Uint8List)),
                                                      ],
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  print(date_list[1]);
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail(
                                                            date_time:
                                                                date_list[1],
                                                          )));
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text("${date_list[1]}"),
                                                        date_list[1] == "25" ||
                                                                date_list[1] ==
                                                                    "26" ||
                                                                date_list[1] ==
                                                                    "27" ||
                                                                date_list[1] ==
                                                                    "28" ||
                                                                date_list[1] ==
                                                                    "29" ||
                                                                date_list[1] ==
                                                                    "30" ||
                                                                date_list[1] ==
                                                                    "31"
                                                            ? Container()
                                                            : img_list[1] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child: Image.memory(
                                                                        img_list[1]
                                                                            as Uint8List)),
                                                      ],
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  print(date_list[2]);
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail(
                                                            date_time:
                                                                date_list[2],
                                                          )));
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text("${date_list[2]}"),
                                                        date_list[2] == "25" ||
                                                                date_list[2] ==
                                                                    "26" ||
                                                                date_list[2] ==
                                                                    "27" ||
                                                                date_list[2] ==
                                                                    "28" ||
                                                                date_list[2] ==
                                                                    "29" ||
                                                                date_list[2] ==
                                                                    "30" ||
                                                                date_list[2] ==
                                                                    "31"
                                                            ? Container()
                                                            : img_list[2] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child: Image.memory(
                                                                        img_list[2]
                                                                            as Uint8List)),
                                                      ],
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail(
                                                            date_time:
                                                                date_list[3],
                                                          )));
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text("${date_list[3]}"),
                                                        date_list[3] == "25" ||
                                                                date_list[3] ==
                                                                    "26" ||
                                                                date_list[3] ==
                                                                    "27" ||
                                                                date_list[3] ==
                                                                    "28" ||
                                                                date_list[3] ==
                                                                    "29" ||
                                                                date_list[3] ==
                                                                    "30" ||
                                                                date_list[3] ==
                                                                    "31"
                                                            ? Container()
                                                            : img_list[3] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child: Image.memory(
                                                                        img_list[3]
                                                                            as Uint8List)),
                                                      ],
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  print(date_list[4]);
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail(
                                                            date_time:
                                                                date_list[4],
                                                          )));
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text("${date_list[4]}"),
                                                        date_list[4] == "25" ||
                                                                date_list[4] ==
                                                                    "26" ||
                                                                date_list[4] ==
                                                                    "27" ||
                                                                date_list[4] ==
                                                                    "28" ||
                                                                date_list[4] ==
                                                                    "29" ||
                                                                date_list[4] ==
                                                                    "30" ||
                                                                date_list[4] ==
                                                                    "31"
                                                            ? Container()
                                                            : img_list[4] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child: Image.memory(
                                                                        img_list[4]
                                                                            as Uint8List)),
                                                      ],
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  print(date_list[5]);
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail(
                                                            date_time:
                                                                date_list[5],
                                                          )));
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text("${date_list[5]}"),
                                                        date_list[5] == "25" ||
                                                                date_list[5] ==
                                                                    "26" ||
                                                                date_list[5] ==
                                                                    "27" ||
                                                                date_list[5] ==
                                                                    "28" ||
                                                                date_list[5] ==
                                                                    "29" ||
                                                                date_list[5] ==
                                                                    "30" ||
                                                                date_list[5] ==
                                                                    "31"
                                                            ? Container()
                                                            : img_list[5] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child: Image.memory(
                                                                        img_list[5]
                                                                            as Uint8List)),
                                                      ],
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  print(date_list[6]);
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail(
                                                            date_time:
                                                                date_list[6],
                                                          )));
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text("${date_list[6]}"),
                                                        date_list[6] == "25" ||
                                                                date_list[6] ==
                                                                    "26" ||
                                                                date_list[6] ==
                                                                    "27" ||
                                                                date_list[6] ==
                                                                    "28" ||
                                                                date_list[6] ==
                                                                    "29" ||
                                                                date_list[6] ==
                                                                    "30" ||
                                                                date_list[6] ==
                                                                    "31"
                                                            ? Container()
                                                            : img_list[6] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child: Image.memory(
                                                                        img_list[6]
                                                                            as Uint8List)),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          ),
                                    //위에까지 0~6
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print(date_list[7]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[7],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[7]}"),
                                                  img_list[7] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[7]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[8]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[8],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[8]}"),
                                                  img_list[8] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[8]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[9]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[9],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[9]}"),
                                                  img_list[9] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[9]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[10]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[10],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[10]}"),
                                                  img_list[10] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[10]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[11]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[11],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[11]}"),
                                                  img_list[11] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[11]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[12]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[12],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[12]}"),
                                                  img_list[12] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[12]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[13]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[13],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[13]}"),
                                                  img_list[13] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[13]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print(date_list[14]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[14],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[14]}"),
                                                  img_list[14] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[14]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[15],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[15]}"),
                                                  img_list[15] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[15]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[16]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[16],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[16]}"),
                                                  img_list[16] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[16]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print({img_list[17].runtimeType});

                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[17],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[17]}"),
                                                  img_list[17] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[17]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[18]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[18],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[18]}"),
                                                  img_list[18] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[18]
                                                                  as Uint8List))
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[0]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[19],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[19]}"),
                                                  img_list[19] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Image.memory(
                                                                  img_list[19]
                                                                      as Uint8List))),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[20]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[20],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[20]}"),
                                                  img_list[20] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[20]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print(date_list[21]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[21],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[21]}"),
                                                  img_list[21] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[21]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[22]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[22],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[22]}"),
                                                  img_list[22] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[22]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[23]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[23],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[23]}"),
                                                  img_list[23] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[23]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[24]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[24],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[24]}"),
                                                  img_list[24] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[24]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[25]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[25],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[25]}"),
                                                  img_list[25] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[25]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[26]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[26],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[26]}"),
                                                  img_list[26] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[26]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[27]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[27],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[27]}"),
                                                  img_list[27] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Image.memory(
                                                              img_list[27]
                                                                  as Uint8List)),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print(date_list[28]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[28],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[28]}"),
                                                  date_list[28] == "1" ||
                                                          date_list[28] ==
                                                              "2" ||
                                                          date_list[28] ==
                                                              "3" ||
                                                          date_list[28] ==
                                                              "4" ||
                                                          date_list[28] ==
                                                              "5" ||
                                                          date_list[28] == "6"
                                                      ? Container()
                                                      : img_list[28] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Image.memory(
                                                                  img_list[28]
                                                                      as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[29]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[29],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[29]}"),
                                                  date_list[29] == "1" ||
                                                          date_list[29] ==
                                                              "2" ||
                                                          date_list[29] ==
                                                              "3" ||
                                                          date_list[29] ==
                                                              "4" ||
                                                          date_list[29] ==
                                                              "5" ||
                                                          date_list[29] == "6"
                                                      ? Container()
                                                      : img_list[29] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Image.memory(
                                                                  img_list[29]
                                                                      as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[30]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[30],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[30]}"),
                                                  date_list[30] == "1" ||
                                                          date_list[30] ==
                                                              "2" ||
                                                          date_list[30] ==
                                                              "3" ||
                                                          date_list[30] ==
                                                              "4" ||
                                                          date_list[30] ==
                                                              "5" ||
                                                          date_list[30] == "6"
                                                      ? Container()
                                                      : img_list[30] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Image.memory(
                                                                  img_list[30]
                                                                      as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[31]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[31],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[31]}"),
                                                  date_list[31] == "1" ||
                                                          date_list[31] ==
                                                              "2" ||
                                                          date_list[31] ==
                                                              "3" ||
                                                          date_list[31] ==
                                                              "4" ||
                                                          date_list[31] ==
                                                              "5" ||
                                                          date_list[31] == "6"
                                                      ? Container()
                                                      : img_list[31] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Image.memory(
                                                                  img_list[31]
                                                                      as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[32]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[32],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[32]}"),
                                                  date_list[32] == "1" ||
                                                          date_list[32] ==
                                                              "2" ||
                                                          date_list[32] ==
                                                              "3" ||
                                                          date_list[32] ==
                                                              "4" ||
                                                          date_list[32] ==
                                                              "5" ||
                                                          date_list[32] == "6"
                                                      ? Container()
                                                      : img_list[32] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Image.memory(
                                                                  img_list[32]
                                                                      as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[33]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[33],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[33]}"),
                                                  date_list[33] == "1" ||
                                                          date_list[33] ==
                                                              "2" ||
                                                          date_list[33] ==
                                                              "3" ||
                                                          date_list[33] ==
                                                              "4" ||
                                                          date_list[33] ==
                                                              "5" ||
                                                          date_list[33] == "6"
                                                      ? Container()
                                                      : img_list[33] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Image.memory(
                                                                  img_list[33]
                                                                      as Uint8List)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(date_list[34]);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Calendar_detail(
                                                      date_time: date_list[34],
                                                    )));
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[34]}"),
                                                  date_list[34] == "1" ||
                                                          date_list[34] ==
                                                              "2" ||
                                                          date_list[34] ==
                                                              "3" ||
                                                          date_list[34] ==
                                                              "4" ||
                                                          date_list[34] ==
                                                              "5" ||
                                                          date_list[34] == "6"
                                                      ? Container()
                                                      : img_list[34] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Image.memory(
                                                                  img_list[34]
                                                                      as Uint8List)),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                    daysinmonth.length == 42
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  print(date_list[35]);
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail(
                                                            date_time:
                                                                date_list[35],
                                                          )));
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            "${date_list[35]}"),
                                                        date_list[35] == "1" ||
                                                                date_list[35] ==
                                                                    "2" ||
                                                                date_list[35] ==
                                                                    "3" ||
                                                                date_list[35] ==
                                                                    "4" ||
                                                                date_list[35] ==
                                                                    "5" ||
                                                                date_list[35] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[35] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child: Image.memory(
                                                                        img_list[35]
                                                                            as Uint8List)),
                                                      ],
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  print(date_list[36]);
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail(
                                                            date_time:
                                                                date_list[36],
                                                          )));
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            "${date_list[36]}"),
                                                        date_list[36] == "1" ||
                                                                date_list[36] ==
                                                                    "2" ||
                                                                date_list[36] ==
                                                                    "3" ||
                                                                date_list[36] ==
                                                                    "4" ||
                                                                date_list[36] ==
                                                                    "5" ||
                                                                date_list[36] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[36] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child: Image.memory(
                                                                        img_list[36]
                                                                            as Uint8List)),
                                                      ],
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  print(date_list[37]);
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail(
                                                            date_time:
                                                                date_list[37],
                                                          )));
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            "${date_list[37]}"),
                                                        date_list[37] == "1" ||
                                                                date_list[37] ==
                                                                    "2" ||
                                                                date_list[37] ==
                                                                    "3" ||
                                                                date_list[37] ==
                                                                    "4" ||
                                                                date_list[37] ==
                                                                    "5" ||
                                                                date_list[37] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[37] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child: Image.memory(
                                                                        img_list[37]
                                                                            as Uint8List)),
                                                      ],
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  print(date_list[38]);
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail(
                                                            date_time:
                                                                date_list[38],
                                                          )));
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            "${date_list[38]}"),
                                                        date_list[38] == "1" ||
                                                                date_list[38] ==
                                                                    "2" ||
                                                                date_list[38] ==
                                                                    "3" ||
                                                                date_list[38] ==
                                                                    "4" ||
                                                                date_list[38] ==
                                                                    "5" ||
                                                                date_list[38] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[38] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child: Image.memory(
                                                                        img_list[38]
                                                                            as Uint8List)),
                                                      ],
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  print(date_list[39]);
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail(
                                                            date_time:
                                                                date_list[39],
                                                          )));
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            "${date_list[39]}"),
                                                        date_list[39] == "1" ||
                                                                date_list[39] ==
                                                                    "2" ||
                                                                date_list[39] ==
                                                                    "3" ||
                                                                date_list[39] ==
                                                                    "4" ||
                                                                date_list[39] ==
                                                                    "5" ||
                                                                date_list[39] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[39] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child: Image.memory(
                                                                        img_list[39]
                                                                            as Uint8List)),
                                                      ],
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  print(date_list[40]);
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail(
                                                            date_time:
                                                                date_list[40],
                                                          )));
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            "${date_list[40]}"),
                                                        date_list[40] == "1" ||
                                                                date_list[40] ==
                                                                    "2" ||
                                                                date_list[40] ==
                                                                    "3" ||
                                                                date_list[40] ==
                                                                    "4" ||
                                                                date_list[40] ==
                                                                    "5" ||
                                                                date_list[40] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[40] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child: Image.memory(
                                                                        img_list[40]
                                                                            as Uint8List)),
                                                      ],
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  print(date_list[41]);
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail(
                                                            date_time:
                                                                date_list[41],
                                                          )));
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            "${date_list[41]}"),
                                                        date_list[41] == "1" ||
                                                                date_list[41] ==
                                                                    "2" ||
                                                                date_list[41] ==
                                                                    "3" ||
                                                                date_list[41] ==
                                                                    "4" ||
                                                                date_list[41] ==
                                                                    "5" ||
                                                                date_list[41] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[41] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child: Image.memory(
                                                                        img_list[41]
                                                                            as Uint8List)),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          )
                                        : Container()
                                  ],
                                );
                              }
                            })
                      ],
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: Deliver_Four_Screen(
                            post_or_write: widget.post_or_write,
                            book_page: widget.book_page,
                            book_count: widget.book_count,
                          )));
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
        ));
  }
}
