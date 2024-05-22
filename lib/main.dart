import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'login/join_page.dart';
import 'login/login_page.dart';
import 'main_page/home.dart';
import 'main_page/map/hospital_info_page.dart';
import 'main_page/my/change_password.dart';
import 'main_page/my/edit_profile.dart';
import 'main_page/my/logout.dart';
import 'main_page/my/pet_edit_page.dart';
import 'main_page/my/withdraw.dart';
import 'screen/splash_screen.dart';
import 'main_page/map/map_page.dart';  // 새로 추가한 지도 페이지 import

void main() async {
  await _initialize();
  runApp(MyApp());
}

// 지도 초기화하기
Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await NaverMapSdk.instance.initialize(
      clientId: dotenv.env['NaverMapKey'],     // 클라이언트 ID 설정
      onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed")
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (BuildContext context) => SplashScreen(),
        '/': (BuildContext context) => MainPage(),
        '/login': (BuildContext context) => LoginPage(),
        '/join': (BuildContext context) => JoinPage(),
        //'/hospital': (BuildContext context) => HospitalInfoPage(),
        '/petEdit': (BuildContext context) => PetEditPage(),
        '/editProfile': (BuildContext context) => EditProfile(),
        '/password': (BuildContext context) => ChangePassword(),
        '/logout': (BuildContext context) => Logout(),
        '/withdraw': (BuildContext context) => Withdraw(),
        '/map': (BuildContext context) => MapPage(),  // 새로 추가한 지도 페이지 route 설정
      },
    );
  }
}
