import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/gap.dart';
import 'package:gian_ticket_task/src/features/profile/model/response/profile.dart';

class ProfileHeader extends StatelessWidget {
  final Profile profile;
  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        8.ph,
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          color: const Color(0xFFE6F6FC),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.r,
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
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: const Color(0xFF5C5D76)),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      profile.role,
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit_outlined, color: Colors.black87, size: 24.r),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
