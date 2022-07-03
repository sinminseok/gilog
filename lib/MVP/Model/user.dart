class Gilog_User{
  int? id;
  String? username;
  String? password;
  String? nickname;
  String? gender;
  DateTime? reg_datetime;
  int? age;

  Gilog_User({this.id , this.username,this.password,this.nickname,this.gender,this.reg_datetime,this.age});

  factory Gilog_User.fromJson(Map<String, dynamic> json) {
    return Gilog_User(
      id:json['id'],
      username: json['username'],
      password: json['password'],
      nickname:json['nickname'],
      gender:json['gender'],
      reg_datetime:json['reg_datetime'],
      age:json['age'],

    );
  }

}
