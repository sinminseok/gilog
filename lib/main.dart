import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/View/Pages/frame.dart';
import 'package:provider/provider.dart';
import 'MVP/Presenter/Http/user_http.dart';
import 'MVP/View/Account/login.dart';
import 'MVP/View/Pages/ErrorScreen.dart';
import 'MVP/View/Pages/splah.dart';

void main() async {

  //KakaoSdk.init(nativeAppKey: 'c4ddd110fec9eaab625667112de706fb');

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();



  runApp(
    ChangeNotifierProvider(
      create: (context) => User_Http(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    //StreamProvider 하단에 있는 widget 들은 value 값이 변경될때마다 감지가 가능하다.
    return FutureBuilder(
      future: Init.instance.initialize(context),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen()); // 초기 로딩 시 Splash Screen
        } else if (snapshot.hasError) {
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ErrorScreen()); // 초기 로딩 에러 시 Error Screen
        } else {
          return MaterialApp(
            // routes: {
            //   // "/" Route로 이동하면, FirstScreen 위젯을 생성합니다.
            //   '/frame': (context) => Frame_Screen(Login_method: null),
            //
            // },
            debugShowCheckedModeBanner: false,
            title: 'Flutter',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: snapshot.data, // 로딩 완료 시 Home Screen
            builder: (context, child) => MediaQuery(
                child: child!,
                data: MediaQuery.of(context).copyWith(
                    textScaleFactor: MediaQuery.of(context)
                        .textScaleFactor
                        .clamp(0.95, 1.05))), // 폰트 스케일 범위 고정
          );
        }
      },
    );
  }
}

class Init {
  Init._();

  static final instance = Init._();

  Future<Widget?> initialize(BuildContext context) async {

    await Future.delayed(Duration(milliseconds: 4300));
    return Login_Screen();// 초기 로딩 완료 시 띄울 앱 첫 화면


  }
}
