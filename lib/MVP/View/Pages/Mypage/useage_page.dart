import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Utils/constants.dart';

class Useage_page extends StatefulWidget {
  const Useage_page({Key? key}) : super(key: key);

  @override
  _Useage_page createState() => _Useage_page();
}

class _Useage_page extends State<Useage_page> {
  final PageController controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //색변경
          ),
        ),
        body: PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          children: <Widget>[
            Container(
                height: size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/use_info1.png",
                        fit: BoxFit.fitHeight,
                      ),
                      Image.asset(
                        "assets/images/use_info2.png",
                        fit: BoxFit.fitHeight,
                      ),
                      Image.asset(
                        "assets/images/use_info3.png",
                        fit: BoxFit.fitHeight,
                      ),
                      Image.asset(
                        "assets/images/use_info4.png",
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  ),
                )),

          ],
        ));
  }
}
