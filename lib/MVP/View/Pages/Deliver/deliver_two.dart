import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/View/Pages/Deliver/deliver_three.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../Utils/toast.dart';

class Deliver_Two_Screen extends StatefulWidget {
  String? data;
  Deliver_Two_Screen({required this.data});

  @override
  _Deliver_Two_Screen createState() => _Deliver_Two_Screen();
}

class _Deliver_Two_Screen extends State<Deliver_Two_Screen> {
  bool check_one = false;
  bool check_two = false;
  int book_count = 0;

  bool check_count_one = false;
  bool check_count_two = false;
  bool check_count_three = false;
  bool check_count_four = false;
  bool check_count_five = false;



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
              height: size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if(check_two == true){
                        check_one = !check_one;
                        check_two = false;
                      }else{
                        check_one = !check_one;
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "12개의 기-록",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                            check_one == true?Icon(Icons.check,color: Colors.purple,):Container(),
                          ],
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
                  onTap: () {
                    setState(() {
                      if(check_one == true){
                        check_two = !check_two;
                        check_one = false;
                      }else{
                        check_two = !check_two;
                      }
                    });
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.fade,
                    //         child: Deliver_Three_Screen()));
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "24개의 기록",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                            check_two==true?Icon(Icons.check,color: Colors.purple,):Container()
                          ],
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
                InkWell(

                  onTap: (){
                    setState(() {

                      book_count = 1;
                      if(check_count_five==true || check_count_two==true || check_count_three==true || check_count_four==true){
                        check_count_five= false;
                        check_count_two= false;
                        check_count_three= false;
                        check_count_four= false;
                        check_count_one = !check_count_one;
                      }else{
                        check_count_one = !check_count_one;
                      }

                    });
                  },
                  child: Container(
                    width: size.width * 0.17,
                    height: size.height * 0.05,
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(10),
                    decoration: check_count_one == true?BoxDecoration(
                        color: Colors.purple, borderRadius: BorderRadius.circular(10)):BoxDecoration(
                        color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                          "1권",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                InkWell(

                  onTap: (){
                    setState(() {

                      book_count = 2;
                      if(check_count_five==true || check_count_one==true || check_count_three==true || check_count_four==true){
                        check_count_five= false;
                        check_count_one= false;
                        check_count_three= false;
                        check_count_four= false;
                        check_count_two = !check_count_two;
                      }else{
                        check_count_two = !check_count_two;
                      }

                    });
                  },
                  child: Container(
                    width: size.width * 0.17,
                    height: size.height * 0.05,
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(10),
                    decoration: check_count_two == true?BoxDecoration(
                        color: Colors.purple, borderRadius: BorderRadius.circular(10)):BoxDecoration(
                        color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                          "2권",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                InkWell(

                  onTap: (){
                    setState(() {

                      book_count = 3;
                      if(check_count_five==true || check_count_two==true || check_count_one==true || check_count_four==true){
                        check_count_five= false;
                        check_count_two= false;
                        check_count_one= false;
                        check_count_four= false;
                        check_count_three = !check_count_three;
                      }else{
                        check_count_three = !check_count_three;
                      }

                    });
                  },
                  child: Container(
                    width: size.width * 0.17,
                    height: size.height * 0.05,
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(10),
                    decoration: check_count_three == true?BoxDecoration(
                        color: Colors.purple, borderRadius: BorderRadius.circular(10)):BoxDecoration(
                        color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                          "3권",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                InkWell(

                  onTap: (){
                    setState(() {

                      book_count = 4;
                      if(check_count_five==true || check_count_two==true || check_count_three==true || check_count_one==true){
                        check_count_five= false;
                        check_count_two= false;
                        check_count_three= false;
                        check_count_one= false;
                        check_count_four = !check_count_four;
                      }else{
                        check_count_four = !check_count_four;
                      }

                    });
                  },
                  child: Container(
                    width: size.width * 0.17,
                    height: size.height * 0.05,
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(10),
                    decoration: check_count_four == true?BoxDecoration(
                        color: Colors.purple, borderRadius: BorderRadius.circular(10)):BoxDecoration(
                        color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                          "4권",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                InkWell(

                  onTap: (){
                    setState(() {

                      book_count = 5;
                      if(check_count_one==true || check_count_two==true || check_count_three==true || check_count_four==true){
                        check_count_one= false;
                        check_count_two= false;
                        check_count_three= false;
                        check_count_four= false;
                        check_count_five = !check_count_five;
                      }else{
                        check_count_five = !check_count_five;
                      }

                    });
                  },
                  child: Container(
                    width: size.width * 0.17,
                    height: size.height * 0.05,
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(10),
                    decoration: check_count_five == true?BoxDecoration(
                        color: Colors.purple, borderRadius: BorderRadius.circular(10)):BoxDecoration(
                        color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                          "5권",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ],
            ),
        SizedBox(height: size.height*0.07,),
        InkWell(
          onTap: (){
            if(check_one ==false && check_two == false){
              showAlertDialog(context,"알림","인화할 페이지 수를 선택해주세요");
              return;
            }if(check_one == true){
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: Deliver_Three_Screen(book_page: "12개의 기록", book_count: book_count)));
            }if(check_two == true){
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: Deliver_Three_Screen(book_page:"24개의 기록" , book_count:book_count)));
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
          ),)
          ],
        ),
      ),
    );
  }
}
