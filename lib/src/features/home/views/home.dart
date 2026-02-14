import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gian_ticket_task/src/features/home/views/components/home_app_bar.dart';
import 'package:gian_ticket_task/src/features/home/views/components/ticket_list_view.dart';
import 'package:gian_ticket_task/src/features/home/views/components/ticket_stats_header.dart';

class HomeView extends ConsumerWidget {
  static const String name = 'home';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: const Column(
          children: [
            TicketStatsHeader(),
            Expanded(child: TicketListView()),
          ],
        ),
      ),
    );
  }
}
