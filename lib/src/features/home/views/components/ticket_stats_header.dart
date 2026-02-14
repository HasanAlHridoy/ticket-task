import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/router/app_routers.dart';
import 'package:gian_ticket_task/src/features/home/controller/home.dart';
import 'package:go_router/go_router.dart';

class TicketStatsHeader extends ConsumerWidget {
  const TicketStatsHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(homeProvider.notifier);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${notifier.ticketCount} tickets',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
          ),
          IconButton(
            icon: Icon(Icons.filter_alt_outlined, color: Colors.black54, size: 25.r),
            onPressed: () => context.push(AppRoutes.filters),
          ),
        ],
      ),
    );
  }
}
