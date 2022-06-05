import 'package:intl/intl.dart';


String getToday() {
  String? strToday;
  String? sub_string;
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  strToday = formatter.format(now);
  sub_string = strToday.substring(0,4)+"년"+strToday.substring(5,7)+"월"+strToday.substring(8)+"일";
  return sub_string;
}
