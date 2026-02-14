import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/utils/theme/theme.dart';
import 'package:gian_ticket_task/src/features/filters/controller/filters.dart';
import 'package:gian_ticket_task/src/features/filters/model/response/filters.dart';

class CheckboxFilterSection extends ConsumerWidget {
  final FilterSection section;
  const CheckboxFilterSection({super.key, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(filtersProvider.notifier);
    final selected = notifier.getSelections(section.id);

    return Column(
      children: section.options.map((option) {
        final isSelected = selected.contains(option.id);
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () => notifier.toggleCheckbox(section.id, option.id),
            child: Row(
              children: [
                SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: Checkbox(
                    value: isSelected,
                    onChanged: (_) => notifier.toggleCheckbox(section.id, option.id),
                    activeColor: primaryColor,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    option.label,
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
