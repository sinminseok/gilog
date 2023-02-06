import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utility {
  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static ClipRRect imageFromBase64String(String base64String, Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.memory(
        base64Decode(base64String),
        fit: BoxFit.cover,
        cacheWidth: (size.width * 0.1).toInt(),
        cacheHeight: (size.height * 0.07).toInt(),
      ),
    );
  }

  static ClipRRect networkimg(String imgurl,String token ,Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child:  CachedNetworkImage(

        imageUrl: "http://ec2-43-200-33-232.ap-northeast-2.compute.amazonaws.com:8080/api/gi-log/image/$imgurl",
        httpHeaders: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        placeholder: (context, url) => CircularProgressIndicator(),

      ),
    );
  }

  static ClipRRect networkimg_detail(String imgurl,String token ,Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child:  CachedNetworkImage(

        imageUrl: "http://ec2-43-200-33-232.ap-northeast-2.compute.amazonaws.com:8080/api/gi-log/image/$imgurl",
        httpHeaders: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        placeholder: (context, url) => CircularProgressIndicator(),
        fit: BoxFit.fitHeight,

      ),
    );
  }
}
