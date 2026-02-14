import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/utils/theme/theme.dart';
import 'package:gian_ticket_task/src/features/filters/controller/filters.dart';
import 'package:gian_ticket_task/src/features/filters/model/response/filters.dart';

class TagsFilterSection extends ConsumerWidget {
  final FilterSection section;
  const TagsFilterSection({super.key, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(filtersProvider.notifier);
    final selected = notifier.getSelections(section.id);
    final query = notifier.tagSearchQuery.toLowerCase();

    final visibleOptions = query.isEmpty
        ? section.options
        : section.options.where((o) => o.label.toLowerCase().contains(query)).toList();

    return Column(
      children: [
        TextField(
          onChanged: notifier.updateTagSearch,
          decoration: InputDecoration(
            hintText: 'Search tags',
            hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 12.w, right: 8.w),
              child: Icon(Icons.search, color: Colors.grey.shade800, size: 22.r),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(28.r), borderSide: BorderSide.none),
          ),
        ),
        SizedBox(height: 16.h),
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 8.w,
            runSpacing: 10.h,
            children: visibleOptions.map((option) {
              final isSelected = selected.contains(option.id);
              return GestureDetector(
                onTap: () => notifier.toggleTag(section.id, option.id),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    border: isSelected
                        ? Border.all(color: primaryColor, width: 1)
                        : Border.all(color: Colors.grey, width: 0.5),
                  ),
                  child: Text(
                    option.label,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? primaryColor : Colors.grey.shade700,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
