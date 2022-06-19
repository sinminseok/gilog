import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Utils/constants.dart';


class Useage_page extends StatefulWidget {
  const Useage_page({Key? key}) : super(key: key);

  @override
  _Useage_page createState() => _Useage_page();
}

class _Useage_page extends State<Useage_page> {
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
          Center(child: Text("이용안내", style: TextStyle(fontFamily: "gilogfont", fontSize: 38),))
        ],
      ),
    );
  }
}
