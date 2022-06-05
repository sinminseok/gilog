class Gilog_Model{
  String? username;
  String? nickname;
  final List<dynamic>? authorityDtoSet;
  Gilog_Model({this.username , this.nickname, this.authorityDtoSet});

  factory Gilog_Model.fromJson(Map<String, dynamic> json) {
    return Gilog_Model(
      username: json['username'],
      nickname: json['nickname'],
      authorityDtoSet: json['authorityDtoSet'],
    );
  }

}
