import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gian_ticket_task/src/features/contatcs/model/response/contatcs.dart';
import 'package:gian_ticket_task/src/features/contatcs/services/contact_service.dart';

typedef ContactsNotifier = AsyncNotifierProvider<ContactsProvider, List<Contact>>;

final contactsProvider = ContactsNotifier(ContactsProvider.new);

class ContactsProvider extends AsyncNotifier<List<Contact>> {
  List<Contact> _allContacts = [];
  String _searchQuery = '';

  @override
  Future<List<Contact>> build() async {
    _allContacts = await ContactService().fetchContacts();
    return _allContacts;
  }

  void searchContacts(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      state = AsyncData(_allContacts);
    } else {
      final filtered = _allContacts.where((c) => c.matches(query)).toList();
      state = AsyncData(filtered);
    }
  }

  /// Delete contact by ID
  void deleteContact(String id) {
    _allContacts.removeWhere((c) => c.id == id);
    // Re-apply search if exists
    if (_searchQuery.isNotEmpty) {
      final filtered = _allContacts.where((c) => c.matches(_searchQuery)).toList();
      state = AsyncData(filtered);
    } else {
      state = AsyncData(List.from(_allContacts));
    }
  }

  /// Refresh contacts
  Future<void> refreshContacts() async {
    state = const AsyncLoading();
    _allContacts = await ContactService().fetchContacts();
    // Re-apply search if exists
    if (_searchQuery.isNotEmpty) {
      final filtered = _allContacts.where((c) => c.matches(_searchQuery)).toList();
      state = AsyncData(filtered);
    } else {
      state = AsyncData(_allContacts);
    }
  }
}
