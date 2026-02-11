import 'package:gian_ticket_task/src/features/contatcs/model/response/contatcs.dart';

class ContactService {
  Future<List<Contact>> fetchContacts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data matching the design
    return [
      const Contact(
        id: '1',
        name: 'Michale Kahnwald',
        email: 'michel@email.com',
        phone: '+12 34 56 78 90',
        address: '12A, Lillistrom, Norway',
        imageUrl: 'https://i.pravatar.cc/150?u=1',
      ),
      const Contact(
        id: '2',
        name: 'Noah',
        email: 'michel@email.com',
        phone: '+12 34 56 78 90',
        address: '12A, Lillistrom, Norway',
        imageUrl: 'https://i.pravatar.cc/150?u=2',
      ),
      const Contact(
        id: '3',
        name: 'Jonus Kajhnwald',
        email: 'michel@email.com',
        phone: '+12 34 56 78 90',
        address: '12A, Lillistrom, Norway',
        imageUrl: 'https://i.pravatar.cc/150?u=3',
      ),
      const Contact(
        id: '4',
        name: 'Martha Nielsen',
        email: 'martha@email.com',
        phone: '+49 123 456 789',
        address: 'Winden, Germany',
        imageUrl: 'https://i.pravatar.cc/150?u=4',
      ),
      const Contact(
        id: '5',
        name: 'Ulrich Nielsen',
        email: 'ulrich@email.com',
        phone: '+49 987 654 321',
        address: 'Winden, Germany',
        imageUrl: 'https://i.pravatar.cc/150?u=5',
      ),
      const Contact(
        id: '6',
        name: 'Katharina Albers',
        email: 'katharina@email.com',
        phone: '+49 555 123 456',
        address: 'Winden, Germany',
        imageUrl: 'https://i.pravatar.cc/150?u=6',
      ),
    ];
  }
}
