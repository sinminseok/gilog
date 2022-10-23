import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gilog/MVP/View/Pages/Deliver/deliver_four.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:page_transition/page_transition.dart';

import 'package:date_utils/date_utils.dart' as dt;

import '../../../../Local_DB/Utility.dart';
import '../../../../Local_DB/db.dart';
import '../../../../Utils/toast.dart';
import '../../../Model/post.dart';
import '../../../Presenter/Http/http_presenter.dart';
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
  bool? calendar_0 = false;
  bool? calendar_1 = false;
  bool? calendar_2 = false;
  bool? calendar_3 = false;
  bool? calendar_4 = false;
  bool? calendar_5 = false;
  bool? calendar_6 = false;
  bool? calendar_7 = false;
  bool? calendar_8 = false;
  bool? calendar_9 = false;
  bool? calendar_10 = false;
  bool? calendar_11 = false;
  bool? calendar_12 = false;
  bool? calendar_13 = false;
  bool? calendar_14 = false;
  bool? calendar_15 = false;
  bool? calendar_16 = false;
  bool? calendar_17 = false;
  bool? calendar_18 = false;
  bool? calendar_19 = false;
  bool? calendar_20 = false;
  bool? calendar_21 = false;
  bool? calendar_22 = false;
  bool? calendar_23 = false;
  bool? calendar_24 = false;
  bool? calendar_25 = false;
  bool? calendar_26 = false;
  bool? calendar_27 = false;
  bool? calendar_28 = false;
  bool? calendar_29 = false;
  bool? calendar_30 = false;
  bool? calendar_31 = false;
  bool? calendar_32 = false;
  bool? calendar_33 = false;
  bool? calendar_34 = false;
  bool? calendar_35 = false;
  bool? calendar_36 = false;
  bool? calendar_37 = false;
  bool? calendar_38 = false;
  bool? calendar_39 = false;
  bool? calendar_40 = false;
  bool? calendar_41 = false;

  //
  List<String?> plus_book_page = [];

  //해당 달에 포함되는 일 List
  List<String?> date_list = [];

  //로컬에 기록된 정보 img local url만 담을 함수
  List<POST?> img_list = [];

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

  var token;
  var final_list;

  //해당 날짜에 해당하는 날짜 가져오는 함수

  local_data_filter_year() async {
    img_server = [];
    token = await Http_Presenter().read_token();
    img_server = await Http_Presenter()
        .get_server_image(token, context, this_month, this_year);
    // print(img_server);
    // print("img_serverimg_server");
    test_Data_list = [];

    DBHelper sd = DBHelper();
    sd.database;
    var data = await sd.posts();



    has_data_all_POST = [];

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
          if (has_data_all_POST[i]!.datetime!.substring(5, 7) ==
              this_month.toString()) {
            test_Data_list.add(has_data_all_POST[i]);
          }
        }
      }
    }

    get_date_list();


    final_list = [];
    int j = 0;

    String? filter_month;



    if(this_month.toString().length == 1){
      filter_month = "0"+this_month.toString();
    }else{
      filter_month = this_month.toString();
    }

    for(int i = 0 ;i < img_list.length;i++){
      if(img_list[i]==null){

      }else{
        print(img_list[i]!.datetime);
      }

    }
    print("HAHA");

    for (int i = 0; i < img_list.length; i++) {

      if (img_list[i] == null) {
        final_list.add(null);
      } else {
        if (img_server!.length > j) {
          final_list.add(img_server![j]);
        } else {

        }
        j++;
      }
    }

    print("GFDSGERWTE");
    print(img_list.length);
    print(final_list.length);


    return final_list;
  }

  @override
  void initState() {
    img_list = [];
    has_data_all_POST = [];
    test_Data_list = [];
    date_list = [];
    get_datetime();
    get_date_list();
    local_data_filter_year();

    super.initState();
  }

  @override void dispose() {
    // TODO: implement dispose
    img_list = [];
    has_data_all_POST = [];
    test_Data_list = [];
    date_list = [];
    print("dispose deliver3");

    super.dispose();
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
            if(daysinmonth.length == 42){
              if(0<=i && i<=7){
                if(this_date=="26" || this_date=="27" || this_date=="28" || this_date=="29"||this_date=="30"||this_date=="31"){
                  img_list.add(null);
                  break;
                }

              }if(36<=i && i<=42){


                if(this_date=="1" || this_date=="2" || this_date=="3" || this_date=="4"||this_date=="5"||this_date=="6"){
                  img_list.add(null);
                  break;
                }
              }
            }if(daysinmonth.length == 35){

              if(0<=i && i<=7){

                if(this_date=="26" || this_date=="27" || this_date=="28" || this_date=="29"||this_date=="30"||this_date=="31"){
                  img_list.add(null);
                  break;
                }

              }if(29<=i && i<=35){
                if(this_date=="1" || this_date=="2" || this_date=="3" || this_date=="4"||this_date=="5"||this_date=="6"){
                  img_list.add(null);
                  break;
                }
              }
            }
            img_list.add(test_Data_list[j]);
            break;
          } else {
            if (j == test_Data_list.length - 1) {
              img_list.add(null);
              break;
            }
          }
        } else {
          if (this_date == test_Data_list[j]!.datetime!.substring(8, 10)) {
            if(daysinmonth.length == 42){
              if(0<=i && i<=7){
                if(i=="26" || i=="27" || i=="28" || i=="29"||i=="30"||i=="31"){
                  img_list.add(null);
                  break;
                }

              }if(36<=i && i<=42){
                if(i=="1" || i=="2" || i=="3" || i=="4"||i=="5"||i=="6"){
                  img_list.add(null);
                  print("BBRESK");
                  break;
                }
              }
            }if(daysinmonth.length == 35){

              if(0<=i && i<=7){


                if(this_date=="26" || this_date=="27" || this_date=="28" || this_date=="29"||this_date=="30"||this_date=="31"){
                  print("BREAK");
                  img_list.add(null);
                  break;
                }

              }if(29<=i && i<=35){
                if(this_date=="1" || this_date=="2" || this_date=="3" || this_date=="4"||this_date=="5"||this_date=="6"){
                  img_list.add(null);
                  break;
                }
              }
            }

            img_list.add(test_Data_list[j]);
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
    calendar_0 = false;
    calendar_1 = false;
    calendar_2 = false;
    calendar_3 = false;
    calendar_4 = false;
    calendar_5 = false;
    calendar_6 = false;
    calendar_7 = false;
    calendar_8 = false;
    calendar_9 = false;
    calendar_10 = false;
    calendar_11 = false;
    calendar_12 = false;
    calendar_13 = false;
    calendar_14 = false;
    calendar_15 = false;
    calendar_16 = false;
    calendar_17 = false;
    calendar_18 = false;
    calendar_19 = false;
    calendar_20 = false;
    calendar_21 = false;
    calendar_22 = false;
    calendar_23 = false;
    calendar_24 = false;
    calendar_25 = false;
    calendar_26 = false;
    calendar_27 = false;
    calendar_28 = false;
    calendar_29 = false;
    calendar_30 = false;
    calendar_31 = false;
    calendar_32 = false;
    calendar_33 = false;
    calendar_34 = false;
    calendar_35 = false;
    calendar_36 = false;
    calendar_37 = false;
    calendar_38 = false;
    calendar_39 = false;
    calendar_40 = false;
    calendar_41 = false;
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
    calendar_0 = false;
    calendar_1 = false;
    calendar_2 = false;
    calendar_3 = false;
    calendar_4 = false;
    calendar_5 = false;
    calendar_6 = false;
    calendar_7 = false;
    calendar_8 = false;
    calendar_9 = false;
    calendar_10 = false;
    calendar_11 = false;
    calendar_12 = false;
    calendar_13 = false;
    calendar_14 = false;
    calendar_15 = false;
    calendar_16 = false;
    calendar_17 = false;
    calendar_18 = false;
    calendar_19 = false;
    calendar_20 = false;
    calendar_21 = false;
    calendar_22 = false;
    calendar_23 = false;
    calendar_24 = false;
    calendar_25 = false;
    calendar_26 = false;
    calendar_27 = false;
    calendar_28 = false;
    calendar_29 = false;
    calendar_30 = false;
    calendar_31 = false;
    calendar_32 = false;
    calendar_33 = false;
    calendar_34 = false;
    calendar_35 = false;
    calendar_36 = false;
    calendar_37 = false;
    calendar_38 = false;
    calendar_39 = false;
    calendar_40 = false;
    calendar_41 = false;
  }
  List? img_server;

  List<String?> filiter_list = [];

  test(){
    print(plus_book_page);
    for(var i=0;plus_book_page.length>i;i++){

      if(plus_book_page[i]!.substring(6,7) == "-"){


        if(plus_book_page[i]!.length == 8){
          filiter_list.add(plus_book_page[i]!.substring(0,5)+"0"+plus_book_page[i]!.substring(5,7)+"0"+plus_book_page[i]!.substring(7));
          print(plus_book_page[i]!.substring(0,5)+"0"+plus_book_page[i]!.substring(5,7)+"0"+plus_book_page[i]!.substring(7));

        }else{
          filiter_list.add(plus_book_page[i]!.substring(0,5)+"0"+plus_book_page[i]!.substring(5,7)+plus_book_page[i]!.substring(7));
          print(plus_book_page[i]!.substring(0,5)+"0"+plus_book_page[i]!.substring(5,7)+plus_book_page[i]!.substring(7));
        }
        //1~9월까지
      }else{
        if(plus_book_page[i]!.length == 9){
          //10-12월까지 요일 한자리일때
          filiter_list.add(plus_book_page[i]!.substring(0,8)+"0"+plus_book_page[i]!.substring(8));
          print(plus_book_page[i]!.substring(0,8)+"0"+plus_book_page[i]!.substring(8));
        }else{
          filiter_list.add(plus_book_page[i]);
          print("10-12월까지 요일 두자리일때${plus_book_page[i]}");  //
        }



      }

    }
    print(filiter_list);

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
                        // InkWell(
                        //   onTap: () {
                        //     print(plus_book_page);
                        //   },
                        //   child: Text("GG"),
                        // ),
                        SizedBox(
                          height: size.height * 0.02,
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
                                                          date_list[0] == "31"
                                                      ? InkWell(
                                                          onTap: () {
                                                            showtoast(
                                                                "${this_month}월에 해당하는 요일만 선택해주세요");
                                                          },
                                                          child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${date_list[0]}",
                                                                    style: TextStyle(
                                                                        color: calendar_0 !=
                                                                                false
                                                                            ? Colors.blueAccent
                                                                            : Colors.black87),
                                                                  ),
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
                                                                              width: size.width * 0.1,
                                                                              height: size.height * 0.07,
                                                                              child: Utility
                                                                                  .networkimg(
                                                                                  final_list[
                                                                                  0],
                                                                                  token,
                                                                                  size)),
                                                                ],
                                                              )),
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            if (plus_book_page
                                                                    .indexOf(
                                                                        "${this_year}-${this_month}-${date_list[0]}") !=
                                                                -1) {
                                                              plus_book_page.remove(
                                                                  "${this_year}-${this_month}-${date_list[0]}");
                                                              setState(() {
                                                                calendar_0 =
                                                                    !calendar_0!;
                                                              });
                                                            } else {
                                                              if (plus_book_page
                                                                      .length <
                                                                  widget
                                                                      .book_page!
                                                                      .toInt()) {
                                                                plus_book_page.add(
                                                                    "${this_year}-${this_month}-${date_list[0]}");
                                                                setState(() {
                                                                  calendar_0 =
                                                                      !calendar_0!;
                                                                });
                                                              } else {
                                                                showtoast(
                                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                              }
                                                            }
                                                          },
                                                          child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${date_list[0]}",
                                                                    style: TextStyle(
                                                                        color: calendar_0 !=
                                                                                false
                                                                            ? Colors.blueAccent
                                                                            : Colors.black87),
                                                                  ),
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
                                                                              width: size.width * 0.1,
                                                                              height: size.height * 0.07,
                                                                              child: Utility
                                                                                  .networkimg(
                                                                                  final_list[
                                                                                  0],
                                                                                  token,
                                                                                  size)),
                                                                ],
                                                              )),
                                                        ),
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
                                                          date_list[1] == "31"
                                                      ? InkWell(
                                                          onTap: () {
                                                            showtoast(
                                                                "${this_month}월에 해당하는 요일만 선택해주세요");
                                                          },
                                                          child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${date_list[1]}",
                                                                    style: TextStyle(
                                                                        color: calendar_1 !=
                                                                                false
                                                                            ? Colors.blueAccent
                                                                            : Colors.black87),
                                                                  ),
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
                                                                              width: size.width * 0.1,
                                                                              height: size.height * 0.07,
                                                                              child: Utility
                                                                                  .networkimg(
                                                                                  final_list[
                                                                                  1],
                                                                                  token,
                                                                                  size)),
                                                                ],
                                                              )),
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            if (plus_book_page
                                                                    .indexOf(
                                                                        "${this_year}-${this_month}-${date_list[1]}") !=
                                                                -1) {
                                                              plus_book_page.remove(
                                                                  "${this_year}-${this_month}-${date_list[1]}");
                                                              setState(() {
                                                                calendar_1 =
                                                                    !calendar_1!;
                                                              });
                                                            } else {
                                                              if (plus_book_page
                                                                      .length <
                                                                  widget
                                                                      .book_page!
                                                                      .toInt()) {
                                                                plus_book_page.add(
                                                                    "${this_year}-${this_month}-${date_list[1]}");
                                                                setState(() {
                                                                  calendar_1 =
                                                                      !calendar_1!;
                                                                });
                                                              } else {
                                                                showtoast(
                                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                              }
                                                            }
                                                          },
                                                          child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${date_list[1]}",
                                                                    style: TextStyle(
                                                                        color: calendar_1 !=
                                                                                false
                                                                            ? Colors.blueAccent
                                                                            : Colors.black87),
                                                                  ),
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
                                                                              width: size.width * 0.1,
                                                                              height: size.height * 0.07,
                                                                              child: Utility
                                                                                  .networkimg(
                                                                                  final_list[
                                                                                  1],
                                                                                  token,
                                                                                  size)),
                                                                ],
                                                              )),
                                                        ),
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
                                                          date_list[2] == "31"
                                                      ? InkWell(
                                                          onTap: () {
                                                            showtoast(
                                                                "${this_month}월에 해당하는 요일만 선택해주세요");
                                                          },
                                                          child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${date_list[2]}",
                                                                    style: TextStyle(
                                                                        color: calendar_2 !=
                                                                                false
                                                                            ? Colors.blueAccent
                                                                            : Colors.black87),
                                                                  ),
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
                                                                              width: size.width * 0.1,
                                                                              height: size.height * 0.07,
                                                                              child: Utility
                                                                                  .networkimg(
                                                                                  final_list[
                                                                                  2],
                                                                                  token,
                                                                                  size)),
                                                                ],
                                                              )),
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            if (plus_book_page
                                                                    .indexOf(
                                                                        "${this_year}-${this_month}-${date_list[2]}") !=
                                                                -1) {
                                                              plus_book_page.remove(
                                                                  "${this_year}-${this_month}-${date_list[2]}");
                                                              setState(() {
                                                                calendar_2 =
                                                                    !calendar_2!;
                                                              });
                                                            } else {
                                                              if (plus_book_page
                                                                      .length <
                                                                  widget
                                                                      .book_page!
                                                                      .toInt()) {
                                                                plus_book_page.add(
                                                                    "${this_year}-${this_month}-${date_list[2]}");
                                                                setState(() {
                                                                  calendar_2 =
                                                                      !calendar_2!;
                                                                });
                                                              } else {
                                                                showtoast(
                                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                              }
                                                            }
                                                          },
                                                          child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${date_list[2]}",
                                                                    style: TextStyle(
                                                                        color: calendar_2 !=
                                                                                false
                                                                            ? Colors.blueAccent
                                                                            : Colors.black87),
                                                                  ),
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
                                                                              width: size.width * 0.1,
                                                                              height: size.height * 0.07,
                                                                              child: Utility
                                                                                  .networkimg(
                                                                                  final_list[
                                                                                  2],
                                                                                  token,
                                                                                  size)),
                                                                ],
                                                              )),
                                                        ),
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
                                                          date_list[3] == "31"
                                                      ? InkWell(
                                                          onTap: () {
                                                            showtoast(
                                                                "${this_month}월에 해당하는 요일만 선택해주세요");
                                                          },
                                                          child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${date_list[3]}",
                                                                    style: TextStyle(
                                                                        color: calendar_3 !=
                                                                                false
                                                                            ? Colors.blueAccent
                                                                            : Colors.black87),
                                                                  ),
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
                                                                              width: size.width * 0.1,
                                                                              height: size.height * 0.07,
                                                                              child:Utility
                                                                                  .networkimg(
                                                                                  final_list[
                                                                                  3],
                                                                                  token,
                                                                                  size)),
                                                                ],
                                                              )),
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            if (plus_book_page
                                                                    .indexOf(
                                                                        "${this_year}-${this_month}-${date_list[3]}") !=
                                                                -1) {
                                                              plus_book_page.remove(
                                                                  "${this_year}-${this_month}-${date_list[3]}");
                                                              setState(() {
                                                                calendar_3 =
                                                                    !calendar_3!;
                                                              });
                                                            } else {
                                                              if (plus_book_page
                                                                      .length <
                                                                  widget
                                                                      .book_page!
                                                                      .toInt()) {
                                                                plus_book_page.add(
                                                                    "${this_year}-${this_month}-${date_list[3]}");
                                                                setState(() {
                                                                  calendar_3 =
                                                                      !calendar_3!;
                                                                });
                                                              } else {
                                                                showtoast(
                                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                              }
                                                            }
                                                          },
                                                          child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${date_list[3]}",
                                                                    style: TextStyle(
                                                                        color: calendar_3 !=
                                                                                false
                                                                            ? Colors.blueAccent
                                                                            : Colors.black87),
                                                                  ),
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
                                                                              width: size.width * 0.1,
                                                                              height: size.height * 0.07,
                                                                              child: Utility
                                                                                  .networkimg(
                                                                                  final_list[
                                                                                  3],
                                                                                  token,
                                                                                  size)),
                                                                ],
                                                              )),
                                                        ),
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
                                                          date_list[4] == "31"
                                                      ? InkWell(
                                                          onTap: () {
                                                            showtoast(
                                                                "${this_month}월에 해당하는 요일만 선택해주세요");
                                                          },
                                                          child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${date_list[4]}",
                                                                    style: TextStyle(
                                                                        color: calendar_4 !=
                                                                                false
                                                                            ? Colors.blueAccent
                                                                            : Colors.black87),
                                                                  ),
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
                                                                              width: size.width * 0.1,
                                                                              height: size.height * 0.07,
                                                                              child: Utility
                                                                                  .networkimg(
                                                                                  final_list[
                                                                                  4],
                                                                                  token,
                                                                                  size)),
                                                                ],
                                                              )),
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            if (plus_book_page
                                                                    .indexOf(
                                                                        "${this_year}-${this_month}-${date_list[4]}") !=
                                                                -1) {
                                                              plus_book_page.remove(
                                                                  "${this_year}-${this_month}-${date_list[4]}");
                                                              setState(() {
                                                                calendar_4 =
                                                                    !calendar_4!;
                                                              });
                                                            } else {
                                                              if (plus_book_page
                                                                      .length <
                                                                  widget
                                                                      .book_page!
                                                                      .toInt()) {
                                                                plus_book_page.add(
                                                                    "${this_year}-${this_month}-${date_list[4]}");
                                                                setState(() {
                                                                  calendar_4 =
                                                                      !calendar_4!;
                                                                });
                                                              } else {
                                                                showtoast(
                                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                              }
                                                            }
                                                          },
                                                          child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${date_list[4]}",
                                                                    style: TextStyle(
                                                                        color: calendar_4 !=
                                                                                false
                                                                            ? Colors.blueAccent
                                                                            : Colors.black87),
                                                                  ),
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
                                                                              width: size.width * 0.1,
                                                                              height: size.height * 0.07,
                                                                              child:Utility
                                                                                  .networkimg(
                                                                                  final_list[
                                                                                  4],
                                                                                  token,
                                                                                  size)),
                                                                ],
                                                              )),
                                                        ),
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
                                                          date_list[5] == "31"
                                                      ? InkWell(
                                                          onTap: () {
                                                            showtoast(
                                                                "${this_month}월에 해당하는 요일만 선택해주세요");
                                                          },
                                                          child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${date_list[5]}",
                                                                    style: TextStyle(
                                                                        color: calendar_5 !=
                                                                                false
                                                                            ? Colors.blueAccent
                                                                            : Colors.black87),
                                                                  ),
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
                                                                              width: size.width * 0.1,
                                                                              height: size.height * 0.07,
                                                                              child:Utility
                                                                                  .networkimg(
                                                                                  final_list[
                                                                                  5],
                                                                                  token,
                                                                                  size)),
                                                                ],
                                                              )),
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            if (plus_book_page
                                                                    .indexOf(
                                                                        "${this_year}-${this_month}-${date_list[5]}") !=
                                                                -1) {
                                                              plus_book_page.remove(
                                                                  "${this_year}-${this_month}-${date_list[5]}");
                                                              setState(() {
                                                                calendar_5 =
                                                                    !calendar_5!;
                                                              });
                                                            } else {
                                                              if (plus_book_page
                                                                      .length <
                                                                  widget
                                                                      .book_page!
                                                                      .toInt()) {
                                                                plus_book_page.add(
                                                                    "${this_year}-${this_month}-${date_list[5]}");
                                                                setState(() {
                                                                  calendar_5 =
                                                                      !calendar_5!;
                                                                });
                                                              } else {
                                                                showtoast(
                                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                              }
                                                            }
                                                          },
                                                          child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${date_list[5]}",
                                                                    style: TextStyle(
                                                                        color: calendar_5 !=
                                                                                false
                                                                            ? Colors.blueAccent
                                                                            : Colors.black87),
                                                                  ),
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
                                                                              width: size.width * 0.1,
                                                                              height: size.height * 0.07,
                                                                              child: Utility
                                                                                  .networkimg(
                                                                                  final_list[
                                                                                  5],
                                                                                  token,
                                                                                  size)),
                                                                ],
                                                              )),
                                                        ),
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
                                                          date_list[6] == "31"
                                                      ? InkWell(
                                                          onTap: () {
                                                            showtoast(
                                                                "${this_month}월에 해당하는 요일만 선택해주세요");
                                                          },
                                                          child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${date_list[6]}",
                                                                    style: TextStyle(
                                                                        color: calendar_0 !=
                                                                                false
                                                                            ? Colors.blueAccent
                                                                            : Colors.black87),
                                                                  ),
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
                                                                              width: size.width * 0.1,
                                                                              height: size.height * 0.07,
                                                                              child: Utility
                                                                                  .networkimg(
                                                                                  final_list[
                                                                                  6],
                                                                                  token,
                                                                                  size)),
                                                                ],
                                                              )),
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            if (plus_book_page
                                                                    .indexOf(
                                                                        "${this_year}-${this_month}-${date_list[6]}") !=
                                                                -1) {
                                                              plus_book_page.remove(
                                                                  "${this_year}-${this_month}-${date_list[6]}");
                                                              setState(() {
                                                                calendar_6 =
                                                                    !calendar_6!;
                                                              });
                                                            } else {
                                                              if (plus_book_page
                                                                      .length <
                                                                  widget
                                                                      .book_page!
                                                                      .toInt()) {
                                                                plus_book_page.add(
                                                                    "${this_year}-${this_month}-${date_list[6]}");
                                                                setState(() {
                                                                  calendar_6 =
                                                                      !calendar_6!;
                                                                });
                                                              } else {
                                                                showtoast(
                                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                              }
                                                            }
                                                          },
                                                          child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.1,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${date_list[6]}",
                                                                    style: TextStyle(
                                                                        color: calendar_6 !=
                                                                                false
                                                                            ? Colors.blueAccent
                                                                            : Colors.black87),
                                                                  ),
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
                                                                              width: size.width * 0.1,
                                                                              height: size.height * 0.07,
                                                                              child:Utility
                                                                                  .networkimg(
                                                                                  final_list[
                                                                                  6],
                                                                                  token,
                                                                                  size)),
                                                                ],
                                                              )),
                                                        ),
                                                ],
                                              )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              date_list[0] == "25" ||
                                                      date_list[0] == "26" ||
                                                      date_list[0] == "27" ||
                                                      date_list[0] == "28" ||
                                                      date_list[0] == "29" ||
                                                      date_list[0] == "30" ||
                                                      date_list[0] == "31"
                                                  ? InkWell(
                                                      onTap: () {
                                                        showtoast(
                                                            "${this_month}월에 해당하는 요일만 선택해주세요");
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[0]}",
                                                                style: TextStyle(
                                                                    color: calendar_0 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
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
                                                                  : img_list[0] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              0],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        if (plus_book_page.indexOf(
                                                                "${this_year}-${this_month}-${date_list[0]}") !=
                                                            -1) {
                                                          plus_book_page.remove(
                                                              "${this_year}-${this_month}-${date_list[0]}");
                                                          setState(() {
                                                            calendar_0 =
                                                                !calendar_0!;
                                                          });
                                                        } else {
                                                          if (plus_book_page
                                                                  .length <
                                                              widget.book_page!
                                                                  .toInt()) {
                                                            plus_book_page.add(
                                                                "${this_year}-${this_month}-${date_list[0]}");
                                                            setState(() {
                                                              calendar_0 =
                                                                  !calendar_0!;
                                                            });
                                                          } else {
                                                            showtoast(
                                                                "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[0]}",
                                                                style: TextStyle(
                                                                    color: calendar_0 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
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
                                                                  : img_list[0] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              0],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    ),
                                              date_list[1] == "25" ||
                                                      date_list[1] == "26" ||
                                                      date_list[1] == "27" ||
                                                      date_list[1] == "28" ||
                                                      date_list[1] == "29" ||
                                                      date_list[1] == "30" ||
                                                      date_list[1] == "31"
                                                  ? InkWell(
                                                      onTap: () {
                                                        showtoast(
                                                            "${this_month}월에 해당하는 요일만 선택해주세요");
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[1]}",
                                                                style: TextStyle(
                                                                    color: calendar_1 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
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
                                                                  : img_list[1] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              1],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        if (plus_book_page.indexOf(
                                                                "${this_year}-${this_month}-${date_list[1]}") !=
                                                            -1) {
                                                          plus_book_page.remove(
                                                              "${this_year}-${this_month}-${date_list[1]}");
                                                          setState(() {
                                                            calendar_1 =
                                                                !calendar_1!;
                                                          });
                                                        } else {
                                                          if (plus_book_page
                                                                  .length <
                                                              widget.book_page!
                                                                  .toInt()) {
                                                            plus_book_page.add(
                                                                "${this_year}-${this_month}-${date_list[1]}");
                                                            setState(() {
                                                              calendar_1 =
                                                                  !calendar_1!;
                                                            });
                                                          } else {
                                                            showtoast(
                                                                "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[1]}",
                                                                style: TextStyle(
                                                                    color: calendar_1 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
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
                                                                  : img_list[1] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              1],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    ),
                                              date_list[2] == "25" ||
                                                      date_list[2] == "26" ||
                                                      date_list[2] == "27" ||
                                                      date_list[2] == "28" ||
                                                      date_list[2] == "29" ||
                                                      date_list[2] == "30" ||
                                                      date_list[2] == "31"
                                                  ? InkWell(
                                                      onTap: () {
                                                        showtoast(
                                                            "${this_month}월에 해당하는 요일만 선택해주세요");
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[2]}",
                                                                style: TextStyle(
                                                                    color: calendar_2 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
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
                                                                  : img_list[2] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              2],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        if (plus_book_page.indexOf(
                                                                "${this_year}-${this_month}-${date_list[2]}") !=
                                                            -1) {
                                                          plus_book_page.remove(
                                                              "${this_year}-${this_month}-${date_list[2]}");
                                                          setState(() {
                                                            calendar_2 =
                                                                !calendar_2!;
                                                          });
                                                        } else {
                                                          if (plus_book_page
                                                                  .length <
                                                              widget.book_page!
                                                                  .toInt()) {
                                                            plus_book_page.add(
                                                                "${this_year}-${this_month}-${date_list[2]}");
                                                            setState(() {
                                                              calendar_2 =
                                                                  !calendar_2!;
                                                            });
                                                          } else {
                                                            showtoast(
                                                                "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[2]}",
                                                                style: TextStyle(
                                                                    color: calendar_2 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
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
                                                                  : img_list[2] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              2],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    ),
                                              date_list[3] == "25" ||
                                                      date_list[3] == "26" ||
                                                      date_list[3] == "27" ||
                                                      date_list[3] == "28" ||
                                                      date_list[3] == "29" ||
                                                      date_list[3] == "30" ||
                                                      date_list[3] == "31"
                                                  ? InkWell(
                                                      onTap: () {
                                                        showtoast(
                                                            "${this_month}월에 해당하는 요일만 선택해주세요");
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[3]}",
                                                                style: TextStyle(
                                                                    color: calendar_3 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
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
                                                                  : img_list[3] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              3],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        if (plus_book_page.indexOf(
                                                                "${this_year}-${this_month}-${date_list[3]}") !=
                                                            -1) {
                                                          plus_book_page.remove(
                                                              "${this_year}-${this_month}-${date_list[3]}");
                                                          setState(() {
                                                            calendar_3 =
                                                                !calendar_3!;
                                                          });
                                                        } else {
                                                          if (plus_book_page
                                                                  .length <
                                                              widget.book_page!
                                                                  .toInt()) {
                                                            plus_book_page.add(
                                                                "${this_year}-${this_month}-${date_list[3]}");
                                                            setState(() {
                                                              calendar_3 =
                                                                  !calendar_3!;
                                                            });
                                                          } else {
                                                            showtoast(
                                                                "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[3]}",
                                                                style: TextStyle(
                                                                    color: calendar_3 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
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
                                                                  : img_list[3] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              3],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    ),
                                              date_list[4] == "25" ||
                                                      date_list[4] == "26" ||
                                                      date_list[4] == "27" ||
                                                      date_list[4] == "28" ||
                                                      date_list[4] == "29" ||
                                                      date_list[4] == "30" ||
                                                      date_list[4] == "31"
                                                  ? InkWell(
                                                      onTap: () {
                                                        showtoast(
                                                            "${this_month}월에 해당하는 요일만 선택해주세요");
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[4]}",
                                                                style: TextStyle(
                                                                    color: calendar_4 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
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
                                                                  : img_list[4] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              4],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        if (plus_book_page.indexOf(
                                                                "${this_year}-${this_month}-${date_list[4]}") !=
                                                            -1) {
                                                          plus_book_page.remove(
                                                              "${this_year}-${this_month}-${date_list[4]}");
                                                          setState(() {
                                                            calendar_4 =
                                                                !calendar_4!;
                                                          });
                                                        } else {
                                                          if (plus_book_page
                                                                  .length <
                                                              widget.book_page!
                                                                  .toInt()) {
                                                            plus_book_page.add(
                                                                "${this_year}-${this_month}-${date_list[4]}");
                                                            setState(() {
                                                              calendar_4 =
                                                                  !calendar_4!;
                                                            });
                                                          } else {
                                                            showtoast(
                                                                "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[4]}",
                                                                style: TextStyle(
                                                                    color: calendar_4 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
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
                                                                  : img_list[4] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              4],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    ),
                                              date_list[5] == "25" ||
                                                      date_list[5] == "26" ||
                                                      date_list[5] == "27" ||
                                                      date_list[5] == "28" ||
                                                      date_list[5] == "29" ||
                                                      date_list[5] == "30" ||
                                                      date_list[5] == "31"
                                                  ? InkWell(
                                                      onTap: () {
                                                        showtoast(
                                                            "${this_month}월에 해당하는 요일만 선택해주세요");
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[5]}",
                                                                style: TextStyle(
                                                                    color: calendar_5 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
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
                                                                  : img_list[5] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              5],
                                                                              token,
                                                                              size),
                                                              )],
                                                          )),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        if (plus_book_page.indexOf(
                                                                "${this_year}-${this_month}-${date_list[5]}") !=
                                                            -1) {
                                                          plus_book_page.remove(
                                                              "${this_year}-${this_month}-${date_list[5]}");
                                                          setState(() {
                                                            calendar_5 =
                                                                !calendar_5!;
                                                          });
                                                        } else {
                                                          if (plus_book_page
                                                                  .length <
                                                              widget.book_page!
                                                                  .toInt()) {
                                                            plus_book_page.add(
                                                                "${this_year}-${this_month}-${date_list[5]}");
                                                            setState(() {
                                                              calendar_5 =
                                                                  !calendar_5!;
                                                            });
                                                          } else {
                                                            showtoast(
                                                                "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[5]}",
                                                                style: TextStyle(
                                                                    color: calendar_5 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
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
                                                                  : img_list[5] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              5],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    ),
                                              date_list[6] == "25" ||
                                                      date_list[6] == "26" ||
                                                      date_list[6] == "27" ||
                                                      date_list[6] == "28" ||
                                                      date_list[6] == "29" ||
                                                      date_list[6] == "30" ||
                                                      date_list[6] == "31"
                                                  ? InkWell(
                                                      onTap: () {
                                                        showtoast(
                                                            "${this_month}월에 해당하는 요일만 선택해주세요");
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[6]}",
                                                                style: TextStyle(
                                                                    color: calendar_0 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
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
                                                                  : img_list[6] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              6],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        if (plus_book_page.indexOf(
                                                                "${this_year}-${this_month}-${date_list[6]}") !=
                                                            -1) {
                                                          plus_book_page.remove(
                                                              "${this_year}-${this_month}-${date_list[6]}");
                                                          setState(() {
                                                            calendar_6 =
                                                                !calendar_6!;
                                                          });
                                                        } else {
                                                          if (plus_book_page
                                                                  .length <
                                                              widget.book_page!
                                                                  .toInt()) {
                                                            plus_book_page.add(
                                                                "${this_year}-${this_month}-${date_list[6]}");
                                                            setState(() {
                                                              calendar_6 =
                                                                  !calendar_6!;
                                                            });
                                                          } else {
                                                            showtoast(
                                                                "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[6]}",
                                                                style: TextStyle(
                                                                    color: calendar_6 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
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
                                                                  : img_list[6] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              6],
                                                                              token,
                                                                              size)),
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
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[7]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[7]}");
                                              setState(() {
                                                calendar_7 = !calendar_7!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[7]}");
                                                setState(() {
                                                  calendar_7 = !calendar_7!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[7]}",
                                                    style: TextStyle(
                                                        color: calendar_7 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[7] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              7],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[8]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[8]}");
                                              setState(() {
                                                calendar_8 = !calendar_8!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[8]}");
                                                setState(() {
                                                  calendar_8 = !calendar_8!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[8]}",
                                                    style: TextStyle(
                                                        color: calendar_8 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[8] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              8],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[9]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[9]}");
                                              setState(() {
                                                calendar_9 = !calendar_9!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[9]}");
                                                setState(() {
                                                  calendar_9 = !calendar_9!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[9]}",
                                                    style: TextStyle(
                                                        color: calendar_9 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[9] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              9],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[10]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[10]}");
                                              setState(() {
                                                calendar_10 = !calendar_10!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[10]}");
                                                setState(() {
                                                  calendar_10 = !calendar_10!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[10]}",
                                                    style: TextStyle(
                                                        color: calendar_10 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[10] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              10],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[11]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[11]}");
                                              setState(() {
                                                calendar_11 = !calendar_11!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[11]}");
                                                setState(() {
                                                  calendar_11 = !calendar_11!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[11]}",
                                                    style: TextStyle(
                                                        color: calendar_11 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[11] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child:Utility
                                                              .networkimg(
                                                              final_list[
                                                              11],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[12]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[12]}");
                                              setState(() {
                                                calendar_12 = !calendar_12!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[12]}");
                                                setState(() {
                                                  calendar_12 = !calendar_12!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[12]}",
                                                    style: TextStyle(
                                                        color: calendar_12 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[12] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              12],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[13]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[13]}");
                                              setState(() {
                                                calendar_13 = !calendar_13!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[13]}");
                                                setState(() {
                                                  calendar_13 = !calendar_13!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[13]}",
                                                    style: TextStyle(
                                                        color: calendar_13 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[13] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              13],
                                                              token,
                                                              size)),
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
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[14]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[14]}");
                                              setState(() {
                                                calendar_14 = !calendar_14!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[14]}");
                                                setState(() {
                                                  calendar_14 = !calendar_14!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[14]}",
                                                    style: TextStyle(
                                                        color: calendar_14 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[14] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child:Utility
                                                              .networkimg(
                                                              final_list[
                                                              14],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[15]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[15]}");
                                              setState(() {
                                                calendar_15 = !calendar_15!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[15]}");
                                                setState(() {
                                                  calendar_15 = !calendar_15!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[15]}",
                                                    style: TextStyle(
                                                        color: calendar_15 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[15] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              15],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[16]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[16]}");
                                              setState(() {
                                                calendar_16 = !calendar_16!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[16]}");
                                                setState(() {
                                                  calendar_16 = !calendar_16!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[16]}",
                                                    style: TextStyle(
                                                        color: calendar_16 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[16] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              16],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[17]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[17]}");
                                              setState(() {
                                                calendar_17 = !calendar_17!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[17]}");
                                                setState(() {
                                                  calendar_17 = !calendar_17!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[17]}",
                                                    style: TextStyle(
                                                        color: calendar_17 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[17] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              17],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[18]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[18]}");
                                              setState(() {
                                                calendar_18 = !calendar_18!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[18]}");
                                                setState(() {
                                                  calendar_18 = !calendar_18!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[18]}",
                                                    style: TextStyle(
                                                        color: calendar_18 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[18] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              18],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[19]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[19]}");
                                              setState(() {
                                                calendar_19 = !calendar_19!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[19]}");
                                                setState(() {
                                                  calendar_19 = !calendar_19!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[19]}",
                                                    style: TextStyle(
                                                        color: calendar_19 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[19] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              19],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[20]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[20]}");
                                              setState(() {
                                                calendar_20 = !calendar_20!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[20]}");
                                                setState(() {
                                                  calendar_20 = !calendar_20!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[20]}",
                                                    style: TextStyle(
                                                        color: calendar_20 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[20] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              20],
                                                              token,
                                                              size)),
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
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[21]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[21]}");
                                              setState(() {
                                                calendar_21 = !calendar_21!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[21]}");
                                                setState(() {
                                                  calendar_21 = !calendar_21!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[21]}",
                                                    style: TextStyle(
                                                        color: calendar_21 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[21] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              21],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[22]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[22]}");
                                              setState(() {
                                                calendar_22 = !calendar_22!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[22]}");
                                                setState(() {
                                                  calendar_22 = !calendar_22!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[22]}",
                                                    style: TextStyle(
                                                        color: calendar_22 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[22] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              22],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[23]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[23]}");
                                              setState(() {
                                                calendar_23 = !calendar_23!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[23]}");
                                                setState(() {
                                                  calendar_23 = !calendar_23!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[23]}",
                                                    style: TextStyle(
                                                        color: calendar_23 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[23] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              23],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[24]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[24]}");
                                              setState(() {
                                                calendar_24 = !calendar_24!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[24]}");
                                                setState(() {
                                                  calendar_24 = !calendar_24!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[24]}",
                                                    style: TextStyle(
                                                        color: calendar_24 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[24] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              24],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[25]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[25]}");
                                              setState(() {
                                                calendar_25 = !calendar_25!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[25]}");
                                                setState(() {
                                                  calendar_25 = !calendar_25!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[25]}",
                                                    style: TextStyle(
                                                        color: calendar_25 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[25] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              25],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[26]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[26]}");
                                              setState(() {
                                                calendar_26 = !calendar_26!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[26]}");
                                                setState(() {
                                                  calendar_26 = !calendar_26!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[26]}",
                                                    style: TextStyle(
                                                        color: calendar_26 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[26] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child: Utility
                                                              .networkimg(
                                                              final_list[
                                                              26],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plus_book_page.indexOf(
                                                    "${this_year}-${this_month}-${date_list[27]}") !=
                                                -1) {
                                              plus_book_page.remove(
                                                  "${this_year}-${this_month}-${date_list[27]}");
                                              setState(() {
                                                calendar_27 = !calendar_27!;
                                              });
                                            } else {
                                              if (plus_book_page.length <
                                                  widget.book_page!.toInt()) {
                                                plus_book_page.add(
                                                    "${this_year}-${this_month}-${date_list[27]}");
                                                setState(() {
                                                  calendar_27 = !calendar_27!;
                                                });
                                              } else {
                                                showtoast(
                                                    "${widget.book_page}개의 기록을 모두 선택했습니다");
                                              }
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${date_list[27]}",
                                                    style: TextStyle(
                                                        color: calendar_27 !=
                                                                false
                                                            ? Colors.blueAccent
                                                            : Colors.black87),
                                                  ),
                                                  img_list[27] == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.07,
                                                          child:Utility
                                                              .networkimg(
                                                              final_list[
                                                              27],
                                                              token,
                                                              size)),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        date_list[28] == "1" ||
                                                date_list[28] == "2" ||
                                                date_list[28] == "3" ||
                                                date_list[28] == "4" ||
                                                date_list[28] == "5" ||
                                                date_list[28] == "6"
                                            ? InkWell(
                                                onTap: () {
                                                  showtoast(
                                                      "${this_month}에 포함된 요일을 선택해주세요");
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${date_list[28]}",
                                                          style: TextStyle(
                                                              color: calendar_28 !=
                                                                      false
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors
                                                                      .black87),
                                                        ),
                                                        date_list[28] == "1" ||
                                                                date_list[28] ==
                                                                    "2" ||
                                                                date_list[28] ==
                                                                    "3" ||
                                                                date_list[28] ==
                                                                    "4" ||
                                                                date_list[28] ==
                                                                    "5" ||
                                                                date_list[28] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[28] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child: Utility
                                                                        .networkimg(
                                                                        final_list[
                                                                        28],
                                                                        token,
                                                                        size)),
                                                      ],
                                                    )),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  if (plus_book_page.indexOf(
                                                          "${this_year}-${this_month}-${date_list[28]}") !=
                                                      -1) {
                                                    plus_book_page.remove(
                                                        "${this_year}-${this_month}-${date_list[28]}");
                                                    setState(() {
                                                      calendar_28 =
                                                          !calendar_28!;
                                                    });
                                                  } else {
                                                    if (plus_book_page.length <
                                                        widget.book_page!
                                                            .toInt()) {
                                                      plus_book_page.add(
                                                          "${this_year}-${this_month}-${date_list[28]}");
                                                      setState(() {
                                                        calendar_28 =
                                                            !calendar_28!;
                                                      });
                                                    } else {
                                                      showtoast(
                                                          "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${date_list[28]}",
                                                          style: TextStyle(
                                                              color: calendar_28 !=
                                                                      false
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors
                                                                      .black87),
                                                        ),
                                                        date_list[28] == "1" ||
                                                                date_list[28] ==
                                                                    "2" ||
                                                                date_list[28] ==
                                                                    "3" ||
                                                                date_list[28] ==
                                                                    "4" ||
                                                                date_list[28] ==
                                                                    "5" ||
                                                                date_list[28] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[28] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child:
                                                                    Utility
                                                                        .networkimg(
                                                                        final_list[
                                                                        28],
                                                                        token,
                                                                        size)),
                                                      ],
                                                    )),
                                              ),
                                        date_list[29] == "1" ||
                                                date_list[29] == "2" ||
                                                date_list[29] == "3" ||
                                                date_list[29] == "4" ||
                                                date_list[29] == "5" ||
                                                date_list[29] == "6"
                                            ? InkWell(
                                                onTap: () {
                                                  showtoast(
                                                      "${this_month}에 포함된 요일을 선택해주세요");
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${date_list[29]}",
                                                          style: TextStyle(
                                                              color: calendar_29 !=
                                                                      false
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors
                                                                      .black87),
                                                        ),
                                                        date_list[29] == "1" ||
                                                                date_list[29] ==
                                                                    "2" ||
                                                                date_list[29] ==
                                                                    "3" ||
                                                                date_list[29] ==
                                                                    "4" ||
                                                                date_list[29] ==
                                                                    "5" ||
                                                                date_list[29] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[29] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child:
                                                                    Utility
                                                                        .networkimg(
                                                                        final_list[
                                                                        29],
                                                                        token,
                                                                        size)),
                                                      ],
                                                    )),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  if (plus_book_page.indexOf(
                                                          "${this_year}-${this_month}-${date_list[29]}") !=
                                                      -1) {
                                                    plus_book_page.remove(
                                                        "${this_year}-${this_month}-${date_list[29]}");
                                                    setState(() {
                                                      calendar_29 =
                                                          !calendar_29!;
                                                    });
                                                  } else {
                                                    if (plus_book_page.length <
                                                        widget.book_page!
                                                            .toInt()) {
                                                      plus_book_page.add(
                                                          "${this_year}-${this_month}-${date_list[29]}");
                                                      setState(() {
                                                        calendar_29 =
                                                            !calendar_29!;
                                                      });
                                                    } else {
                                                      showtoast(
                                                          "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${date_list[29]}",
                                                          style: TextStyle(
                                                              color: calendar_29 !=
                                                                      false
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors
                                                                      .black87),
                                                        ),
                                                        date_list[29] == "1" ||
                                                                date_list[29] ==
                                                                    "2" ||
                                                                date_list[29] ==
                                                                    "3" ||
                                                                date_list[29] ==
                                                                    "4" ||
                                                                date_list[29] ==
                                                                    "5" ||
                                                                date_list[29] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[29] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child:
                                                                    Utility
                                                                        .networkimg(
                                                                        final_list[
                                                                        29],
                                                                        token,
                                                                        size)),
                                                      ],
                                                    )),
                                              ),
                                        date_list[30] == "1" ||
                                                date_list[30] == "2" ||
                                                date_list[30] == "3" ||
                                                date_list[30] == "4" ||
                                                date_list[30] == "5" ||
                                                date_list[30] == "6"
                                            ? InkWell(
                                                onTap: () {
                                                  showtoast(
                                                      "${this_month}에 포함된 요일을 선택해주세요");
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${date_list[30]}",
                                                          style: TextStyle(
                                                              color: calendar_30 !=
                                                                      false
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors
                                                                      .black87),
                                                        ),
                                                        date_list[30] == "1" ||
                                                                date_list[30] ==
                                                                    "2" ||
                                                                date_list[30] ==
                                                                    "3" ||
                                                                date_list[30] ==
                                                                    "4" ||
                                                                date_list[30] ==
                                                                    "5" ||
                                                                date_list[30] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[30] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child:
                                                                    Utility
                                                                        .networkimg(
                                                                        final_list[
                                                                        30],
                                                                        token,
                                                                        size)),
                                                      ],
                                                    )),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  if (plus_book_page.indexOf(
                                                          "${this_year}-${this_month}-${date_list[30]}") !=
                                                      -1) {
                                                    plus_book_page.remove(
                                                        "${this_year}-${this_month}-${date_list[30]}");
                                                    setState(() {
                                                      calendar_30 =
                                                          !calendar_30!;
                                                    });
                                                  } else {
                                                    if (plus_book_page.length <
                                                        widget.book_page!
                                                            .toInt()) {
                                                      plus_book_page.add(
                                                          "${this_year}-${this_month}-${date_list[30]}");
                                                      setState(() {
                                                        calendar_30 =
                                                            !calendar_30!;
                                                      });
                                                    } else {
                                                      showtoast(
                                                          "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${date_list[30]}",
                                                          style: TextStyle(
                                                              color: calendar_30 !=
                                                                      false
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors
                                                                      .black87),
                                                        ),
                                                        date_list[30] == "1" ||
                                                                date_list[30] ==
                                                                    "2" ||
                                                                date_list[30] ==
                                                                    "3" ||
                                                                date_list[30] ==
                                                                    "4" ||
                                                                date_list[30] ==
                                                                    "5" ||
                                                                date_list[30] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[30] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child:
                                                                    Utility
                                                                        .networkimg(
                                                                        final_list[
                                                                        30],
                                                                        token,
                                                                        size)),
                                                      ],
                                                    )),
                                              ),
                                        date_list[31] == "1" ||
                                                date_list[31] == "2" ||
                                                date_list[31] == "3" ||
                                                date_list[31] == "4" ||
                                                date_list[31] == "5" ||
                                                date_list[31] == "6"
                                            ? InkWell(
                                                onTap: () {
                                                  showtoast(
                                                      "${this_month}에 포함된 요일을 선택해주세요");
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${date_list[31]}",
                                                          style: TextStyle(
                                                              color: calendar_31 !=
                                                                      false
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors
                                                                      .black87),
                                                        ),
                                                        date_list[31] == "1" ||
                                                                date_list[31] ==
                                                                    "2" ||
                                                                date_list[31] ==
                                                                    "3" ||
                                                                date_list[31] ==
                                                                    "4" ||
                                                                date_list[31] ==
                                                                    "5" ||
                                                                date_list[31] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[31] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child:
                                                                    Utility
                                                                        .networkimg(
                                                                        final_list[
                                                                        31],
                                                                        token,
                                                                        size)),
                                                      ],
                                                    )),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  if (plus_book_page.indexOf(
                                                          "${this_year}-${this_month}-${date_list[31]}") !=
                                                      -1) {
                                                    plus_book_page.remove(
                                                        "${this_year}-${this_month}-${date_list[31]}");
                                                    setState(() {
                                                      calendar_31 =
                                                          !calendar_31!;
                                                    });
                                                  } else {
                                                    if (plus_book_page.length <
                                                        widget.book_page!
                                                            .toInt()) {
                                                      plus_book_page.add(
                                                          "${this_year}-${this_month}-${date_list[31]}");
                                                      setState(() {
                                                        calendar_31 =
                                                            !calendar_31!;
                                                      });
                                                    } else {
                                                      showtoast(
                                                          "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${date_list[31]}",
                                                          style: TextStyle(
                                                              color: calendar_31 !=
                                                                      false
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors
                                                                      .black87),
                                                        ),
                                                        date_list[31] == "1" ||
                                                                date_list[31] ==
                                                                    "2" ||
                                                                date_list[31] ==
                                                                    "3" ||
                                                                date_list[31] ==
                                                                    "4" ||
                                                                date_list[31] ==
                                                                    "5" ||
                                                                date_list[31] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[31] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child:
                                                                    Utility
                                                                        .networkimg(
                                                                        final_list[
                                                                        31],
                                                                        token,
                                                                        size)),
                                                      ],
                                                    )),
                                              ),
                                        date_list[32] == "1" ||
                                                date_list[32] == "2" ||
                                                date_list[32] == "3" ||
                                                date_list[32] == "4" ||
                                                date_list[32] == "5" ||
                                                date_list[32] == "6"
                                            ? InkWell(
                                                onTap: () {
                                                  showtoast(
                                                      "${this_month}에 포함된 요일을 선택해주세요");
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${date_list[32]}",
                                                          style: TextStyle(
                                                              color: calendar_32 !=
                                                                      false
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors
                                                                      .black87),
                                                        ),
                                                        date_list[32] == "1" ||
                                                                date_list[32] ==
                                                                    "2" ||
                                                                date_list[32] ==
                                                                    "3" ||
                                                                date_list[32] ==
                                                                    "4" ||
                                                                date_list[32] ==
                                                                    "5" ||
                                                                date_list[32] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[32] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child:
                                                                    Utility
                                                                        .networkimg(
                                                                        final_list[
                                                                        32],
                                                                        token,
                                                                        size)),
                                                      ],
                                                    )),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  if (plus_book_page.indexOf(
                                                          "${this_year}-${this_month}-${date_list[32]}") !=
                                                      -1) {
                                                    plus_book_page.remove(
                                                        "${this_year}-${this_month}-${date_list[32]}");
                                                    setState(() {
                                                      calendar_32 =
                                                          !calendar_32!;
                                                    });
                                                  } else {
                                                    if (plus_book_page.length <
                                                        widget.book_page!
                                                            .toInt()) {
                                                      plus_book_page.add(
                                                          "${this_year}-${this_month}-${date_list[32]}");
                                                      setState(() {
                                                        calendar_32 =
                                                            !calendar_32!;
                                                      });
                                                    } else {
                                                      showtoast(
                                                          "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${date_list[32]}",
                                                          style: TextStyle(
                                                              color: calendar_32 !=
                                                                      false
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors
                                                                      .black87),
                                                        ),
                                                        date_list[32] == "1" ||
                                                                date_list[32] ==
                                                                    "2" ||
                                                                date_list[32] ==
                                                                    "3" ||
                                                                date_list[32] ==
                                                                    "4" ||
                                                                date_list[32] ==
                                                                    "5" ||
                                                                date_list[32] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[32] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child:
                                                                    Utility
                                                                        .networkimg(
                                                                        final_list[
                                                                        32],
                                                                        token,
                                                                        size)),
                                                      ],
                                                    )),
                                              ),
                                        date_list[33] == "1" ||
                                                date_list[33] == "2" ||
                                                date_list[33] == "3" ||
                                                date_list[33] == "4" ||
                                                date_list[33] == "5" ||
                                                date_list[33] == "6"
                                            ? InkWell(
                                                onTap: () {
                                                  showtoast(
                                                      "${this_month}에 포함된 요일을 선택해주세요");
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${date_list[33]}",
                                                          style: TextStyle(
                                                              color: calendar_33 !=
                                                                      false
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors
                                                                      .black87),
                                                        ),
                                                        date_list[33] == "1" ||
                                                                date_list[33] ==
                                                                    "2" ||
                                                                date_list[33] ==
                                                                    "3" ||
                                                                date_list[33] ==
                                                                    "4" ||
                                                                date_list[33] ==
                                                                    "5" ||
                                                                date_list[33] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[33] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child:
                                                                    Utility
                                                                        .networkimg(
                                                                        final_list[
                                                                        33],
                                                                        token,
                                                                        size)),
                                                      ],
                                                    )),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  if (plus_book_page.indexOf(
                                                          "${this_year}-${this_month}-${date_list[33]}") !=
                                                      -1) {
                                                    plus_book_page.remove(
                                                        "${this_year}-${this_month}-${date_list[33]}");
                                                    setState(() {
                                                      calendar_33 =
                                                          !calendar_33!;
                                                    });
                                                  } else {
                                                    if (plus_book_page.length <
                                                        widget.book_page!
                                                            .toInt()) {
                                                      plus_book_page.add(
                                                          "${this_year}-${this_month}-${date_list[33]}");
                                                      setState(() {
                                                        calendar_33 =
                                                            !calendar_33!;
                                                      });
                                                    } else {
                                                      showtoast(
                                                          "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${date_list[33]}",
                                                          style: TextStyle(
                                                              color: calendar_33 !=
                                                                      false
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors
                                                                      .black87),
                                                        ),
                                                        date_list[33] == "1" ||
                                                                date_list[33] ==
                                                                    "2" ||
                                                                date_list[33] ==
                                                                    "3" ||
                                                                date_list[33] ==
                                                                    "4" ||
                                                                date_list[33] ==
                                                                    "5" ||
                                                                date_list[33] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[33] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child:
                                                                    Utility
                                                                        .networkimg(
                                                                        final_list[
                                                                        33],
                                                                        token,
                                                                        size)),
                                                      ],
                                                    )),
                                              ),
                                        date_list[34] == "1" ||
                                                date_list[34] == "2" ||
                                                date_list[34] == "3" ||
                                                date_list[34] == "4" ||
                                                date_list[34] == "5" ||
                                                date_list[34] == "6"
                                            ? InkWell(
                                                onTap: () {
                                                  showtoast(
                                                      "${this_month}에 포함된 요일을 선택해주세요");
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${date_list[34]}",
                                                          style: TextStyle(
                                                              color: calendar_34 !=
                                                                      false
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors
                                                                      .black87),
                                                        ),
                                                        date_list[34] == "1" ||
                                                                date_list[34] ==
                                                                    "2" ||
                                                                date_list[34] ==
                                                                    "3" ||
                                                                date_list[34] ==
                                                                    "4" ||
                                                                date_list[34] ==
                                                                    "5" ||
                                                                date_list[34] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[34] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child:
                                                                    Utility
                                                                        .networkimg(
                                                                        final_list[
                                                                        34],
                                                                        token,
                                                                        size)),
                                                      ],
                                                    )),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  if (plus_book_page.indexOf(
                                                          "${this_year}-${this_month}-${date_list[34]}") !=
                                                      -1) {
                                                    plus_book_page.remove(
                                                        "${this_year}-${this_month}-${date_list[34]}");
                                                    setState(() {
                                                      calendar_34 =
                                                          !calendar_34!;
                                                    });
                                                  } else {
                                                    if (plus_book_page.length <
                                                        widget.book_page!
                                                            .toInt()) {
                                                      plus_book_page.add(
                                                          "${this_year}-${this_month}-${date_list[34]}");
                                                      setState(() {
                                                        calendar_34 =
                                                            !calendar_34!;
                                                      });
                                                    } else {
                                                      showtoast(
                                                          "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${date_list[34]}",
                                                          style: TextStyle(
                                                              color: calendar_34 !=
                                                                      false
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors
                                                                      .black87),
                                                        ),
                                                        date_list[34] == "1" ||
                                                                date_list[34] ==
                                                                    "2" ||
                                                                date_list[34] ==
                                                                    "3" ||
                                                                date_list[34] ==
                                                                    "4" ||
                                                                date_list[34] ==
                                                                    "5" ||
                                                                date_list[34] ==
                                                                    "6"
                                                            ? Container()
                                                            : img_list[34] ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    width:
                                                                        size.width *
                                                                            0.1,
                                                                    height: size
                                                                            .height *
                                                                        0.07,
                                                                    child:
                                                                    Utility
                                                                        .networkimg(
                                                                        final_list[
                                                                        34],
                                                                        token,
                                                                        size)),
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
                                              date_list[35] == "1" ||
                                                      date_list[35] == "2" ||
                                                      date_list[35] == "3" ||
                                                      date_list[35] == "4" ||
                                                      date_list[35] == "5" ||
                                                      date_list[35] == "6"
                                                  ? InkWell(
                                                      onTap: () {
                                                        showtoast(
                                                            "${this_month}월에 포함된 요일을 선택해주세요!");
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[35]}",
                                                                style: TextStyle(
                                                                    color: calendar_35 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
                                                              date_list[35] ==
                                                                          "1" ||
                                                                      date_list[
                                                                              35] ==
                                                                          "2" ||
                                                                      date_list[
                                                                              35] ==
                                                                          "3" ||
                                                                      date_list[
                                                                              35] ==
                                                                          "4" ||
                                                                      date_list[
                                                                              35] ==
                                                                          "5" ||
                                                                      date_list[
                                                                              35] ==
                                                                          "6"
                                                                  ? Container()
                                                                  : img_list[35] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              35],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        if (plus_book_page.indexOf(
                                                                "${this_year}-${this_month}-${date_list[35]}") !=
                                                            -1) {
                                                          plus_book_page.remove(
                                                              "${this_year}-${this_month}-${date_list[35]}");
                                                          setState(() {
                                                            calendar_35 =
                                                                !calendar_35!;
                                                          });
                                                        } else {
                                                          if (plus_book_page
                                                                  .length <
                                                              widget.book_page!
                                                                  .toInt()) {
                                                            plus_book_page.add(
                                                                "${this_year}-${this_month}-${date_list[35]}");
                                                            setState(() {
                                                              calendar_35 =
                                                                  !calendar_35!;
                                                            });
                                                          } else {
                                                            showtoast(
                                                                "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[35]}",
                                                                style: TextStyle(
                                                                    color: calendar_35 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
                                                              date_list[35] ==
                                                                          "1" ||
                                                                      date_list[
                                                                              35] ==
                                                                          "2" ||
                                                                      date_list[
                                                                              35] ==
                                                                          "3" ||
                                                                      date_list[
                                                                              35] ==
                                                                          "4" ||
                                                                      date_list[
                                                                              35] ==
                                                                          "5" ||
                                                                      date_list[
                                                                              35] ==
                                                                          "6"
                                                                  ? Container()
                                                                  : img_list[35] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              35],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    ),
                                              date_list[36] == "1" ||
                                                      date_list[36] == "2" ||
                                                      date_list[36] == "3" ||
                                                      date_list[36] == "4" ||
                                                      date_list[36] == "5" ||
                                                      date_list[36] == "6"
                                                  ? InkWell(
                                                      onTap: () {
                                                        showtoast(
                                                            "${this_month}월에 포함된 요일을 선택해주세요!");
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[36]}",
                                                                style: TextStyle(
                                                                    color: calendar_36 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
                                                              date_list[36] ==
                                                                          "1" ||
                                                                      date_list[
                                                                              36] ==
                                                                          "2" ||
                                                                      date_list[
                                                                              36] ==
                                                                          "3" ||
                                                                      date_list[
                                                                              36] ==
                                                                          "4" ||
                                                                      date_list[
                                                                              36] ==
                                                                          "5" ||
                                                                      date_list[
                                                                              36] ==
                                                                          "6"
                                                                  ? Container()
                                                                  : img_list[36] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              36],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        if (plus_book_page.indexOf(
                                                                "${this_year}-${this_month}-${date_list[36]}") !=
                                                            -1) {
                                                          plus_book_page.remove(
                                                              "${this_year}-${this_month}-${date_list[36]}");
                                                          setState(() {
                                                            calendar_36 =
                                                                !calendar_36!;
                                                          });
                                                        } else {
                                                          if (plus_book_page
                                                                  .length <
                                                              widget.book_page!
                                                                  .toInt()) {
                                                            plus_book_page.add(
                                                                "${this_year}-${this_month}-${date_list[36]}");
                                                            setState(() {
                                                              calendar_36 =
                                                                  !calendar_36!;
                                                            });
                                                          } else {
                                                            showtoast(
                                                                "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[36]}",
                                                                style: TextStyle(
                                                                    color: calendar_36 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
                                                              date_list[36] ==
                                                                          "1" ||
                                                                      date_list[
                                                                              36] ==
                                                                          "2" ||
                                                                      date_list[
                                                                              36] ==
                                                                          "3" ||
                                                                      date_list[
                                                                              36] ==
                                                                          "4" ||
                                                                      date_list[
                                                                              36] ==
                                                                          "5" ||
                                                                      date_list[
                                                                              36] ==
                                                                          "6"
                                                                  ? Container()
                                                                  : img_list[36] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              36],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    ),
                                              date_list[37] == "1" ||
                                                      date_list[37] == "2" ||
                                                      date_list[37] == "3" ||
                                                      date_list[37] == "4" ||
                                                      date_list[37] == "5" ||
                                                      date_list[37] == "6"
                                                  ? InkWell(
                                                      onTap: () {
                                                        showtoast(
                                                            "${this_month}월에 포함된 요일을 선택해주세요!");
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[37]}",
                                                                style: TextStyle(
                                                                    color: calendar_37 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
                                                              date_list[37] ==
                                                                          "1" ||
                                                                      date_list[
                                                                              37] ==
                                                                          "2" ||
                                                                      date_list[
                                                                              37] ==
                                                                          "3" ||
                                                                      date_list[
                                                                              37] ==
                                                                          "4" ||
                                                                      date_list[
                                                                              37] ==
                                                                          "5" ||
                                                                      date_list[
                                                                              37] ==
                                                                          "6"
                                                                  ? Container()
                                                                  : img_list[37] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              37],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        if (plus_book_page.indexOf(
                                                                "${this_year}-${this_month}-${date_list[37]}") !=
                                                            -1) {
                                                          plus_book_page.remove(
                                                              "${this_year}-${this_month}-${date_list[37]}");
                                                          setState(() {
                                                            calendar_37 =
                                                                !calendar_37!;
                                                          });
                                                        } else {
                                                          if (plus_book_page
                                                                  .length <
                                                              widget.book_page!
                                                                  .toInt()) {
                                                            plus_book_page.add(
                                                                "${this_year}-${this_month}-${date_list[37]}");
                                                            setState(() {
                                                              calendar_37 =
                                                                  !calendar_37!;
                                                            });
                                                          } else {
                                                            showtoast(
                                                                "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[37]}",
                                                                style: TextStyle(
                                                                    color: calendar_37 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
                                                              date_list[37] ==
                                                                          "1" ||
                                                                      date_list[
                                                                              37] ==
                                                                          "2" ||
                                                                      date_list[
                                                                              37] ==
                                                                          "3" ||
                                                                      date_list[
                                                                              37] ==
                                                                          "4" ||
                                                                      date_list[
                                                                              37] ==
                                                                          "5" ||
                                                                      date_list[
                                                                              37] ==
                                                                          "6"
                                                                  ? Container()
                                                                  : img_list[37] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              37],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    ),
                                              date_list[38] == "1" ||
                                                      date_list[38] == "2" ||
                                                      date_list[38] == "3" ||
                                                      date_list[38] == "4" ||
                                                      date_list[38] == "5" ||
                                                      date_list[38] == "6"
                                                  ? InkWell(
                                                      onTap: () {
                                                        showtoast(
                                                            "${this_month}월에 포함된 요일을 선택해주세요!");
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[38]}",
                                                                style: TextStyle(
                                                                    color: calendar_38 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
                                                              date_list[38] ==
                                                                          "1" ||
                                                                      date_list[
                                                                              38] ==
                                                                          "2" ||
                                                                      date_list[
                                                                              38] ==
                                                                          "3" ||
                                                                      date_list[
                                                                              38] ==
                                                                          "4" ||
                                                                      date_list[
                                                                              38] ==
                                                                          "5" ||
                                                                      date_list[
                                                                              38] ==
                                                                          "6"
                                                                  ? Container()
                                                                  : img_list[38] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              38],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        if (plus_book_page.indexOf(
                                                                "${this_year}-${this_month}-${date_list[38]}") !=
                                                            -1) {
                                                          plus_book_page.remove(
                                                              "${this_year}-${this_month}-${date_list[38]}");
                                                          setState(() {
                                                            calendar_38 =
                                                                !calendar_38!;
                                                          });
                                                        } else {
                                                          if (plus_book_page
                                                                  .length <
                                                              widget.book_page!
                                                                  .toInt()) {
                                                            plus_book_page.add(
                                                                "${this_year}-${this_month}-${date_list[38]}");
                                                            setState(() {
                                                              calendar_38 =
                                                                  !calendar_38!;
                                                            });
                                                          } else {
                                                            showtoast(
                                                                "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[38]}",
                                                                style: TextStyle(
                                                                    color: calendar_38 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
                                                              date_list[38] ==
                                                                          "1" ||
                                                                      date_list[
                                                                              38] ==
                                                                          "2" ||
                                                                      date_list[
                                                                              38] ==
                                                                          "3" ||
                                                                      date_list[
                                                                              38] ==
                                                                          "4" ||
                                                                      date_list[
                                                                              38] ==
                                                                          "5" ||
                                                                      date_list[
                                                                              38] ==
                                                                          "6"
                                                                  ? Container()
                                                                  : img_list[38] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              38],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    ),
                                              date_list[39] == "1" ||
                                                      date_list[39] == "2" ||
                                                      date_list[39] == "3" ||
                                                      date_list[39] == "4" ||
                                                      date_list[39] == "5" ||
                                                      date_list[39] == "6"
                                                  ? InkWell(
                                                      onTap: () {
                                                        showtoast(
                                                            "${this_month}월에 포함된 요일을 선택해주세요!");
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[39]}",
                                                                style: TextStyle(
                                                                    color: calendar_35 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
                                                              date_list[39] ==
                                                                          "1" ||
                                                                      date_list[
                                                                              39] ==
                                                                          "2" ||
                                                                      date_list[
                                                                              39] ==
                                                                          "3" ||
                                                                      date_list[
                                                                              39] ==
                                                                          "4" ||
                                                                      date_list[
                                                                              39] ==
                                                                          "5" ||
                                                                      date_list[
                                                                              39] ==
                                                                          "6"
                                                                  ? Container()
                                                                  : img_list[39] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              39],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        if (plus_book_page.indexOf(
                                                                "${this_year}-${this_month}-${date_list[39]}") !=
                                                            -1) {
                                                          plus_book_page.remove(
                                                              "${this_year}-${this_month}-${date_list[39]}");
                                                          setState(() {
                                                            calendar_39 =
                                                                !calendar_39!;
                                                          });
                                                        } else {
                                                          if (plus_book_page
                                                                  .length <
                                                              widget.book_page!
                                                                  .toInt()) {
                                                            plus_book_page.add(
                                                                "${this_year}-${this_month}-${date_list[39]}");
                                                            setState(() {
                                                              calendar_39 =
                                                                  !calendar_39!;
                                                            });
                                                          } else {
                                                            showtoast(
                                                                "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[39]}",
                                                                style: TextStyle(
                                                                    color: calendar_39 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
                                                              date_list[39] ==
                                                                          "1" ||
                                                                      date_list[
                                                                              39] ==
                                                                          "2" ||
                                                                      date_list[
                                                                              39] ==
                                                                          "3" ||
                                                                      date_list[
                                                                              39] ==
                                                                          "4" ||
                                                                      date_list[
                                                                              39] ==
                                                                          "5" ||
                                                                      date_list[
                                                                              39] ==
                                                                          "6"
                                                                  ? Container()
                                                                  : img_list[39] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              39],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    ),
                                              date_list[40] == "1" ||
                                                      date_list[40] == "2" ||
                                                      date_list[40] == "3" ||
                                                      date_list[40] == "4" ||
                                                      date_list[40] == "5" ||
                                                      date_list[40] == "6"
                                                  ? InkWell(
                                                      onTap: () {
                                                        showtoast(
                                                            "${this_month}월에 포함된 요일을 선택해주세요!");
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[40]}",
                                                                style: TextStyle(
                                                                    color: calendar_40 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
                                                              date_list[40] ==
                                                                          "1" ||
                                                                      date_list[
                                                                              40] ==
                                                                          "2" ||
                                                                      date_list[
                                                                              40] ==
                                                                          "3" ||
                                                                      date_list[
                                                                              40] ==
                                                                          "4" ||
                                                                      date_list[
                                                                              40] ==
                                                                          "5" ||
                                                                      date_list[
                                                                              40] ==
                                                                          "6"
                                                                  ? Container()
                                                                  : img_list[40] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              40],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        if (plus_book_page.indexOf(
                                                                "${this_year}-${this_month}-${date_list[40]}") !=
                                                            -1) {
                                                          plus_book_page.remove(
                                                              "${this_year}-${this_month}-${date_list[40]}");
                                                          setState(() {
                                                            calendar_40 =
                                                                !calendar_40!;
                                                          });
                                                        } else {
                                                          if (plus_book_page
                                                                  .length <
                                                              widget.book_page!
                                                                  .toInt()) {
                                                            plus_book_page.add(
                                                                "${this_year}-${this_month}-${date_list[40]}");
                                                            setState(() {
                                                              calendar_40 =
                                                                  !calendar_40!;
                                                            });
                                                          } else {
                                                            showtoast(
                                                                "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[40]}",
                                                                style: TextStyle(
                                                                    color: calendar_40 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
                                                              date_list[40] ==
                                                                          "1" ||
                                                                      date_list[
                                                                              40] ==
                                                                          "2" ||
                                                                      date_list[
                                                                              40] ==
                                                                          "3" ||
                                                                      date_list[
                                                                              40] ==
                                                                          "4" ||
                                                                      date_list[
                                                                              40] ==
                                                                          "5" ||
                                                                      date_list[
                                                                              40] ==
                                                                          "6"
                                                                  ? Container()
                                                                  : img_list[40] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              40],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    ),
                                              date_list[41] == "1" ||
                                                      date_list[41] == "2" ||
                                                      date_list[41] == "3" ||
                                                      date_list[41] == "4" ||
                                                      date_list[41] == "5" ||
                                                      date_list[41] == "6"
                                                  ? InkWell(
                                                      onTap: () {
                                                        showtoast(
                                                            "${this_month}월에 포함된 요일을 선택해주세요!");
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[41]}",
                                                                style: TextStyle(
                                                                    color: calendar_41 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
                                                              date_list[41] ==
                                                                          "1" ||
                                                                      date_list[
                                                                              41] ==
                                                                          "2" ||
                                                                      date_list[
                                                                              41] ==
                                                                          "3" ||
                                                                      date_list[
                                                                              41] ==
                                                                          "4" ||
                                                                      date_list[
                                                                              41] ==
                                                                          "5" ||
                                                                      date_list[
                                                                              41] ==
                                                                          "6"
                                                                  ? Container()
                                                                  : img_list[41] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              41],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        if (plus_book_page.indexOf(
                                                                "${this_year}-${this_month}-${date_list[41]}") !=
                                                            -1) {
                                                          plus_book_page.remove(
                                                              "${this_year}-${this_month}-${date_list[41]}");
                                                          setState(() {
                                                            calendar_41 =
                                                                !calendar_41!;
                                                          });
                                                        } else {
                                                          if (plus_book_page
                                                                  .length <
                                                              widget.book_page!
                                                                  .toInt()) {
                                                            plus_book_page.add(
                                                                "${this_year}-${this_month}-${date_list[41]}");
                                                            setState(() {
                                                              calendar_41 =
                                                                  !calendar_41!;
                                                            });
                                                          } else {
                                                            showtoast(
                                                                "${widget.book_page}개의 기록을 모두 선택했습니다");
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width:
                                                              size.width * 0.1,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${date_list[41]}",
                                                                style: TextStyle(
                                                                    color: calendar_41 !=
                                                                            false
                                                                        ? Colors
                                                                            .blueAccent
                                                                        : Colors
                                                                            .black87),
                                                              ),
                                                              date_list[41] ==
                                                                          "1" ||
                                                                      date_list[
                                                                              41] ==
                                                                          "2" ||
                                                                      date_list[
                                                                              41] ==
                                                                          "3" ||
                                                                      date_list[
                                                                              41] ==
                                                                          "4" ||
                                                                      date_list[
                                                                              41] ==
                                                                          "5" ||
                                                                      date_list[
                                                                              41] ==
                                                                          "6"
                                                                  ? Container()
                                                                  : img_list[41] ==
                                                                          null
                                                                      ? Container()
                                                                      : Container(
                                                                          width: size.width *
                                                                              0.1,
                                                                          height: size.height *
                                                                              0.07,
                                                                          child:
                                                                          Utility
                                                                              .networkimg(
                                                                              final_list[
                                                                              41],
                                                                              token,
                                                                              size)),
                                                            ],
                                                          )),
                                                    ),
                                            ],
                                          )
                                        : Container()
                                  ],
                                );
                              }
                            }),

                      ],
                    ),
                  ),
                  InkWell(
                      onTap: (){
                       showAlertDialog(context, "선택한 요일", "${plus_book_page}");
                      },
                      child: Text("선택한 요일 : ${plus_book_page.length}",style: TextStyle(fontFamily: "gilogfont",fontSize: 21),)),

                  SizedBox(height: size.height*0.01,),


                ],
              ),

              InkWell(
                onTap: () {
                  if(plus_book_page.length < widget.book_page!.toInt()){
                    showtoast("${widget.book_page}개의 기록을 선택해주세요!");
                  }else{

                    test();

                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: Deliver_Four_Screen(
                              post_or_write: widget.post_or_write,
                              book_page: widget.book_page,
                              book_count: widget.book_count,
                              pick_datetime: filiter_list,
                            )));
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
