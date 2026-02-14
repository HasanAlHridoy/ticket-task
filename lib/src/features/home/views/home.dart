import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/router/app_routers.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/context.dart';
import 'package:gian_ticket_task/src/features/filters/controller/filters.dart';
import 'package:gian_ticket_task/src/features/home/controller/home.dart';
import 'package:gian_ticket_task/src/features/home/views/components/ticket_card.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerWidget {
  static const String name = 'home';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gain Solutions',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        elevation: 0,
        actions: [
          Stack(
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
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${notifier.ticketCount} tickets',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      color: Colors.black54, // lighter grey
                      size: 25.r,
                    ),
                    onPressed: () {
                      context.push(AppRoutes.filters);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ref
                  .watch(homeProvider)
                  .when(
                    data: (tickets) => RefreshIndicator(
                      color: context.theme.scaffoldBackgroundColor,
                      onRefresh: () async {
                        ref.read(filtersProvider.notifier).clearFilters();
                        await notifier.refreshTickets();
                      },
                      child: tickets.isEmpty
                          ? SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.7,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.search_off, size: 64.r, color: Colors.grey.shade400),
                                      SizedBox(height: 16.h),
                                      Text(
                                        'Result not found',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: tickets.length,
                              padding: EdgeInsets.only(bottom: 16.h),
                              itemBuilder: (context, index) {
                                return TicketCard(ticket: tickets[index]);
                              },
                            ),
                    ),
                    loading: () =>
                        Center(child: CircularProgressIndicator(color: context.theme.scaffoldBackgroundColor)),
                    error: (error, stack) => Center(child: Text('Error: $error')),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
