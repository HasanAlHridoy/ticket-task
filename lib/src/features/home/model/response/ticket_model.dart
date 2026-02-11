class Ticket {
  final String id;
  final String title;
  final String description; // "Search view, which can display dynamic..."
  final String senderName;
  final DateTime dateTime;
  final TicketStatus status;

  final TicketPriority priority;
  final bool isOverdue; // "First response overdue"
  final bool customerResponded; // "Customer responded"

  final List<TicketTagType> tags;

  Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.senderName,
    required this.dateTime,
    required this.status,
    required this.priority,
    this.isOverdue = false,

    this.customerResponded = false,
    required this.tags,
  });
}

enum TicketTagType { urgent, low, open, spam, closed, customerResponded }

enum TicketStatus { open, closed, spam }

enum TicketPriority { low, medium, urgent }
