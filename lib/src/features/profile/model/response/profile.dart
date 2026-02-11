class Profile {
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String imageUrl;
  final List<AssignedRole> assignedRoles;

  const Profile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.imageUrl,
    this.assignedRoles = const [],
  });
}

class AssignedRole {
  final String title;
  final String group;
  final String managerName;
  final String managerImageUrl;

  const AssignedRole({
    required this.title,
    required this.group,
    required this.managerName,
    required this.managerImageUrl,
  });
}
