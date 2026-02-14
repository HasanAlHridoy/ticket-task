import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/context.dart';
import 'package:gian_ticket_task/src/features/contatcs/controller/contatcs.dart';

import 'contact_card.dart';

class ContactsListView extends ConsumerWidget {
  const ContactsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(contactsProvider);

    return contactsAsync.when(
      data: (contacts) {
        if (contacts.isEmpty) {
          return Center(
            child: Text(
              'No contacts found',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey),
            ),
          );
        }
        return ListView.separated(
          itemCount: contacts.length,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return ContactCard(contact: contacts[index]);
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator(color: context.theme.scaffoldBackgroundColor)),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
