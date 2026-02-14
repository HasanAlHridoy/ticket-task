import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gian_ticket_task/src/features/filters/model/response/filters.dart';
import 'package:gian_ticket_task/src/features/filters/services/filter_service.dart';
import 'package:gian_ticket_task/src/features/home/controller/home.dart';

typedef FiltersNotifier = AutoDisposeAsyncNotifierProvider<FiltersProvider, FilterConfig>;

final filtersProvider = FiltersNotifier(FiltersProvider.new);

class FiltersProvider extends AutoDisposeAsyncNotifier<FilterConfig> {
  /// Tracks selected values per section. Key = section.id, Value = set of option.id's.
  final Map<String, Set<String>> _selections = {};

  /// Search query for the "tags" section.
  String _tagSearchQuery = '';
  String get tagSearchQuery => _tagSearchQuery;

  @override
  Future<FilterConfig> build() async {
    debugPrint('FiltersProvider: loading filter config...');

    // Get ALL tickets (unfiltered) from HomeProvider to derive filter options
    final homeNotifier = ref.read(homeProvider.notifier);
    final tickets = homeNotifier.allTickets;

    // Get currently applied selections to ensure those sections are visible
    final applied = homeNotifier.appliedSelections;
    final activeSectionIds = applied.entries.where((e) => e.value.isNotEmpty).map((e) => e.key).toSet();

    final config = await FilterService().fetchFilters(tickets, forcedSectionIds: activeSectionIds);

    // Initialize selections from HomeProvider's persistent state
    _selections.clear();
    for (final section in config.sections) {
      _selections[section.id] = Set.from(applied[section.id] ?? {});
    }

    return config;
  }

  /// Get the selected option ids for a section.
  Set<String> getSelections(String sectionId) {
    return _selections[sectionId] ?? {};
  }

  /// Toggle a checkbox option on/off.
  void toggleCheckbox(String sectionId, String optionId) {
    final set = _selections.putIfAbsent(sectionId, () => {});
    if (set.contains(optionId)) {
      set.remove(optionId);
    } else {
      set.add(optionId);
    }
    ref.notifyListeners();
  }

  /// Select a single dropdown value (replaces previous selection).
  void selectDropdown(String sectionId, String optionId) {
    _selections[sectionId] = {optionId};
    ref.notifyListeners();
  }

  /// Toggle a tag chip on/off.
  void toggleTag(String sectionId, String optionId) {
    toggleCheckbox(sectionId, optionId);
  }

  /// Update the tag search query.
  void updateTagSearch(String query) {
    _tagSearchQuery = query;
    ref.notifyListeners();
  }

  /// Clear all filters.
  void clearFilters() {
    _selections.clear();
    _tagSearchQuery = '';
    ref.read(homeProvider.notifier).clearFilters();
    ref.notifyListeners();
  }

  /// Apply filters — tells HomeProvider to filter the tickets.
  void applyFilters() {
    final homeNotifier = ref.read(homeProvider.notifier);
    homeNotifier.applyFilters(selections: _selections);
  }

  /// Get the currently selected dropdown label for a section (if any).
  String? getSelectedDropdownLabel(String sectionId, List<FilterOption> options) {
    final selected = _selections[sectionId];
    if (selected == null || selected.isEmpty) return null;
    final optionId = selected.first;
    try {
      return options.firstWhere((o) => o.id == optionId).label;
    } catch (_) {
      return null;
    }
  }
}
