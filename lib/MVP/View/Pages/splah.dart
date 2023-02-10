
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';



class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height*0.425,),
          // Center(child: Text("당신의 일상을 기록해 보세요")),
          // Center(child: Text("기 Log",style: TextStyle(fontFamily: "gilogfont",fontSize: 43),)),
          Center(
            child:DefaultTextStyle(

                style: TextStyle(fontFamily: "gilogfont",fontSize: 30,color: Colors.black),
                child: Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('일상의 기록이 \n\n쉬워지는 방법 \n\n     기로그', speed: const Duration(milliseconds: 100),),

                    ],
                  ),
                ),

            ),
          ),



        ],
      ),
    );
  }
}
