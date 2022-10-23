import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:gilog/Local_DB/Utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../../../Local_DB/db.dart';
import 'package:path/path.dart';

import '../../Utils/http_url.dart';



class Image_Controller{



  Future<void> download(token) async {

    var res = await http.get(Uri.parse(Http_URL().get_server_data), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final decodeData = utf8.decode(res.bodyBytes);
    final data = jsonDecode(decodeData);


    final response = await http.get(Uri.parse("http://ec2-43-200-33-232.ap-northeast-2.compute.amazonaws.com:8080/api/gi-log/image/${data[0]['image']}"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    // final response = await http.get(Uri.parse(url));

    // Get the image name
    final imageName = path.basename("http://ec2-43-200-33-232.ap-northeast-2.compute.amazonaws.com:8080/api/gi-log/image/${data[0]['image']}");
    // Get the document directory path
    final appDir = await pathProvider.getApplicationDocumentsDirectory();

    // This is the saved image path
    // You can use it to display the saved image later
    final localPath = path.join(appDir.path, imageName);

    print(localPath);

    // Downloading
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);
  }

}