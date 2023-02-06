import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Top_Widget extends StatefulWidget {


  @override
  _Top_WidgetState createState() => _Top_WidgetState();
}

class _Top_WidgetState extends State<Top_Widget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                'https://www.woolha.com/media/2020/03/eevee.png'),
          ),
        ),
      ],
    );
  }
}
