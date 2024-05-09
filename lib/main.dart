import 'package:catdogchat/login/join_page.dart';
import 'package:catdogchat/login/login_page.dart';
import 'package:catdogchat/main_page/map/hospital_info_page.dart';
import 'package:catdogchat/main_page/my/change_password.dart';
import 'package:catdogchat/main_page/my/edit_profile.dart';
import 'package:catdogchat/main_page/my/logout.dart';
import 'package:catdogchat/main_page/my/withdraw.dart';
import 'package:catdogchat/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'main_page/home.dart';
import 'main_page/my/pet_edit_page.dart';
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (BuildContext context) => SplashScreen(),
        '/' : (BuildContext context) => MainPage(),
        '/login' : (BuildContext context) => LoginPage(),
        '/join' : (BuildContext context) => JoinPage(),
        '/hospital' : (BuildContext context) => HospitalInfoPage(),
        '/petEdit' : (BuildContext context) => PetEditPage(),
        '/editProfile' : (BuildContext context) => EditProfile(),
        '/password' : (BuildContext context) => ChangePassword(),
        '/logout' : (BuildContext context) => Logout(),
        '/withdraw' : (BuildContext context) => Withdraw(),

      },
    ),
  );
}