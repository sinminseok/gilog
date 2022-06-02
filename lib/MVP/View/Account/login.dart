import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Utils/constants.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.07),
                  Container(
                    width: size.width * 0.6,
                    child: Image(
                      image:
                      AssetImage('assets/images/smartfill_logo.png'),
                      width: 70,
                    ),
                  ),
                  Container(
                      width: size.width * 0.65,
                      height: size.height * 0.2,
                      child: Image.asset(
                        'assets/gifs/main_img.gif',
                      )),




                  InkWell(
                    onTap: () async {
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        width: size.width * 0.7,
                        height: size.height * 0.2,
                        child: Image.asset(
                          'assets/images/button_login.png',
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
