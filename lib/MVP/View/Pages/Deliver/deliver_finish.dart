import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_check/animated_check.dart';
import 'package:gilog/MVP/View/Pages/frame.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:page_transition/page_transition.dart';

class Deliver_Finish_Screen extends StatefulWidget {
  const Deliver_Finish_Screen({Key? key}) : super(key: key);

  @override
  _Deliver_Finish_ScreenState createState() => _Deliver_Finish_ScreenState();
}

class _Deliver_Finish_ScreenState extends State<Deliver_Finish_Screen>  with TickerProviderStateMixin{

  late AnimationController scaleController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
  late Animation<double> scaleAnimation = CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
  late AnimationController checkController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
  late Animation<double> checkAnimation = CurvedAnimation(parent: checkController, curve: Curves.linear);
  @override
  void initState() {
    super.initState();
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkController.forward();
      }
    });
    scaleController.forward();
  }

  @override
  void dispose() {
    scaleController.dispose();
    checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double circleSize = 150;
    double iconSize = 108;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,

      body: InkWell(
        onTap: (){
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: Frame_Screen(Login_method: null,

                  )));
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height*0.3,),
              Center(
                child: Text("주문 완료",style: TextStyle(fontFamily: "gilogfont",fontSize: 32),),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("화면을 터치하면 메인페이지로 이동합니다.",style: TextStyle(fontSize: 20),),
              ),
              SizedBox(height: size.height*0.03,),
              ScaleTransition(
                scale: scaleAnimation,
                child: Container(
                  height: circleSize,
                  width: circleSize,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                  child: SizeTransition(
                      sizeFactor: checkAnimation,
                      axis: Axis.horizontal,
                      axisAlignment: -1,
                      child: Center(
                          child: Icon(Icons.check, color: Colors.white, size: iconSize)
                      )
                  ),
                ),
              ),
              SizedBox(height: size.height*0.4,),

            ],
          ),
        ),
      ),
    );
  }
}
