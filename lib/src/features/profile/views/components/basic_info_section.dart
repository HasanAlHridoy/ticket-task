import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/features/profile/model/response/profile.dart';

class BasicInfoSection extends StatelessWidget {
  final Profile profile;
  const BasicInfoSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic info',
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoField('First name', profile.firstName),
              _buildInfoField('Last name', profile.lastName),
              _buildInfoField('Email', profile.email),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade500),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
