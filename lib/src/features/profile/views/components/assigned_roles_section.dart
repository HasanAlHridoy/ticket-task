import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/features/profile/model/response/profile.dart';

class AssignedRolesSection extends StatelessWidget {
  final List<AssignedRole> roles;
  const AssignedRolesSection({super.key, required this.roles});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Assigned roles (${roles.length})',
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 180.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: roles.length,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              return RoleCard(role: roles[index]);
            },
          ),
        ),
      ],
    );
  }
}

class RoleCard extends StatelessWidget {
  final AssignedRole role;
  const RoleCard({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            role.title,
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500, color: Colors.black87),
          ),
          Divider(color: Colors.grey.shade300, height: 16.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Group',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade500),
              ),
              SizedBox(height: 4.h),
              Text(
                role.group,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade700),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Manager',
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade500),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16.r,
                          backgroundImage: NetworkImage(role.managerImageUrl),
                          backgroundColor: Colors.grey.shade300,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          role.managerName,
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade700),
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
