import 'dart:typed_data';


class User_profile_image {
  final int? id;
  final Uint8List profile_image;

  User_profile_image({this.id, required this.profile_image});

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'profile_image':profile_image,
    };
  }
}