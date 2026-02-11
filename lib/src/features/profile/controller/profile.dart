import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gian_ticket_task/src/features/profile/model/response/profile.dart';
import 'package:gian_ticket_task/src/features/profile/services/profile_service.dart';

typedef ProfileNotifier = AsyncNotifierProvider<ProfileProvider, Profile>;

final profileProvider = ProfileNotifier(ProfileProvider.new);

class ProfileProvider extends AsyncNotifier<Profile> {
  @override
  Future<Profile> build() async {
    return ProfileService().fetchProfile();
  }

  Future<void> refreshProfile() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ProfileService().fetchProfile());
  }
}
