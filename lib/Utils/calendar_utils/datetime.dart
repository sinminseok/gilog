import 'package:intl/intl.dart';


String getToday() {
  String? strToday;
  String? sub_string;
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  strToday = formatter.format(now);
  //strToday.substring(0,4)+"년"+
  sub_string = strToday.substring(5,7)+"월"+strToday.substring(8)+"일";
  return sub_string;
}

String full_getToday() {
  String? strToday;
  String? sub_string;
  String now = DateTime.now().toString();

  sub_string = now.substring(0,4)+"년"+now.substring(5,7)+"월"+now.substring(8,10)+"일"+now.substring(10,16);
  print(sub_string);
  return sub_string;
}
