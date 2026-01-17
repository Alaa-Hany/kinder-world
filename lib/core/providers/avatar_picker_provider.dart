import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/constants/app_constants.dart';

/// Manages the currently selected child avatar asset path.
class AvatarPickerNotifier extends StateNotifier<String> {
  AvatarPickerNotifier([String? initial])
      : super(initial ?? AppConstants.defaultChildAvatar);

  static const List<String> availableAvatars = [
    'assets/avatars/kids/boy_01.png',
    'assets/avatars/kids/boy_02.png',
    'assets/avatars/kids/girl_01.png',
    'assets/avatars/kids/girl_02.png',
    'assets/avatars/kids/neutral_01.png',
  ];

  void selectAvatar(String avatarPath) {
    state = avatarPath;
  }

  void selectRandomAvatar() {
    final random = Random();
    state = availableAvatars[random.nextInt(availableAvatars.length)];
  }
}

final avatarPickerProvider =
    StateNotifierProvider<AvatarPickerNotifier, String>((ref) {
  return AvatarPickerNotifier();
});

final availableAvatarsProvider = Provider<List<String>>((ref) {
  return AvatarPickerNotifier.availableAvatars;
});
