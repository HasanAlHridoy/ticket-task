import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gian_ticket_task/src/features/home/model/response/ticket_model.dart';
import 'package:gian_ticket_task/src/features/home/services/ticket_service.dart';

typedef HomeNotifier = AsyncNotifierProvider<HomeProvider, List<Ticket>>;

final homeProvider = HomeNotifier(HomeProvider.new);

class HomeProvider extends AsyncNotifier<List<Ticket>> {
  int ticketCount = 0;

  /// All tickets from the API (unfiltered).
  List<Ticket> _allTickets = [];
  List<Ticket> get allTickets => _allTickets;

  /// Currently applied filter selections.
  Map<String, Set<String>> _appliedSelections = {};
  Map<String, Set<String>> get appliedSelections => _appliedSelections;

  @override
  Future<List<Ticket>> build() async {
    _allTickets = await TicketService().fetchTickets();
    ticketCount = _allTickets.length;
    return _allTickets;
  }

  /// Apply filters to the ticket list.
  void applyFilters({required Map<String, Set<String>> selections}) {
    _appliedSelections = Map.from(selections);
    List<Ticket> filtered = List.from(_allTickets);

    for (final entry in selections.entries) {
      final sectionId = entry.key;
      final selectedIds = entry.value;

      if (selectedIds.isEmpty) continue;

      switch (sectionId) {
        case 'brand':
          filtered = filtered.where((t) {
            final brandId = t.senderName.toLowerCase().replaceAll(' ', '_');
            return selectedIds.contains(brandId);
          }).toList();
        case 'priority':
          final selectedPriority = selectedIds.firstOrNull;
          if (selectedPriority != null) {
            filtered = filtered.where((t) => t.priority.name == selectedPriority).toList();
          }
        case 'tags':
          filtered = filtered.where((t) {
            return t.tags.any((tag) => selectedIds.contains(tag.name));
          }).toList();
        case 'overdue':
          final selectedValue = selectedIds.firstOrNull;
          if (selectedValue != null) {
            final isOverdue = selectedValue == 'true';
            filtered = filtered.where((t) => t.isOverdue == isOverdue).toList();
          }
      }
    }

    ticketCount = filtered.length;
    state = AsyncData(filtered);
  }

  /// Clear all filters and show all tickets.
  void clearFilters() {
    _appliedSelections = {};
    ticketCount = _allTickets.length;
    state = AsyncData(_allTickets);
  }

  /// Pull-to-refresh: re-fetch tickets and clear all filters.
  Future<void> refreshTickets() async {
    state = const AsyncLoading();
    _allTickets = await TicketService().fetchTickets();
    ticketCount = _allTickets.length;
    state = AsyncData(_allTickets);
  }
}
