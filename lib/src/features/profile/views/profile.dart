import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/context.dart';
import 'package:gian_ticket_task/src/features/profile/controller/profile.dart';
import 'package:gian_ticket_task/src/features/profile/model/response/profile.dart';

class ProfileView extends ConsumerWidget {
  static const String name = 'profile';
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'My profile',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: profileAsync.when(
        data: (profile) => _buildProfileContent(context, profile),
        loading: () => Center(child: CircularProgressIndicator(color: context.theme.primaryColor)),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, Profile profile) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              color: const Color(0xFFEAF8FB), // Light blue background
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36.r,
                    backgroundImage: NetworkImage(profile.imageUrl),
                    backgroundColor: Colors.grey.shade300,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${profile.firstName} ${profile.lastName}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4A5568),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          profile.role,
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit_outlined, color: Colors.black54, size: 24.r),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  // Basic Info
                  Text(
                    'Basic info',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 16.h),
                  _buildInfoField('First name', profile.firstName),
                  _buildInfoField('Last name', profile.lastName),
                  _buildInfoField('Email', profile.email),

                  SizedBox(height: 32.h),
                  // Assigned Roles
                  Text(
                    'Assigned roles (${profile.assignedRoles.length})',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 200.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: profile.assignedRoles.length,
                      separatorBuilder: (context, index) => SizedBox(width: 16.w),
                      itemBuilder: (context, index) {
                        return _buildRoleCard(profile.assignedRoles[index]);
                      },
                    ),
                  ),

                  SizedBox(height: 40.h),
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.logout, color: Colors.red.shade400),
                      label: Text(
                        'Log out',
                        style: TextStyle(color: Colors.red.shade400, fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFEAEA), // Light pinkish
                        foregroundColor: Colors.red.shade400,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade500),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard(AssignedRole role) {
    return Container(
      width: 260.w,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA), // Very light grey
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            role.title,
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w400, color: Colors.black87),
          ),
          Divider(color: Colors.grey.shade300, height: 24.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Group',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
              ),
              SizedBox(height: 4.h),
              Text(
                role.group,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Manager',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12.r,
                          backgroundImage: NetworkImage(role.managerImageUrl),
                          backgroundColor: Colors.grey.shade300,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          role.managerName,
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
