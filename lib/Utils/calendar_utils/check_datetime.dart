import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Check_Datetime {

  Future<String?> check_Today() async {
    final prefs = await SharedPreferences.getInstance();
    var strToday;
    var shr_datetime;
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    strToday = formatter.format(now);
    // shared preferences 얻기
    shr_datetime = prefs.getString('datetime');

    if (strToday == shr_datetime) {
      //날짜가 아직 안바뀌었을때
      return "notchange";
    }
    if(shr_datetime == null){
      //어플 처음 시작할때(디스크에 저장된 날짜가 없을때)
      prefs.setString('datetime', strToday);
      return "first";
    }

    else {

      //날짜가 바뀌었을때
      prefs.remove("datetime");
      prefs.setString('datetime', strToday);
      return "change";
    }
  }

}
