import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/router/app_routers.dart';
import 'package:gian_ticket_task/src/core/shared/bottom_nav_bar/components/bottom_nav_container.dart';
import 'package:gian_ticket_task/src/core/shared/bottom_nav_bar/components/build_item.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/context.dart';
import 'package:gian_ticket_task/src/core/utils/theme/theme.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavBar extends ConsumerWidget {
  final Widget child;
  const CustomBottomNavBar({super.key, required this.child});
  static const String name = 'bottom-nav-bar';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavContainer(
        currentIndex: _getSelectedIndex(context, ref),
        onTap: (index) => _onItemTapped(index, context),
        navItems: _buildNavItems(context),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavItems(BuildContext context) {
    // Use .valueOrNull to safely access isSwitched, default to false if loading/error
    return [
      BottomNavUtils.buildItem(
        label: 'Tickets',
        activeIcon: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          decoration: BoxDecoration(
            color: context.theme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(Icons.analytics, size: 24.r, color: context.theme.primaryColor),
        ),
        icon: Icon(Icons.analytics_outlined, size: 24.r, color: secondaryColor),
      ),
      BottomNavUtils.buildItem(
        label: 'Contacts',
        activeIcon: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          decoration: BoxDecoration(
            color: context.theme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(Icons.supervised_user_circle_rounded, size: 24.r, color: context.theme.primaryColor),
        ),
        icon: Icon(Icons.supervised_user_circle_outlined, size: 24.r, color: secondaryColor),
      ),
      BottomNavUtils.buildItem(
        label: 'Profile',
        activeIcon: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          decoration: BoxDecoration(
            color: context.theme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(Icons.person, size: 24.r, color: context.theme.primaryColor),
        ),
        icon: Icon(Icons.person_outline_rounded, size: 24.r, color: secondaryColor),
      ),
    ];
  }

  void _onItemTapped(int index, BuildContext context) async {
    switch (index) {
      case 0:
        context.go(AppRoutes.homeRoute);
        break;
      case 1:
        context.go(AppRoutes.contacts);
        break;
      case 2:
        context.go(AppRoutes.profile);

        break;
    }
  }

  int _getSelectedIndex(BuildContext context, WidgetRef ref) {
    final String location = GoRouterState.of(context).uri.toString();
    // if (location.startsWith(AppRoutes.homeRoute)) {
    //   return 2; // Switch/Wishlist
    // }
    if (location.startsWith(AppRoutes.contacts)) return 1;
    if (location.startsWith(AppRoutes.profile)) return 2;
    return 0; // Home
  }
}
