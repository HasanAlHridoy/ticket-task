import 'dart:math';

import 'package:gian_ticket_task/src/features/home/model/response/ticket_model.dart';

class TicketService {
  final Random _random = Random();

  Future<List<Ticket>> fetchTickets() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    List<Ticket> tickets = [
      Ticket(
        id: '#ID 132198423',
        title: 'Search view, which can display dynamic suggestions, is the focused state of...',
        description: 'Search view, which can display dynamic suggestions, is the focused state of...',
        senderName: 'Michale',
        dateTime: DateTime.now().subtract(const Duration(minutes: 5)),
        status: TicketStatus.open,
        priority: TicketPriority.low,
        tags: [TicketTagType.low, TicketTagType.open],
      ),
      Ticket(
        id: '#ID 132198424',
        title: 'Ticket subject small',
        description: 'Ticket subject small',
        senderName: 'Noah',
        dateTime: DateTime.now().subtract(const Duration(hours: 1)),

        status: TicketStatus.open,
        priority: TicketPriority.urgent,
        isOverdue: true,
        tags: [TicketTagType.urgent, TicketTagType.open, TicketTagType.spam],
      ),
      Ticket(
        id: '#ID 132198425',
        title: 'Search view, which can display dynamic suggestions, is the focused state of...',
        description: 'Search view, which can display dynamic suggestions, is the focused state of...',
        senderName: 'Jonus',
        dateTime: DateTime.now().subtract(const Duration(hours: 2)),
        status: TicketStatus.open,
        priority: TicketPriority.low,
        customerResponded: true,
        tags: [TicketTagType.low, TicketTagType.open],
      ),
    ];

    // Generate more dummy data
    for (int i = 4; i <= 25; i++) {
      final isEven = i % 2 == 0;
      final isThird = i % 3 == 0;

      TicketPriority priority;
      if (i % 5 == 0) {
        priority = TicketPriority.urgent;
      } else if (isEven) {
        priority = TicketPriority.medium;
      } else {
        priority = TicketPriority.low;
      }

      TicketStatus status = TicketStatus.open;
      if (i == 10 || i == 20) status = TicketStatus.spam;
      if (i == 15) status = TicketStatus.closed;

      // Generate Random Tags
      List<TicketTagType> tags = [];
      // Add random priority tag
      if (_random.nextBool()) tags.add(TicketTagType.urgent);
      if (_random.nextBool()) tags.add(TicketTagType.low);
      // Add random status tag
      if (_random.nextBool()) tags.add(TicketTagType.open);
      if (_random.nextBool()) tags.add(TicketTagType.spam);

      // Ensure at least one tag
      if (tags.isEmpty) tags.add(TicketTagType.open);

      tickets.add(
        Ticket(
          id: '#ID ${132198420 + i}',
          title: isThird ? 'Ticket subject small $i' : 'Search view, which can display dynamic suggestions $i',
          description: 'Description for ticket $i',
          senderName: isEven ? 'User $i' : 'Sender $i',
          dateTime: DateTime.now().subtract(Duration(hours: i * 2)),
          status: status,
          priority: priority,
          isOverdue: i % 7 == 0,
          customerResponded: i % 4 == 0,
          tags: tags,
        ),
      );
    }

    return tickets;
  }
}
