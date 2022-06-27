import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../MVP/Presenter/Http/http_presenter.dart';

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
      return "notchange";
    }
    if(shr_datetime == null){
      print("null datetime");
      //http question 요청
    //  Http_Presenter().get_question(token);
      prefs.setString('datetime', strToday);
      return "first";
    }

    else{
      print("change datetime");
      //http question 요청
      //날짜가 바뀌었을때
    //   Http_Presenter().get_question(token);
      prefs.remove("datetime");
      prefs.setString('datetime', strToday);
      return "change";
    }
  }

}
