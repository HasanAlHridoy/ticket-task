class Contact {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String imageUrl;

  const Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.imageUrl,
  });

  // Helper for search
  bool matches(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
}
