import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gilog/MVP/View/Pages/Post/post_write.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import '../../../Utils/datetime.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  final List<String> imgList = [
    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fdata.whicdn.com%2Fimages%2F362657308%2Foriginal.jpg&type=ofullfill340_600_png",
    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fdata.whicdn.com%2Fimages%2F362657308%2Foriginal.jpg&type=ofullfill340_600_png"
  ];
  String? today;

  @override
  void initState() {
    // TODO: implement initState
    today = getToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            Center(
                child: Text(
              "${today}",
              style: TextStyle(fontSize: 32),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "오늘의 기-록",
                style: TextStyle(fontSize: 32),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:40),
              child: CarouselSlider(
                items: imgList
                    .map((e) => Image.network(
                          e,
                          fit: BoxFit.cover,
                          width: size.width*0.8,


                        ))
                    .toList(),
                options: CarouselOptions(
                    autoPlay: false, aspectRatio: 2.0, enlargeCenterPage: true),
              ),
            ),
            SizedBox(height: size.height*0.15,),
            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: Post_Write(question: '오늘 날씨는 어땠나요?',)));
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black, style: BorderStyle.solid, width: 3),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                width: size.width * 0.9,
                height: size.height * 0.1,
                child: Center(
                    child: Text(
                  "매일 새로운 질문!",
                  style: TextStyle(color: Colors.black),
                )),
              ),
            ),
            SizedBox(height: size.height*0.02,),
            InkWell(
                onTap: (){

                },
                child: Text("새로운 질문을 만들래요")),
          ],
        ),
      ),
    );
  }
}
