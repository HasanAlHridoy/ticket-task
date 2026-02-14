import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/features/contatcs/controller/contatcs.dart';

class ContactsSearchBar extends ConsumerWidget {
  const ContactsSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(contactsProvider.notifier);

    return TextField(
      onChanged: notifier.searchContacts,
      decoration: InputDecoration(
        hintText: 'Search contacts',
        hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade500),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 8.w),
          child: Icon(Icons.search, color: Colors.grey.shade600, size: 24.r),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        filled: true,
        fillColor: const Color(0xFFF5F5F7),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.r), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.r), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.r), borderSide: BorderSide.none),
      ),
    );
  }
}
