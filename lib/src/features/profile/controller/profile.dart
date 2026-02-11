import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ProfileNotifier = NotifierProvider<ProfileProvider, void>;

final profileProvider = ProfileNotifier(ProfileProvider.new);

class ProfileProvider extends Notifier<void> {
  @override
  void build() {
    debugPrint('ProfileProvider');
  }
}
