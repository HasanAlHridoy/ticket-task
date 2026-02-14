import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/features/contatcs/controller/contatcs.dart';
import 'package:gian_ticket_task/src/features/contatcs/views/components/contacts_list_view.dart';
import 'package:gian_ticket_task/src/features/contatcs/views/components/contacts_search_bar.dart';
import 'package:gian_ticket_task/src/features/home/views/components/home_app_bar.dart';

class ContacsView extends ConsumerWidget {
  static const String name = 'contacts';
  const ContacsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(contactsProvider);

    return Scaffold(
      appBar: const HomeAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            const ContactsSearchBar(),
            SizedBox(height: 22.h),
            contactsAsync.when(
              data: (contacts) => Text(
                '${contacts.length} Contacts',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
              ),
              loading: () => const SizedBox.shrink(),
              error: (error, stack) => const SizedBox.shrink(),
            ),
            SizedBox(height: 22.h),
            const Expanded(child: ContactsListView()),
          ],
        ),
      ),
    );
  }
}
