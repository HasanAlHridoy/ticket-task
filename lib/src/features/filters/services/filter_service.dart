import 'package:gian_ticket_task/src/features/home/model/response/ticket_model.dart';

import '../model/response/filters.dart';

class FilterService {
  /// Builds filter configuration dynamically from the actual ticket data.
  /// In production this would be an API call; here we derive it from tickets.
  Future<FilterConfig> fetchFilters(List<Ticket> tickets) async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 300));

    return _buildFilterConfig(tickets);
  }

  FilterConfig _buildFilterConfig(List<Ticket> tickets) {
    // ── Extract unique priorities from tickets ──
    final priorities = tickets.map((t) => t.priority).toSet();
    final priorityOptions = priorities.map((p) {
      final name = p.name[0].toUpperCase() + p.name.substring(1); // capitalize
      return FilterOption(id: p.name, label: name);
    }).toList();

    // ── Extract unique tags from tickets ──
    final tags = <TicketTagType>{};
    for (final ticket in tickets) {
      tags.addAll(ticket.tags);
    }
    final tagOptions = tags.map((t) {
      final name = _formatTagName(t);
      return FilterOption(id: t.name, label: name);
    }).toList();

    // ── Extract unique brands ──
    final brands = tickets.map((t) => t.brand).toSet();
    final brandOptions = brands.map((b) {
      return FilterOption(id: b.toLowerCase().replaceAll(' ', '_'), label: b, iconUrl: b.toLowerCase());
    }).toList();

    return FilterConfig(
      sections: [
        FilterSection(id: 'brand', label: 'Brand', type: FilterSectionType.checkbox, options: brandOptions),
        FilterSection(id: 'priority', label: 'Priority', type: FilterSectionType.dropdown, options: priorityOptions),
        FilterSection(id: 'tags', label: 'Tags', type: FilterSectionType.tags, options: tagOptions),
      ],
    );
  }

  String _formatTagName(TicketTagType tag) {
    return switch (tag) {
      TicketTagType.urgent => 'Urgent',
      TicketTagType.low => 'Low',
      TicketTagType.open => 'Open',
      TicketTagType.spam => 'Spam',
      TicketTagType.closed => 'Closed',
    };
  }
}
