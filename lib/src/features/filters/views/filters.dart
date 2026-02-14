import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/context.dart';
import 'package:gian_ticket_task/src/features/filters/controller/filters.dart';
import 'package:gian_ticket_task/src/features/filters/views/components/filter_section_hub.dart';
import 'package:gian_ticket_task/src/features/filters/views/components/filters_app_bar.dart';

class FiltersView extends ConsumerWidget {
  static const String name = 'filters';
  const FiltersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncConfig = ref.watch(filtersProvider);

    return Scaffold(
      appBar: const FiltersAppBar(),
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: asyncConfig.when(
          loading: () => Center(child: CircularProgressIndicator(color: context.theme.scaffoldBackgroundColor)),
          error: (error, stack) => Center(child: Text('Error: $error')),
          data: (config) => ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            itemCount: config.sections.length,
            itemBuilder: (context, index) {
              return FilterSectionHub(section: config.sections[index]);
            },
          ),
        ),
      ),
    );
  }
}
