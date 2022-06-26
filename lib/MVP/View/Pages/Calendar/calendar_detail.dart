import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/Model/post.dart';
import 'package:gilog/Utils/constants.dart';
import 'dart:math' as math;

import '../../../../Local_DB/db.dart';

class Calendar_detail extends StatefulWidget {
  String? date_time;

  Calendar_detail({required this.date_time});

  @override
  _Calendar_detailState createState() => _Calendar_detailState();
}

class _Calendar_detailState extends State<Calendar_detail> {
  POST? this_post;

  @override
  void initState() {
    // TODO: implement initState
    //get http datetime detail

    chekc_today_write();
    super.initState();
  }

  chekc_today_write() async {
    DBHelper sd = DBHelper();
    sd.database;
    var data = await sd.posts();

    print(data.length);

    for (var i = 0; i < data.length; i++) {
      if (data[i].datetime == widget.date_time) {
        this_post = data[i];
      }
    }

    return this_post;
  }

  double degrees = 90;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: chekc_today_write(),
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
                  Text(
                    "${widget.date_time} 기-록",
                    style: TextStyle(fontFamily: "gilogfont", fontSize: 24),
                  ),
                  Container(
                    width: size.width * 1,
                    height: size.height * 0.4,
                    child: Image.memory(
                      this_post!.image_url
                      as Uint8List, fit: BoxFit.fitWidth,),
                  ),

                  Stack(
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
                            height: size.height * 0.11,
                            child: Center(
                                child: Text(
                              "${this_post!.question}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "gilogfont",
                                  fontSize: 19),
                            )),
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
                                  "assets/images/yellow_pencil_icon.psd"),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                        width: size.width * 0.9,
                        height: size.height * 0.4,
                        child: Text(
                          "${this_post!.content}",
                          style: TextStyle(fontFamily: "gilogfont", fontSize: 20),
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
