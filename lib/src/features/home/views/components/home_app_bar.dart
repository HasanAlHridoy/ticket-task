import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Gain Solutions',
        style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),
      ),
      centerTitle: false,
      elevation: 0,
      actions: [
        const NotificationBadge(),
        SizedBox(width: 16.w),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, color: Colors.black87, size: 28.r),
          onPressed: () {},
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: Text(
              '3',
              style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
