import 'package:flutter/material.dart';

class BottomNavUtils {
  static BottomNavigationBarItem buildItem({
    Widget? icon,
    Widget? activeIcon,
    required String label,
    bool isSvg = false,
    String? svgPath,
    String? activeSvgPath,
  }) {
    return BottomNavigationBarItem(
      icon: icon!,
      activeIcon: activeIcon ?? icon,
      label: label,
      backgroundColor: Colors.white,
    );
  }
}
