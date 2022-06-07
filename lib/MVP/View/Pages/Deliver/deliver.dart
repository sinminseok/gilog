
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gilog/MVP/View/Pages/Deliver/deliver_two.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../Utils/toast.dart';

class Deliver_Screen extends StatefulWidget {
  const Deliver_Screen({Key? key}) : super(key: key);

  @override
  _Deliver_ScreenState createState() => _Deliver_ScreenState();
}

class _Deliver_ScreenState extends State<Deliver_Screen> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  bool check_photo = false;
  bool check_write = false;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.08,
            ),
            CarouselSlider(
              items: imgList
                  .map((e) => Image.network(
                        e,
                        fit: BoxFit.cover,
                        width: size.width * 0.9,
                      ))
                  .toList(),
              options: CarouselOptions(
                  autoPlay: false, aspectRatio: 2.0, enlargeCenterPage: true),
            ),
            SizedBox(height: size.height*0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: CircleAvatar(
                    radius: 30,
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
              height: size.height*0.03,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {

                      if(check_write == true){
                        check_photo = !check_photo;
                        check_write = false;
                      }else{
                        check_photo = !check_photo;
                      }
                    });

                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("사진만 할래요!", style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold,fontFamily: "numberfont"),),
                            check_photo == true ?Icon(Icons.check , color: Colors.purple,):Container()
                          ],
                        ),
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
                    setState(() {

                      if(check_photo == true){
                        check_photo = false;
                        check_write = !check_write;
                      }else{
                        check_write = !check_write;
                      }
                    });
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.fade,
                    //         child: Deliver_Two_Screen()));
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("글도 할래요!", style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold,fontFamily: "numberfont"),),
                            check_write==true ? Icon(Icons.check , color: Colors.purple,):Container()
                          ],
                        ),
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
            ),
            SizedBox(height: size.height*0.03,),
            InkWell(
              onTap: (){
                if(check_photo ==false && check_write == false){
                  showAlertDialog(context,"알림","사진 또는 글을 선택해주세요");
                  return;
                }if(check_photo == true){
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: Deliver_Two_Screen(data: "사진만",)));
                }if(check_write == true){
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: Deliver_Two_Screen(data:"사진,글둘다")));
                }

              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3), color: Colors.purple),
                width: size.width * 0.7,
                height: size.height * 0.06,
                child: Center(
                    child: Text(
                      "다음으로",
                      style: TextStyle(color: Colors.white,fontFamily: "numberfont",fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
