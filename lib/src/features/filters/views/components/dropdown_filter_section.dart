import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/features/filters/controller/filters.dart';
import 'package:gian_ticket_task/src/features/filters/model/response/filters.dart';

class DropdownFilterSection extends ConsumerWidget {
  final FilterSection section;
  const DropdownFilterSection({super.key, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(filtersProvider.notifier);
    final selectedLabel = notifier.getSelectedDropdownLabel(section.id, section.options);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedLabel != null ? section.options.firstWhere((o) => o.label == selectedLabel).id : null,
          hint: Text(
            'Select ${section.label.toLowerCase()}',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.grey.shade600),
          ),
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
          isExpanded: true,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black87),
          borderRadius: BorderRadius.circular(4.r),
          items: section.options.map((option) {
            return DropdownMenuItem<String>(value: option.id, child: Text(option.label));
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              notifier.selectDropdown(section.id, value);
            }
          },
        ),
      ),
    );
  }
}
