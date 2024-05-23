import 'package:catdogchat/main_page/chatbot/chatbot_page.dart';
import 'package:catdogchat/main_page/map/map_page.dart';
import 'package:catdogchat/main_page/my/my_page.dart';
import 'package:flutter/material.dart';
import '../const/tabs.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: TABS.length,
      vsync: this,
    );
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth * 0.06;
    double labelFontSize = screenWidth * 0.035;

    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          ChatbotPage(),
          MapPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: controller.index,
        onTap: (index) {
          controller.animateTo(index);
        },
        items: TABS.map((e) => BottomNavigationBarItem(
          icon: Icon(
            e.icon,
            size: iconSize,
          ),
          label: e.label,
        )).toList(),
      ),
    );
  }
}