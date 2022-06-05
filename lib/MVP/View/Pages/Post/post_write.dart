import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Post_Write extends StatefulWidget {
  String? question;
  Post_Write({required this.question});

  @override
  _Post_WriteState createState() => _Post_WriteState();
}

class _Post_WriteState extends State<Post_Write> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height*0.1,),
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
            Text("...기-log해보세요")
          ],
        ),
      ),
    );
  }
}
