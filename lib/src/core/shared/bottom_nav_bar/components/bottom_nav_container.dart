import 'package:flutter/material.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/context.dart';
import 'package:gian_ticket_task/src/core/utils/theme/theme.dart';

class BottomNavContainer extends StatelessWidget {
  const BottomNavContainer({super.key, required this.currentIndex, required this.onTap, required this.navItems});

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> navItems;

  @override
  Widget build(BuildContext context) {

    return Container(
      color:  context.theme.scaffoldBackgroundColor,
      padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
      child: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        removeTop: true,
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: context.theme.scaffoldBackgroundColor,
          selectedItemColor: context.theme.primaryColor,
          unselectedItemColor: headLineTextColor,
          type: BottomNavigationBarType.fixed,
          items: navItems,
        ),
      ),
    );
  }
}
