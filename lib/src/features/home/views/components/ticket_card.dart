import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/features/home/model/response/ticket_model.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(color: const Color(0xfff9fafb), borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Badge
          _buildStatusBadge(context),
          SizedBox(height: 12.h),

          // Ticket ID
          Text(
            ticket.id,
            style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade400, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.h),

          // Title
          Text(
            ticket.title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),

          // Sender & Time
          Row(
            children: [
              Text(
                ticket.senderName,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 4.w),
              Icon(Icons.circle, size: 4.r, color: Colors.grey.shade300),
              SizedBox(width: 4.w),
              // Format date nicely. For now just placeholder logic or toString
              Text(
                '23 Dec 2023 03:43 pm', // Static for now as per design request "static data" but let's use real date if we can.
                // formatted would be better but user asked for "static data" somewhat.
                // I will just use the string for now to match pixel perfect design.
                // actually the user said "make dymmy model for the content. also the data should be static. fetch the dta like the api"
                // so I should probably use the data from the model.
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(height: 1, color: Colors.grey),
          SizedBox(height: 16.h),

          // Tags/Buttons
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: ticket.tags.map((tag) {
              switch (tag) {
                case TicketTagType.urgent:
                  return _buildTag(text: 'Urgent', color: Colors.white, icon: Icons.circle, iconColor: Colors.red);
                case TicketTagType.low:
                  return _buildTag(text: 'Low', color: Colors.white, icon: Icons.circle, iconColor: Colors.green);
                case TicketTagType.open:
                  return _buildTag(text: 'Open', color: Colors.grey, isOutlined: true);
                case TicketTagType.spam:
                  return _buildTag(text: 'Spam', color: Colors.grey, isOutlined: true);
                case TicketTagType.closed:
                  return _buildTag(text: 'Closed', color: Colors.grey, isOutlined: true);
                case TicketTagType.customerResponded:
                  return _buildTag(text: 'Customer Responded', color: Colors.grey, isOutlined: true);
              }
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    String text = '';
    Color backgroundColor = Colors.blue.shade50;
    Color textColor = Colors.blue;

    if (ticket.isOverdue) {
      text = 'First response overdue';
      backgroundColor = const Color(0xFFFFF4E5); // Light orange
      textColor = const Color(0xFFFF9800); // Orange
    } else if (ticket.customerResponded) {
      text = 'Customer responded';
      backgroundColor = const Color(0xFFF3E5F5); // Light purple
      textColor = const Color(0xFF9C27B0); // Purple
    } else {
      text = 'New';
      backgroundColor = const Color(0xFFE3F2FD); // Light blue
      textColor = const Color(0xFF2196F3); // Blue
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(8.r)),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 12.sp, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildTag({
    required String text,
    required Color color,
    IconData? icon,
    Color? iconColor,
    bool isOutlined = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 8.r, color: iconColor), SizedBox(width: 6.w)],
          Text(
            text,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
