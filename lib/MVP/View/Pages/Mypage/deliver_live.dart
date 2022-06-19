import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Utils/constants.dart';


class Deliver_liver_page extends StatefulWidget {
  const Deliver_liver_page({Key? key}) : super(key: key);

  @override
  _Deliver_liver_pageState createState() => _Deliver_liver_pageState();
}

class _Deliver_liver_pageState extends State<Deliver_liver_page> {
  @override
  Widget build(BuildContext context) {
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
        children: [
          Center(child: Text("배송조회 페이지", style: TextStyle(fontFamily: "gilogfont", fontSize: 38),))
        ],
      ),
    );
  }
}
