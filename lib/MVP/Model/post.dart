import 'dart:typed_data';


class POST {
  final int? id;
  final String? question;
  final String? datetime;
  final String? content;
  final Uint8List? image_url;

  POST({this.id, this.question,this.datetime ,this.content, this.image_url});

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