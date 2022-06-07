import 'package:flutter/material.dart';
import 'package:gilog/Utils/constants.dart';
import 'package:gilog/Utils/datetime.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../Widgets/top_widget.dart';
import 'calendar_detail.dart';

class Calendar_Screen extends StatefulWidget {
  @override
  _Calendar_Screen createState() => _Calendar_Screen();
}

class _Calendar_Screen extends State<Calendar_Screen> {
  String? today;

  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    CalendarView.month,
    CalendarView.schedule
  ];

  @override
  void initState() {
    // TODO: implement initState

    today = getToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void calendarTapped(CalendarTapDetails details) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: Calendar_detail(
                details: details,
              )));
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Top_Widget(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "기 - log",
              style: TextStyle(fontSize: 25,fontFamily: "Gilogfont"),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Container(
            height: size.height * 0.7,
            child: SfCalendar(
              headerStyle: CalendarHeaderStyle(

                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: 21,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 5,
                    color: Colors.black,
                  )),
              view: CalendarView.month,
              onTap: calendarTapped,
              dataSource: MeetingDataSource(_getDataSource()),
              monthViewSettings: MonthViewSettings(
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment),
              selectionDecoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                shape: BoxShape.rectangle,
              ),
            ),
          )
        ],
      ),
    ));
  }
}

List<Meeting> _getDataSource() {
  var meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting(startTime, endTime, Colors.white12, false));
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(this.source);

  List<Meeting> source;

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.from, this.to, this.background, this.isAllDay);

  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
