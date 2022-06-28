class Gilog_User{
  String? username;
  String? gender;
  String? age;

  Gilog_User({this.username , this.gender,this.age});

  factory Gilog_User.fromJson(Map<String, dynamic> json) {
    return Gilog_User(
      username: json['username'],
      gender: json['gender'],
        age:json['age'],

    );
  }

}
