import 'package:gian_ticket_task/src/features/profile/model/response/profile.dart';

class ProfileService {
  Future<Profile> fetchProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data matching the design
    return const Profile(
      firstName: 'Jonaus',
      lastName: 'Kahnwald',
      email: 'Username@email.com',
      role: 'Support',
      imageUrl: 'https://i.pravatar.cc/300?u=jonaus',
      assignedRoles: [
        AssignedRole(
          title: 'Manager',
          group: 'Codecyaneon support',
          managerName: 'Jonaus Kahnwald',
          managerImageUrl: 'https://i.pravatar.cc/150?u=jonaus',
        ),
        AssignedRole(
          title: 'Agent',
          group: 'Lara support',
          managerName: 'Lara Croft',
          managerImageUrl: 'https://i.pravatar.cc/150?u=lara',
        ),
        AssignedRole(
          title: 'Admin',
          group: 'Global support',
          managerName: 'Admin User',
          managerImageUrl: 'https://i.pravatar.cc/150?u=admin',
        ),
      ],
    );
  }
}
