import 'package:flutter/material.dart';

class BottomNavUtils {
  static BottomNavigationBarItem buildItem({
    Widget? icon,
    Widget? activeIcon,
    bool isSvg = false,
    String? svgPath,
    String? activeSvgPath,
  }) {
    return BottomNavigationBarItem(
      icon: icon!,
      activeIcon: activeIcon ?? icon,
      label: '',
      backgroundColor: Colors.white,
    );
  }
}
