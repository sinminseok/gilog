import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gilog/MVP/View/Pages/Deliver/deliver_four.dart';
import 'package:gilog/MVP/View/Pages/Deliver/deliver_two.dart';
import 'package:page_transition/page_transition.dart';

class Deliver_Three_Screen extends StatefulWidget {
  int? book_count;
  String? book_page;
  Deliver_Three_Screen({required this.book_count,required this.book_page});


  @override
  _Deliver_Three_Screen createState() => _Deliver_Three_Screen();
}

class _Deliver_Three_Screen extends State<Deliver_Three_Screen> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,//색변경
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.08,
            ),

            SizedBox(height: size.height*0.1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQft5IfIdvj7DsDRdob-CUypqRKgcSIwPCLXg&usqp=CAU'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQft5IfIdvj7DsDRdob-CUypqRKgcSIwPCLXg&usqp=CAU'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                        'https://us.123rf.com/450wm/passatic/passatic1906/passatic190600228/124518258-%ED%9D%B0%EC%83%89-%EB%B0%B0%EA%B2%BD-%EB%B2%A1%ED%84%B0%EC%97%90-%EC%9B%83%EB%8A%94-%EB%85%B8%EB%9E%80-%EC%96%BC%EA%B5%B4-%EC%9D%B4%EB%AA%A8%ED%8B%B0%EC%BD%98.jpg?ver=6'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQft5IfIdvj7DsDRdob-CUypqRKgcSIwPCLXg&usqp=CAU'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height*0.1,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){

                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("사진만 할래요!", style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        color: Colors.black,
                        width: size.width*0.43,
                        height: size.height*0.25,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: Deliver_Four_Screen()));
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("사진만 할래요!", style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        color: Colors.black,
                        width: size.width*0.43,
                        height: size.height*0.25,
                      )
                    ],
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
