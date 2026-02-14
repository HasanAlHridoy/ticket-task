import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/features/profile/controller/profile.dart';
import 'package:gian_ticket_task/src/features/profile/views/components/assigned_roles_section.dart';
import 'package:gian_ticket_task/src/features/profile/views/components/basic_info_section.dart';
import 'package:gian_ticket_task/src/features/profile/views/components/profile_header.dart';

class ProfileView extends ConsumerWidget {
  static const String name = 'profile';
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My profile',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: profileAsync.when(
        data: (profile) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(profile: profile),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      BasicInfoSection(profile: profile),
                      SizedBox(height: 24.h),
                      AssignedRolesSection(roles: profile.assignedRoles),
                      SizedBox(height: 24.h),
                      _LogoutButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.logout, color: Colors.red.shade400),
        label: Text(
          'Log out',
          style: TextStyle(color: Colors.red.shade400, fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFEAEA),
          foregroundColor: Colors.red.shade400,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        ),
      ),
    );
  }
}
