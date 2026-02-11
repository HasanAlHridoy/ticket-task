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

  @override
  Future<List<Ticket>> build() async {
    _allTickets = await TicketService().fetchTickets();
    ticketCount = _allTickets.length;
    return _allTickets;
  }

  /// Apply filters to the ticket list.
  void applyFilters({
    required Set<String> selectedBrands,
    required String? selectedPriority,
    required Set<String> selectedTags,
  }) {
    List<Ticket> filtered = List.from(_allTickets);

    // Filter by brand (senderName)
    if (selectedBrands.isNotEmpty) {
      filtered = filtered.where((t) {
        final brandId = t.senderName.toLowerCase().replaceAll(' ', '_');
        return selectedBrands.contains(brandId);
      }).toList();
    }

    // Filter by priority
    if (selectedPriority != null) {
      filtered = filtered.where((t) => t.priority.name == selectedPriority).toList();
    }

    // Filter by tags (ticket must have at least one of the selected tags)
    if (selectedTags.isNotEmpty) {
      filtered = filtered.where((t) {
        return t.tags.any((tag) => selectedTags.contains(tag.name));
      }).toList();
    }

    ticketCount = filtered.length;
    state = AsyncData(filtered);
  }

  /// Clear all filters and show all tickets.
  void clearFilters() {
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
