import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/features/filters/model/response/filters.dart';

import 'checkbox_filter_section.dart';
import 'dropdown_filter_section.dart';
import 'tags_filter_section.dart';

class FilterSectionHub extends StatelessWidget {
  final FilterSection section;
  const FilterSectionHub({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.label,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: const Color(0xFF5C5D76)),
          ),
          SizedBox(height: 12.h),
          switch (section.type) {
            FilterSectionType.checkbox => CheckboxFilterSection(section: section),
            FilterSectionType.dropdown => DropdownFilterSection(section: section),
            FilterSectionType.tags => TagsFilterSection(section: section),
          },
        ],
      ),
    );
  }
}
