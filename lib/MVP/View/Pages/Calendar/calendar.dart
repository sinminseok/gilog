import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gilog/Local_DB/Utility.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:gilog/Utils/toast.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../Local_DB/db.dart';
import '../../../Model/post.dart';
import '../../../Presenter/Http/http_presenter.dart';
import 'calendar_detail.dart';
import 'package:date_utils/date_utils.dart' as dt;

import 'calendar_postdetail_test.dart';

class Calendar_Screen extends StatefulWidget {
  @override
  _Calendar_Screen createState() => _Calendar_Screen();
}

class _Calendar_Screen extends State<Calendar_Screen> {
  //해당 달에 포함되는 일 List
  List<String?> date_list = [];
  Future? myfuture;

  //로컬에 기록된 정보 img local url만 담을 함수
  List<POST?> img_list = [];

  //로컬에 저장된 모든 POST 리스트
  List<POST?> has_data_all_POST = [];

  DateTime? now;
  var daysinmonth;

  //init에서 가져올 현재 날짜에 해당하는 달,월
  var this_month;
  var this_year;
  List? img_server;
  List<POST?> test_Data_list = [];

  @override
  void dispose() {
    date_list = [];
    img_list = [];
    has_data_all_POST = [];
    test_Data_list = [];
    super.dispose();
  }

  filter_string_date(String date) {
    if (date.substring(0, 1) == "0") {
      return date.substring(1, 2);
    } else {
      return date;
    }
  }

  var token;

  //해당 날짜에 해당하는 날짜 가져오는 함수
   local_data_filter_year() async {
    img_server = [];
    token = await Http_Presenter().read_token();
    img_server = await Http_Presenter()
        .get_server_image(token, context, this_month, this_year);

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
        // print(img_list[i]!.datetime);
      }

    }


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
    //
    // print("GFDSGERWTE");
    // print(final_list);
    // print("ALALAL");


    return final_list;
  }

  List final_list = [];

  filter_img() async{
    var tokenn = await Http_Presenter().read_token();
    Http_Presenter().get_server_data2(context,tokenn);
  }

  @override
  void initState() {
    img_list = [];
    has_data_all_POST = [];
    test_Data_list = [];
    date_list = [];
    date_list = [];
    get_datetime();
    //get_date_list();
    // local_data_filter_year();
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
              height: size.height * 0.1,
            ),
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
                InkWell(
                  onTap: () async {
                    filter_img();
                  },
                  child: Center(
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
                ),
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
              height: size.height * 0.05,
            ),
            Container(
              width: size.width * 1,
              height: size.height * 0.7,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "일",
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: "gilogfont",
                            fontSize: 20),
                      ),
                      Text(
                        "월",
                        style: TextStyle(fontFamily: "gilogfont", fontSize: 20),
                      ),
                      Text(
                        "화",
                        style: TextStyle(fontFamily: "gilogfont", fontSize: 20),
                      ),
                      Text(
                        "수",
                        style: TextStyle(fontFamily: "gilogfont", fontSize: 20),
                      ),
                      Text(
                        "목",
                        style: TextStyle(fontFamily: "gilogfont", fontSize: 20),
                      ),
                      Text(
                        "금",
                        style: TextStyle(fontFamily: "gilogfont", fontSize: 20),
                      ),
                      Text(
                        "토",
                        style: TextStyle(
                            fontFamily: "gilogfont",
                            fontSize: 20,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  FutureBuilder(
                      future: local_data_filter_year(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (img_list.length == 0) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.connectionState == false) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData == false) {
                          return Center(child: CircularProgressIndicator());
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
                                  ? date_list[6] == "31" || date_list[6] == "30"
                                      ? Container()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (img_list[0] == null) {
                                                  showtoast("기록된 일기가 없습니다");
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail_frame(
                                                            date_list:
                                                                has_data_all_POST,
                                                            datetime:
                                                                date_list[0],
                                                            month: this_month,
                                                            year: this_year,
                                                          )));
                                                }
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
                                                          : img_list[0] == null
                                                              ? Container()
                                                              : Container(
                                                                  width:
                                                                      size.width *
                                                                          0.1,
                                                                  height:
                                                                      size.height *
                                                                          0.07,
                                                                  child: Utility
                                                                      .networkimg(
                                                                          final_list[
                                                                              0],
                                                                          token,
                                                                          size)),
                                                    ],
                                                  )),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (img_list[1] == null) {
                                                  showtoast("기록된 일기가 없습니다");
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail_frame(
                                                            date_list:
                                                                has_data_all_POST,
                                                            datetime:
                                                                date_list[1],
                                                            month: this_month,
                                                            year: this_year,
                                                          )));
                                                }
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
                                                          : img_list[1] == null
                                                              ? Container()
                                                              : Container(
                                                                  width:
                                                                      size.width *
                                                                          0.1,
                                                                  height:
                                                                      size.height *
                                                                          0.07,
                                                                  child: Utility
                                                                      .networkimg(
                                                                          final_list[
                                                                              1],
                                                                          token,
                                                                          size)),
                                                    ],
                                                  )),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (img_list[2] == null) {
                                                  showtoast("기록된 일기가 없습니다");
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail_frame(
                                                            date_list:
                                                                has_data_all_POST,
                                                            datetime:
                                                                date_list[2],
                                                            month: this_month,
                                                            year: this_year,
                                                          )));
                                                }
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
                                                          : img_list[2] == null
                                                              ? Container()
                                                              : Container(
                                                                  width:
                                                                      size.width *
                                                                          0.1,
                                                                  height:
                                                                      size.height *
                                                                          0.07,
                                                                  child: Utility
                                                                      .networkimg(
                                                                          final_list[
                                                                              2],
                                                                          token,
                                                                          size)),
                                                    ],
                                                  )),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (img_list[3] == null) {
                                                  showtoast("기록된 일기가 없습니다");
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail_frame(
                                                            date_list:
                                                                has_data_all_POST,
                                                            datetime:
                                                                date_list[3],
                                                            month: this_month,
                                                            year: this_year,
                                                          )));
                                                }
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
                                                          : img_list[3] == null
                                                              ? Container()
                                                              : Container(
                                                                  width:
                                                                      size.width *
                                                                          0.1,
                                                                  height:
                                                                      size.height *
                                                                          0.07,
                                                                  child: Utility
                                                                      .networkimg(
                                                                          final_list[
                                                                              3],
                                                                          token,
                                                                          size)),
                                                    ],
                                                  )),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (img_list[4] == null) {
                                                  showtoast("기록된 일기가 없습니다");
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail_frame(
                                                            date_list:
                                                                has_data_all_POST,
                                                            datetime:
                                                                date_list[4],
                                                            month: this_month,
                                                            year: this_year,
                                                          )));
                                                }
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
                                                          : img_list[4] == null
                                                              ? Container()
                                                              : Container(
                                                                  width:
                                                                      size.width *
                                                                          0.1,
                                                                  height:
                                                                      size.height *
                                                                          0.07,
                                                                  child: Utility
                                                                      .networkimg(
                                                                          final_list[
                                                                              4],
                                                                          token,
                                                                          size)),
                                                    ],
                                                  )),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (img_list[5] == null) {
                                                  showtoast("기록된 일기가 없습니다");
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail_frame(
                                                            date_list:
                                                                has_data_all_POST,
                                                            datetime:
                                                                date_list[5],
                                                            month: this_month,
                                                            year: this_year,
                                                          )));
                                                }
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
                                                          : img_list[5] == null
                                                              ? Container()
                                                              : Container(
                                                                  width:
                                                                      size.width *
                                                                          0.1,
                                                                  height:
                                                                      size.height *
                                                                          0.07,
                                                                  child: Utility
                                                                      .networkimg(
                                                                          final_list[
                                                                              5],
                                                                          token,
                                                                          size)),
                                                    ],
                                                  )),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (img_list[6] == null) {
                                                  showtoast("기록된 일기가 없습니다");
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              Calendar_detail_frame(
                                                            date_list:
                                                                has_data_all_POST,
                                                            datetime:
                                                                date_list[6],
                                                            month: this_month,
                                                            year: this_year,
                                                          )));
                                                }
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
                                                          : img_list[6] == null
                                                              ? Container()
                                                              : Container(
                                                                  width:
                                                                      size.width *
                                                                          0.1,
                                                                  height:
                                                                      size.height *
                                                                          0.07,
                                                                  child: Utility
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
                                        InkWell(
                                          onTap: () {
                                            if (img_list[0] == null) {
                                              showtoast("기록된 일기가 없습니다");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          Calendar_detail_frame(
                                                        date_list:
                                                            has_data_all_POST,
                                                        datetime: date_list[0],
                                                        month: this_month,
                                                        year: this_year,
                                                      )));
                                            }
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
                                                          date_list[0] == "31"
                                                      ? Container()
                                                      : img_list[0] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Utility
                                                                  .networkimg(
                                                                      final_list[
                                                                          0],
                                                                      token,
                                                                      size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (img_list[1] == null) {
                                              showtoast("기록된 일기가 없습니다");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          Calendar_detail_frame(
                                                        date_list:
                                                            has_data_all_POST,
                                                        datetime: date_list[1],
                                                        month: this_month,
                                                        year: this_year,
                                                      )));
                                            }
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
                                                          date_list[1] == "31"
                                                      ? Container()
                                                      : img_list[1] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Utility
                                                                  .networkimg(
                                                                      final_list[
                                                                          1],
                                                                      token,
                                                                      size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (img_list[2] == null) {
                                              showtoast("기록된 일기가 없습니다");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          Calendar_detail_frame(
                                                        date_list:
                                                            has_data_all_POST,
                                                        datetime: date_list[2],
                                                        month: this_month,
                                                        year: this_year,
                                                      )));
                                            }
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
                                                          date_list[2] == "31"
                                                      ? Container()
                                                      : img_list[2] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Utility
                                                                  .networkimg(
                                                                      final_list[
                                                                          2],
                                                                      token,
                                                                      size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (img_list[3] == null) {
                                              showtoast("기록된 일기가 없습니다");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          Calendar_detail_frame(
                                                        date_list:
                                                            has_data_all_POST,
                                                        datetime: date_list[3],
                                                        month: this_month,
                                                        year: this_year,
                                                      )));
                                            }
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
                                                          date_list[3] == "31"
                                                      ? Container()
                                                      : img_list[3] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Utility
                                                                  .networkimg(
                                                                      final_list[
                                                                          3],
                                                                      token,
                                                                      size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (img_list[4] == null) {
                                              showtoast("기록된 일기가 없습니다");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          Calendar_detail_frame(
                                                        date_list:
                                                            has_data_all_POST,
                                                        datetime: date_list[4],
                                                        month: this_month,
                                                        year: this_year,
                                                      )));
                                            }
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
                                                          date_list[4] == "31"
                                                      ? Container()
                                                      : img_list[4] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Utility
                                                                  .networkimg(
                                                                      final_list[
                                                                          4],
                                                                      token,
                                                                      size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (img_list[5] == null) {
                                              showtoast("기록된 일기가 없습니다");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          Calendar_detail_frame(
                                                        date_list:
                                                            has_data_all_POST,
                                                        datetime: date_list[5],
                                                        month: this_month,
                                                        year: this_year,
                                                      )));
                                            }
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
                                                          date_list[5] == "31"
                                                      ? Container()
                                                      : img_list[5] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Utility
                                                                  .networkimg(
                                                                      final_list[
                                                                          5],
                                                                      token,
                                                                      size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (img_list[6] == null) {
                                              showtoast("기록된 일기가 없습니다");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          Calendar_detail_frame(
                                                        date_list:
                                                            has_data_all_POST,
                                                        datetime: date_list[6],
                                                        month: this_month,
                                                        year: this_year,
                                                      )));
                                            }
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
                                                          date_list[6] == "31"
                                                      ? Container()
                                                      : img_list[6] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Utility
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
                                      if (img_list[7] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[7],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[7],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[8] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[8],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[8],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[9] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[9],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[9],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[10] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[10],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[10],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[11] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[11],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[11],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[12] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[12],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[12],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[13] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[13],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[13],
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
                                      if (img_list[14] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[14],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[14],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[15] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[15],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[15],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[16] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[16],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[16],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[17] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[17],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[17],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[18] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[18],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[18],
                                                        token,
                                                        size))
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[19] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[19],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.height * 0.07,
                                                        child:
                                                            Utility.networkimg(
                                                                final_list[19],
                                                                token,
                                                                size))),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[20] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[20],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[20],
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
                                      if (img_list[21] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[21],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[21],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[22] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[22],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[22],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[23] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[23],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[23],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[24] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[24],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[24],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[25] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[25],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[25],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[26] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[26],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[26],
                                                        token,
                                                        size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[27] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[27],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
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
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.07,
                                                    child: Utility.networkimg(
                                                        final_list[27],
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
                                      if (img_list[28] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[28],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
                                    },
                                    child: Container(
                                        width: size.width * 0.1,
                                        height: size.height * 0.1,
                                        child: Column(
                                          children: [
                                            Text("${date_list[28]}"),
                                            date_list[28] == "1" ||
                                                    date_list[28] == "2" ||
                                                    date_list[28] == "3" ||
                                                    date_list[28] == "4" ||
                                                    date_list[28] == "5" ||
                                                    date_list[28] == "6"
                                                ? Container()
                                                : img_list[28] == null
                                                    ? Container()
                                                    : Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.height * 0.07,
                                                        child:
                                                            Utility.networkimg(
                                                                final_list[28],
                                                                token,
                                                                size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[29] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[29],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
                                    },
                                    child: Container(
                                        width: size.width * 0.1,
                                        height: size.height * 0.1,
                                        child: Column(
                                          children: [
                                            Text("${date_list[29]}"),
                                            date_list[29] == "1" ||
                                                    date_list[29] == "2" ||
                                                    date_list[29] == "3" ||
                                                    date_list[29] == "4" ||
                                                    date_list[29] == "5" ||
                                                    date_list[29] == "6"
                                                ? Container()
                                                : img_list[29] == null
                                                    ? Container()
                                                    : Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.height * 0.07,
                                                        child:
                                                            Utility.networkimg(
                                                                final_list[29],
                                                                token,
                                                                size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[30] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[30],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
                                    },
                                    child: Container(
                                        width: size.width * 0.1,
                                        height: size.height * 0.1,
                                        child: Column(
                                          children: [
                                            Text("${date_list[30]}"),
                                            date_list[30] == "1" ||
                                                    date_list[30] == "2" ||
                                                    date_list[30] == "3" ||
                                                    date_list[30] == "4" ||
                                                    date_list[30] == "5" ||
                                                    date_list[30] == "6"
                                                ? Container()
                                                : img_list[30] == null
                                                    ? Container()
                                                    : Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.height * 0.07,
                                                        child:
                                                            Utility.networkimg(
                                                                final_list[30],
                                                                token,
                                                                size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[31] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[31],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
                                    },
                                    child: Container(
                                        width: size.width * 0.1,
                                        height: size.height * 0.1,
                                        child: Column(
                                          children: [
                                            Text("${date_list[31]}"),
                                            date_list[31] == "1" ||
                                                    date_list[31] == "2" ||
                                                    date_list[31] == "3" ||
                                                    date_list[31] == "4" ||
                                                    date_list[31] == "5" ||
                                                    date_list[31] == "6"
                                                ? Container()
                                                : img_list[31] == null
                                                    ? Container()
                                                    : Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.height * 0.07,
                                                        child:
                                                            Utility.networkimg(
                                                                final_list[31],
                                                                token,
                                                                size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[32] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[32],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
                                    },
                                    child: Container(
                                        width: size.width * 0.1,
                                        height: size.height * 0.1,
                                        child: Column(
                                          children: [
                                            Text("${date_list[32]}"),
                                            date_list[32] == "1" ||
                                                    date_list[32] == "2" ||
                                                    date_list[32] == "3" ||
                                                    date_list[32] == "4" ||
                                                    date_list[32] == "5" ||
                                                    date_list[32] == "6"
                                                ? Container()
                                                : img_list[32] == null
                                                    ? Container()
                                                    : Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.height * 0.07,
                                                        child:
                                                            Utility.networkimg(
                                                                final_list[32],
                                                                token,
                                                                size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[33] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[33],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
                                    },
                                    child: Container(
                                        width: size.width * 0.1,
                                        height: size.height * 0.1,
                                        child: Column(
                                          children: [
                                            Text("${date_list[33]}"),
                                            date_list[33] == "1" ||
                                                    date_list[33] == "2" ||
                                                    date_list[33] == "3" ||
                                                    date_list[33] == "4" ||
                                                    date_list[33] == "5" ||
                                                    date_list[33] == "6"
                                                ? Container()
                                                : img_list[33] == null
                                                    ? Container()
                                                    : Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.height * 0.07,
                                                        child:
                                                            Utility.networkimg(
                                                                final_list[33],
                                                                token,
                                                                size)),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (img_list[34] == null) {
                                        showtoast("기록된 일기가 없습니다");
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Calendar_detail_frame(
                                                  date_list: has_data_all_POST,
                                                  datetime: date_list[34],
                                                  month: this_month,
                                                  year: this_year,
                                                )));
                                      }
                                    },
                                    child: Container(
                                        width: size.width * 0.1,
                                        height: size.height * 0.1,
                                        child: Column(
                                          children: [
                                            Text("${date_list[34]}"),
                                            date_list[34] == "1" ||
                                                    date_list[34] == "2" ||
                                                    date_list[34] == "3" ||
                                                    date_list[34] == "4" ||
                                                    date_list[34] == "5" ||
                                                    date_list[34] == "6"
                                                ? Container()
                                                : img_list[34] == null
                                                    ? Container()
                                                    : Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.height * 0.07,
                                                        child:
                                                            Utility.networkimg(
                                                                final_list[34],
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
                                        InkWell(
                                          onTap: () {
                                            if (img_list[35] == null) {
                                              showtoast("기록된 일기가 없습니다");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          Calendar_detail_frame(
                                                        date_list:
                                                            has_data_all_POST,
                                                        datetime: date_list[35],
                                                        month: this_month,
                                                        year: this_year,
                                                      )));
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[35]}"),
                                                  date_list[35] == "1" ||
                                                          date_list[35] ==
                                                              "2" ||
                                                          date_list[35] ==
                                                              "3" ||
                                                          date_list[35] ==
                                                              "4" ||
                                                          date_list[35] ==
                                                              "5" ||
                                                          date_list[35] == "6"
                                                      ? Container()
                                                      : img_list[35] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Utility
                                                                  .networkimg(
                                                                      final_list[
                                                                          35],
                                                                      token,
                                                                      size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (img_list[36] == null) {
                                              showtoast("기록된 일기가 없습니다");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          Calendar_detail_frame(
                                                        date_list:
                                                            has_data_all_POST,
                                                        datetime: date_list[36],
                                                        month: this_month,
                                                        year: this_year,
                                                      )));
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[36]}"),
                                                  date_list[36] == "1" ||
                                                          date_list[36] ==
                                                              "2" ||
                                                          date_list[36] ==
                                                              "3" ||
                                                          date_list[36] ==
                                                              "4" ||
                                                          date_list[36] ==
                                                              "5" ||
                                                          date_list[36] == "6"
                                                      ? Container()
                                                      : img_list[36] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Utility
                                                                  .networkimg(
                                                                      final_list[
                                                                          36],
                                                                      token,
                                                                      size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (img_list[37] == null) {
                                              showtoast("기록된 일기가 없습니다");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          Calendar_detail_frame(
                                                        date_list:
                                                            has_data_all_POST,
                                                        datetime: date_list[37],
                                                        month: this_month,
                                                        year: this_year,
                                                      )));
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[37]}"),
                                                  date_list[37] == "1" ||
                                                          date_list[37] ==
                                                              "2" ||
                                                          date_list[37] ==
                                                              "3" ||
                                                          date_list[37] ==
                                                              "4" ||
                                                          date_list[37] ==
                                                              "5" ||
                                                          date_list[37] == "6"
                                                      ? Container()
                                                      : img_list[37] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Utility
                                                                  .networkimg(
                                                                      final_list[
                                                                          37],
                                                                      token,
                                                                      size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (img_list[38] == null) {
                                              showtoast("기록된 일기가 없습니다");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          Calendar_detail_frame(
                                                        date_list:
                                                            has_data_all_POST,
                                                        datetime: date_list[38],
                                                        month: this_month,
                                                        year: this_year,
                                                      )));
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[38]}"),
                                                  date_list[38] == "1" ||
                                                          date_list[38] ==
                                                              "2" ||
                                                          date_list[38] ==
                                                              "3" ||
                                                          date_list[38] ==
                                                              "4" ||
                                                          date_list[38] ==
                                                              "5" ||
                                                          date_list[38] == "6"
                                                      ? Container()
                                                      : img_list[38] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Utility
                                                                  .networkimg(
                                                                      final_list[
                                                                          38],
                                                                      token,
                                                                      size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (img_list[39] == null) {
                                              showtoast("기록된 일기가 없습니다");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          Calendar_detail_frame(
                                                        date_list:
                                                            has_data_all_POST,
                                                        datetime: date_list[39],
                                                        month: this_month,
                                                        year: this_year,
                                                      )));
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[39]}"),
                                                  date_list[39] == "1" ||
                                                          date_list[39] ==
                                                              "2" ||
                                                          date_list[39] ==
                                                              "3" ||
                                                          date_list[39] ==
                                                              "4" ||
                                                          date_list[39] ==
                                                              "5" ||
                                                          date_list[39] == "6"
                                                      ? Container()
                                                      : img_list[39] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Utility
                                                                  .networkimg(
                                                                      final_list[
                                                                          39],
                                                                      token,
                                                                      size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (img_list[40] == null) {
                                              showtoast("기록된 일기가 없습니다");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          Calendar_detail_frame(
                                                        date_list:
                                                            has_data_all_POST,
                                                        datetime: date_list[40],
                                                        month: this_month,
                                                        year: this_year,
                                                      )));
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[40]}"),
                                                  date_list[40] == "1" ||
                                                          date_list[40] ==
                                                              "2" ||
                                                          date_list[40] ==
                                                              "3" ||
                                                          date_list[40] ==
                                                              "4" ||
                                                          date_list[40] ==
                                                              "5" ||
                                                          date_list[40] == "6"
                                                      ? Container()
                                                      : img_list[40] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Utility
                                                                  .networkimg(
                                                                      final_list[
                                                                          40],
                                                                      token,
                                                                      size)),
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (img_list[41] == null) {
                                              showtoast("기록된 일기가 없습니다");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          Calendar_detail_frame(
                                                        date_list:
                                                            has_data_all_POST,
                                                        datetime: date_list[41],
                                                        month: this_month,
                                                        year: this_year,
                                                      )));
                                            }
                                          },
                                          child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  Text("${date_list[41]}"),
                                                  date_list[41] == "1" ||
                                                          date_list[41] ==
                                                              "2" ||
                                                          date_list[41] ==
                                                              "3" ||
                                                          date_list[41] ==
                                                              "4" ||
                                                          date_list[41] ==
                                                              "5" ||
                                                          date_list[41] == "6"
                                                      ? Container()
                                                      : img_list[41] == null
                                                          ? Container()
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.07,
                                                              child: Utility
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
                      })
                ],
              ),
            )
          ],
        )));
  }
}
