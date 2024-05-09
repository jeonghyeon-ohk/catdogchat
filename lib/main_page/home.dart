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
    return PopScope(
      canPop: false,
      child: Scaffold(
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
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          // type: BottomNavigationBarType.shifting,
          onTap: (index){
            controller.animateTo(index);
          },
          items: TABS
              .map(
                (e) => BottomNavigationBarItem(
                  icon: Icon(
                    e.icon,
                  ),
                  label: e.label,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}






