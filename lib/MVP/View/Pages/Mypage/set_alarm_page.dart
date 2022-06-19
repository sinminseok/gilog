import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gilog/MVP/View/Pages/Mypage/mypage_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../../../../Utils/calendar_utils/datetime.dart';
import '../../../../Utils/constants.dart';
import '../../../../Utils/toast.dart';

class Set_Alarm extends StatefulWidget {
  const Set_Alarm({Key? key}) : super(key: key);

  @override
  _Set_AlarmState createState() => _Set_AlarmState();
}

class _Set_AlarmState extends State<Set_Alarm> with WidgetsBindingObserver {

  //기존 알림 설정 시간
  int set_time = 8;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FlutterAppBadger.removeBadge();
    }
  }

  Future<void> _init() async {
    await _configureLocalTimeZone();
    await _initializeNotification();
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
  }

  Future<void> _initializeNotification() async {

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
        );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> _requestPermissions() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _registerMessage({
    required int hour,
    required int minutes,
    required message,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.getLocation("Asia/Seoul"));
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.getLocation("Asia/Seoul"),
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'flutter_local_notifications',
      message,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
          priority: Priority.high,
          ongoing: true,
          styleInformation: BigTextStyleInformation(message),
          icon: 'ic_notification',
        ),
        iOS: const IOSNotificationDetails(
          badgeNumber: 1,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //색변경
        ),
      ),
      body: Column(
        children: [
          Text(
            "기-록 알림 받기",
            style: TextStyle(fontFamily: "gilogfont", fontSize: 32),
          ),
          SizedBox(height: size.height*0.06,),
          Center(
            child: Container(
              height: size.height * 0.5,
              width: size.width * 0.7,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(

                          onTap: () {

                            setState(() {
                              set_time = 12;
                            });

                            print(set_time);
                          },
                          child: Center(child: Text("오후12:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 13;
                            });
                          },
                          child: Center(child: Text("오후1:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 14;
                            });
                          },
                          child: Center(child: Text("오후2:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 15;
                            });
                          },
                          child: Center(child: Text("오후3:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 16;
                            });
                          },
                          child: Center(child: Text("오후4:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 17;
                            });
                          },
                          child: Center(child: Text("오후5:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 18;
                            });
                          },
                          child: Center(child: Text("오후6:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 19;
                            });
                          },
                          child: Center(child: Text("오후7:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 20;
                            });
                          },
                          child: Center(child: Text("오후8:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 21;
                            });
                          },
                          child: Center(child: Text("오후9:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 22;
                            });
                          },
                          child: Center(child: Text("오후10:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 23;
                            });
                          },
                          child: Center(child: Text("오후11:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 0;
                            });
                          },
                          child: Center(child: Text("오전12:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 1;
                            });
                          },
                          child: Center(child: Text("오전1:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 2;
                            });
                          },
                          child: Center(child: Text("오전2:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 3;
                            });
                          },
                          child: Center(child: Text("오전3:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 4;
                            });
                          },
                          child: Center(child: Text("오전4:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 5;
                            });
                          },
                          child: Center(child: Text("오전5:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 6;
                            });
                          },
                          child: Center(child: Text("오전6:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 7;
                            });
                          },
                          child: Center(child: Text("오전7:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 8;
                            });
                          },
                          child: Center(child: Text("오전8:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 9;
                            });
                          },
                          child: Center(child: Text("오전9:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 5;
                            });
                          },
                          child: Center(child: Text("오전10:00")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              set_time = 11;
                            });
                          },
                          child: Center(child: Text("오전11:00")),
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: size.height*0.09,),
          InkWell(
            onTap: () async {

              await _cancelNotification();
              await _requestPermissions();


               tz.TZDateTime now = tz.TZDateTime.now(tz.getLocation("Asia/Seoul"));
               print(now.minute);


              await _registerMessage(
                hour: set_time,
                minutes: 1,
                message: '새로운 질문이 도착했어요!',
              );

              showAlertDialog(context,"알림","${set_time}시로 알림이 설정 되었습니다.");

              // Navigator.push(
              //     context,
              //     PageTransition(
              //         type: PageTransitionType.fade, child: Mypage_Screen()));


            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.purple),
                width: size.width * 0.7,
                height: size.height * 0.06,
                child: Center(child: Text("알림 설정하기",style: TextStyle(fontSize: 25,fontFamily: "gilogfont",color: Colors.white),))),
          )
        ],
      ),
    );
  }
}
