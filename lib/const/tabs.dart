import 'package:flutter/material.dart';

class TabInfo {
  final IconData icon;
  final String label;

  const TabInfo({
    required this.icon,
    required this.label,
  });
}

const TABS = [
  TabInfo(
    icon: Icons.chat,
    label: 'Chatbot',
  ),
  TabInfo(
    icon: Icons.map,
    label: 'Map',
  ),
  TabInfo(
    icon: Icons.person,
    label: 'MyPage',
  ),
];
