import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Post_Write extends StatefulWidget {
  String? question;
  Post_Write({required this.question});

  @override
  _Post_WriteState createState() => _Post_WriteState();
}

class _Post_WriteState extends State<Post_Write> {
  TextEditingController _content_controller = TextEditingController();

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

            Container(
              color: Colors.black,
              width: size.width*0.9,
              height: size.height*0.4,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
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
                        "${widget.question}",
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ),
            ),
        TextFormField(
          //
                    controller: _content_controller,
                    textAlign: TextAlign.center,
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 5, bottom: 5, top: 5, right: 5),
                        hintText: '...여기에 내용을 기록해보세요!'),
                    minLines: 1,
                    maxLines: 5,
                    maxLengthEnforced: true,
                  ),
            SizedBox(height: size.height*0.14,),
            InkWell(
              onTap: (){
                //http post 기록(datetime,img,
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3), color: Colors.purple),
                width: size.width * 0.7,
                height: size.height * 0.06,
                child: Center(
                    child: Text(
                      "기-록하기",
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
