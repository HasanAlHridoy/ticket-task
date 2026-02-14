import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/features/filters/controller/filters.dart';

class FiltersAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const FiltersAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(filtersProvider.notifier);

    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.close, size: 24.r),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Filters',
        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
      ),
      centerTitle: false,
      elevation: 0,
      actionsPadding: EdgeInsets.symmetric(horizontal: 16.w),
      actions: [
        TextButton(
          onPressed: () {
            notifier.applyFilters();
            Navigator.of(context).pop();
          },
          child: Text(
            'Apply',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
