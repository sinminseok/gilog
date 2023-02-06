
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


class POST {
  final int? id;
  final String? question;
  final String? datetime;
  final String? content;
  final String? image_url;

  POST({this.id, this.question,this.datetime ,this.content, this.image_url});


  factory POST.fromJson(Map<String, dynamic> json) {


    return POST(
      id: json['id'],
      question: json['question'],
      datetime: json['writeDate'],
      content: json['request'],
      image_url:json['image'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'question':question,
      'datetime':datetime,
      'content':content,
      'image_url':image_url,
    };
  }
}