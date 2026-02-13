class Ticket {
  final String id;
  final String title;
  final String description; // "Search view, which can display dynamic..."
  final String senderName;
  final String brand;
  final DateTime dateTime;
  final TicketStatus status;

  final TicketPriority priority;
  final bool isOverdue;
  final bool customerResponded;

  final List<TicketTagType> tags;

  Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.senderName,
    required this.brand,
    required this.dateTime,
    required this.status,
    required this.priority,
    this.isOverdue = false,
    this.customerResponded = false,
    required this.tags,
  });
}

enum TicketTagType { urgent, low, open, spam, closed }

enum TicketStatus { open, closed, spam }

enum TicketPriority { low, medium, urgent }
