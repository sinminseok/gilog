import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Deliver_Two_Screen extends StatefulWidget {
  const Deliver_Two_Screen({Key? key}) : super(key: key);

  @override
  _Deliver_Two_Screen createState() => _Deliver_Two_Screen();
}

class _Deliver_Two_Screen extends State<Deliver_Two_Screen> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
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
              height: size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "12개의 기-록",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        width: size.width * 0.43,
                        height: size.height * 0.25,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "24개의 기록",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        width: size.width * 0.43,
                        height: size.height * 0.25,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Text(
              "기-록 신청부수",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height*0.04,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.17,
                  height: size.height * 0.05,
                  margin: EdgeInsets.all(4),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                        "1권",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                Container(
                  width: size.width * 0.17,
                  height: size.height * 0.05,
                  margin: EdgeInsets.all(4),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                        "2권",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                Container(
                  width: size.width * 0.17,
                  height: size.height * 0.05,
                  margin: EdgeInsets.all(4),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                        "3권",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                Container(
                  width: size.width * 0.17,
                  height: size.height * 0.05,
                  margin: EdgeInsets.all(4),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                        "4권",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                Container(
                  width: size.width * 0.17,
                  height: size.height * 0.05,
                  margin: EdgeInsets.all(4),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                        "5권",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
