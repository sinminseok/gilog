import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/Model/post.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../Utils/constants.dart';
import 'calendar_detail.dart';

class Calendar_detail_frame extends StatefulWidget {
  List<POST?> date_list = [];
  String? datetime;
  int? month;
  int? year;

  Calendar_detail_frame({required this.date_list, this.datetime, this.month, this.year});

  @override
  _Calendar_detail_frame createState() => _Calendar_detail_frame();
}

class _Calendar_detail_frame extends State<Calendar_detail_frame> {
  String? date_time;
  int? check;

  add_datetime() {
    //ex)1_9월

    if (widget.month.toString().length == 1) {
      if (widget.datetime!.length == 1) {
        date_time = widget.year.toString() +
            "-0" +
            widget.month.toString() +
            "-0" +
            "${widget.datetime}";
      } else {
        date_time = widget.year.toString() +
            "-0" +
            widget.month.toString() +
            "-" +
            "${widget.datetime}";
      }
    } else {
      if (widget.datetime!.length == 1) {
        date_time = widget.year.toString() +
            "-" +
            widget.month.toString() +
            "-0" +
            "${widget.datetime}";
      } else {
        date_time = widget.year.toString() +
            "-" +
            widget.month.toString() +
            "-" +
            "${widget.datetime}";
      }
    }

    print(date_time);
  }

  _init() {
    for (var i = 0; i < widget.date_list.length; i++) {
      if (widget.date_list[i]!.datetime == date_time) {
        check = i;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    add_datetime();
    _init();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    date_time = null;
    check = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _controller = PageController(initialPage: check!);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //색변경
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.75,
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.date_list.length,
              itemBuilder: (BuildContext context, i) {
                return Calendar_detail(
                    date_time: widget.date_list[i]!.datetime);
              },
            ),
          ),
        ],
      ),
    );
  }
}
