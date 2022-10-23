import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/Local_DB/Utility.dart';
import 'package:gilog/MVP/Model/post.dart';
import 'package:gilog/MVP/View/Pages/Calendar/calendar_edit.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:gilog/Utils/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as math;
import 'package:extended_image/extended_image.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart';

import '../../../../Local_DB/db.dart';
import '../../../Presenter/Http/http_presenter.dart';

class Calendar_detail extends StatefulWidget {
  int? check;
 // var img_obj;
   //Function? fun;
  String? date_time;
  List<POST?> remember_date_list = [];
  String? remember_datetime;
  int? remember_month;
  int? remember_year;

  Calendar_detail(
      {
        required this.check,
       // required this.fun,
      //  required this.img_obj,
        required this.date_time,
      required this.remember_date_list,
      required this.remember_datetime,
      required this.remember_month,
      required this.remember_year});

  @override
  _Calendar_detailState createState() => _Calendar_detailState();
}

class _Calendar_detailState extends State<Calendar_detail> {
  POST? this_post;

  // Future? myFuture;

  @override
  void initState() {
    get_datetime_post();
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  var token;
  var img_server;

  //디스크에 저장된 기록 가져오는 함수
  get_datetime_post() async {
    setState(() {
    //  widget.img_obj;
    });


    token = await Http_Presenter().read_token();
    // _content_controller!.dispose();
    DBHelper sd = DBHelper();
    sd.database;
    var data = await sd.posts();

    for (var i = 0; i < data.length; i++) {
      if (data[i].datetime == widget.date_time) {
        this_post = data[i];
      }
    }
    img_server = await Http_Presenter().get_server_image2(token, context);

    // token = await Http_Presenter().read_token();

    return img_server;
  }

  double degrees = 90;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: get_datetime_post(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == false) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData == false) {
              return Center(child: CircularProgressIndicator());
            }
            //error가 발생하게 될 경우 반환하게 되는 부분
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator()),
              );
            } else {
              return Column(
                children: [
                  InkWell(
                    onTap: (){
                      print(img_server);
                    },
                    child: Text(
                      "${widget.date_time} 기-록",
                      style: TextStyle(fontFamily: "gilogfont", fontSize: 24),
                    ),
                  ),
                  Container(
                      height: size.height*0.55,
                      child: Utility.networkimg_detail(img_server[widget.check],token,size)),

                  InkWell(
                    onTap: () {


                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: Calendar_Edit(
                                img_obj: img_server[widget.check],
                                check:widget.check!,
                                this_post: this_post,
                                date_time: widget.date_time,
                                remember_date_list: widget.remember_date_list,
                                remember_datetime: widget.remember_datetime,
                                remember_month: widget.remember_month,
                                remember_year: widget.remember_year,
                              ))).then((value) {
                        setState(() {
                          // refresh state of Page1
                        });
                      });
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 3),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              width: size.width * 0.9,
                              height: size.height * 0.13,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 22.0, left: 20.0),
                                child: Center(
                                    child: Text(
                                  "${this_post!.question}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "gilogfont",
                                      fontSize: 18),
                                )),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: size.width * 0.88),
                            Transform.rotate(
                              angle: degrees * math.pi / -48,
                              child: Container(
                                width: size.width * 0.07,
                                child: Image.asset(
                                    "assets/images/pencil_yellowpng.png"),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                        width: size.width * 0.9,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${this_post!.content}",
                                style: TextStyle(
                                    fontFamily: "gilogfont", fontSize: 20),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
