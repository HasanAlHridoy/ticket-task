import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/context.dart';
import 'package:gian_ticket_task/src/features/filters/controller/filters.dart';
import 'package:gian_ticket_task/src/features/home/controller/home.dart';
import 'package:gian_ticket_task/src/features/home/views/components/ticket_card.dart';

class TicketListView extends ConsumerWidget {
  const TicketListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);

    return homeState.when(
      data: (tickets) => RefreshIndicator(
        color: context.theme.scaffoldBackgroundColor,
        onRefresh: () async {
          ref.read(filtersProvider.notifier).clearFilters();
          await notifier.refreshTickets();
        },
        child: tickets.isEmpty
            ? const EmptyTicketsView()
            : ListView.builder(
                itemCount: tickets.length,
                padding: EdgeInsets.only(bottom: 16.h),
                itemBuilder: (context, index) {
                  return TicketCard(ticket: tickets[index]);
                },
              ),
      ),
      loading: () => Center(child: CircularProgressIndicator(color: context.theme.scaffoldBackgroundColor)),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class EmptyTicketsView extends StatelessWidget {
  const EmptyTicketsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
