import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../../../../Utils/constants.dart';
import '../../../../Utils/permission.dart';
import '../../../../Utils/toast.dart';

class Set_Alarm extends StatefulWidget {
  const Set_Alarm({Key? key}) : super(key: key);

  @override
  _Set_AlarmState createState() => _Set_AlarmState();
}

class _Set_AlarmState extends State<Set_Alarm> with WidgetsBindingObserver {
  //기존 알림 설정 시간
  int set_hour = 8;
  int set_minute = 0;
  bool check_alarm = false;


  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {

    super.initState();
    Permission_handler().requestNotifcation(context);
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

  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> _initializeNotification() async {
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

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

    await _flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'GI_LOG',
      message,
      Time(set_hour, set_minute, 0),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
          priority: Priority.high,
          ongoing: true,
          styleInformation: BigTextStyleInformation(message),
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const IOSNotificationDetails(
          badgeNumber: 1,
        ),
      ),
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
          color: kButtonColor, //색변경
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.04,
          ),

          Text(
            "기록 알림 받기",
            style: TextStyle(fontFamily: "gilogfont", fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "설정한 시간에 질문 알림을 받을 수 있어요:)",
              style: TextStyle(fontSize: 18, fontFamily: "gilogfont"),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            child: Container(
              height: size.height * 0.45,
              width: size.width * 0.8,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (value) {
                  setState(() {
                    set_hour = value.hour;
                    set_minute = value.minute;
                  });
                },
                initialDateTime: DateTime.now(),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                setState(() {
                  check_alarm = !check_alarm;
                });
                print(check_alarm);


                await _cancelNotification();

                showAlertDialog(context, "알림", "알림이 꺼졌습니다");
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color:check_alarm == false ? Color(0xffD0C8C1) : kButtonColor),
                  width: size.width * 0.7,
                  height: size.height * 0.06,
                  child: Center(
                      child: Text(
                    "알림 끄기",
                    style: TextStyle(fontSize: 21, color: Colors.white),
                  ))),
            ),
          ),
          InkWell(
            onTap: () async {
              await _cancelNotification();
              await _requestPermissions();

              // tz.TZDateTime now =
              //     tz.TZDateTime.now(tz.getLocation("Asia/Seoul"));

              await _registerMessage(
                hour: set_hour,
                minutes: set_minute,
                message: '새로운 질문이 도착했어요!',
              );

              showAlertDialog(
                  context, "알림", "${set_hour}시 ${set_minute}로 알림이 설정 되었습니다.");
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: kButtonColor),
                width: size.width * 0.7,
                height: size.height * 0.06,
                child: Center(
                    child: Text(
                  "설정 하기",
                  style: TextStyle(fontSize: 21, color: Colors.white),
                ))),
          )
        ],
      ),
    );
  }
}
