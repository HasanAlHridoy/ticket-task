import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/context.dart';
import 'package:gian_ticket_task/src/core/utils/theme/theme.dart';
import 'package:gian_ticket_task/src/features/filters/controller/filters.dart';
import 'package:gian_ticket_task/src/features/filters/model/response/filters.dart';

class FiltersView extends ConsumerWidget {
  const FiltersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncConfig = ref.watch(filtersProvider);
    final notifier = ref.read(filtersProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, size: 24.r),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Filters',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        elevation: 0,
        actionsPadding: EdgeInsets.symmetric(horizontal: 16.w),
        actions: [
          TextButton(
            onPressed: () {
              // Apply filters and go back
              notifier.applyFilters();
              Navigator.of(context).pop();
            },
            child: Text(
              'Apply',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.grey),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: asyncConfig.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
          data: (config) => ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            itemCount: config.sections.length,
            itemBuilder: (context, index) {
              final section = config.sections[index];
              return _buildSection(context, ref, notifier, section);
            },
          ),
        ),
      ),
    );
  }

  /// Builds a single filter section based on its type.
  Widget _buildSection(BuildContext context, WidgetRef ref, FiltersProvider notifier, FilterSection section) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section label
          Text(
            section.label,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: context.theme.primaryColorDark),
          ),
          SizedBox(height: 12.h),

          // Section content based on type
          switch (section.type) {
            FilterSectionType.checkbox => _buildCheckboxSection(context, notifier, section),
            FilterSectionType.dropdown => _buildDropdownSection(context, notifier, section),
            FilterSectionType.tags => _buildTagsSection(context, notifier, section),
          },
        ],
      ),
    );
  }

  // ─── CHECKBOX SECTION ────────────────────────────────────────────────

  Widget _buildCheckboxSection(BuildContext context, FiltersProvider notifier, FilterSection section) {
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
                // Checkbox
                SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: Checkbox(value: isSelected, onChanged: (_) => notifier.toggleCheckbox(section.id, option.id)),
                ),
                SizedBox(width: 12.w),

                // Brand icon placeholder
                if (option.iconUrl != null) ...[
                  Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: BoxDecoration(color: primaryColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: Icon(Icons.language, size: 18.r, color: primaryColor),
                  ),
                  SizedBox(width: 12.w),
                ],

                // Label
                Expanded(
                  child: Text(
                    option.label,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: context.theme.primaryColorDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ─── DROPDOWN SECTION ────────────────────────────────────────────────

  Widget _buildDropdownSection(BuildContext context, FiltersProvider notifier, FilterSection section) {
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
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: context.theme.primaryColorDark),
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

  // ─── TAGS SECTION ────────────────────────────────────────────────────

  Widget _buildTagsSection(BuildContext context, FiltersProvider notifier, FilterSection section) {
    final selected = notifier.getSelections(section.id);
    final query = notifier.tagSearchQuery.toLowerCase();

    // Filter options based on search query
    final visibleOptions = query.isEmpty
        ? section.options
        : section.options.where((o) => o.label.toLowerCase().contains(query)).toList();

    return Column(
      children: [
        // Search field
        TextField(
          onChanged: notifier.updateTagSearch,
          decoration: InputDecoration(
            hintText: 'Search tags',
            hintStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.grey.shade600),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 8.w),
              child: Icon(Icons.search, color: Colors.grey.shade800, size: 22.r),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(28.r), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(28.r), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(28.r), borderSide: BorderSide.none),
          ),
        ),
        SizedBox(height: 16.h),

        // Tag chips
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
                    color: isSelected ? primaryColor.withValues(alpha: 0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    border: isSelected
                        ? Border.all(color: primaryColor, width: 1)
                        : Border.all(color: Colors.grey, width: 0.5),
                  ),
                  child: Text(
                    option.label,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
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
