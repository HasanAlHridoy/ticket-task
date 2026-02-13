import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/context.dart';
import 'package:gian_ticket_task/src/features/contatcs/controller/contatcs.dart';
import 'package:gian_ticket_task/src/features/contatcs/model/response/contatcs.dart';

class ContacsView extends ConsumerWidget {
  static const String name = 'contacts';
  const ContacsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(contactsProvider);
    final notifier = ref.read(contactsProvider.notifier);

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
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            // Search Bar
            TextField(
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
                fillColor: const Color(0xFFF5F5F7), // Light grey background
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.r), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 22.h),
            // Contact Count
            contactsAsync.when(
              data: (contacts) => Text(
                '${contacts.length} Contacts',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
              ),
              loading: () => const SizedBox.shrink(),
              error: (error, stack) => const SizedBox.shrink(),
            ),
            SizedBox(height: 22.h),
            // Contact List
            Expanded(
              child: contactsAsync.when(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final Contact contact;
  const ContactCard({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB), // Very light grey/white
        borderRadius: BorderRadius.circular(8.r),
        // border: Border.all(color: Colors.grey.shade200), // Optional border if needed for contrast
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: NetworkImage(contact.imageUrl),
                backgroundColor: Colors.grey.shade300,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  contact.name,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
              Consumer(
                builder: (context, ref, _) {
                  return PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, color: Colors.black87, size: 24.r),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    onSelected: (value) {
                      if (value == 'delete') {
                        ref.read(contactsProvider.notifier).deleteContact(contact.id);
                      } else {
                        // Show a nice dialog for not implemented features
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                            child: Padding(
                              padding: EdgeInsets.all(24.r),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(16.r),
                                    decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle),
                                    child: Icon(Icons.construction, size: 32.r, color: Colors.blue),
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    'Coming Soon',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'The "$value" feature is not yet available.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
                                  ),
                                  SizedBox(height: 24.h),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        padding: EdgeInsets.symmetric(vertical: 12.h),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                                      ),
                                      child: Text(
                                        'Close',
                                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'Edit',
                        child: Text(
                          'Edit',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'View tickets',
                        child: Text(
                          'View tickets',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: Text(
                          'Delete',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(Icons.email_outlined, contact.email),
          SizedBox(height: 4.h),
          _buildInfoRow(Icons.phone_outlined, contact.phone),
          SizedBox(height: 4.h),
          _buildInfoRow(Icons.location_on_outlined, contact.address),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.r, color: Colors.grey.shade500),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
          ),
        ),
      ],
    );
  }
}
