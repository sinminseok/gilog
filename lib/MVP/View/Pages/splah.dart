
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
          SizedBox(height: size.height*0.3,),
          // Center(child: Text("당신의 일상을 기록해 보세요")),
          // Center(child: Text("기 Log",style: TextStyle(fontFamily: "gilogfont",fontSize: 43),)),
          Center(
            child:DefaultTextStyle(

                style: TextStyle(fontFamily: "Splahfont",fontSize: 39,color: Colors.black),
                child: Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('당신의 일상을 \n기록해 보세요 \n      기 log', speed: const Duration(milliseconds: 100),),

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
