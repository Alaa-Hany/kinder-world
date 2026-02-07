import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kinder_world/core/models/privacy_settings.dart';

const _privacyBox = 'privacy_settings';
const _privacyKey = 'privacy_settings_value';

final privacySettingsProvider = FutureProvider<PrivacySettings>((ref) async {
  final box = Hive.box(_privacyBox);
  final raw = box.get(_privacyKey);

  if (raw != null) {
    return _deserialize(raw);
  }

  final defaults = PrivacySettings.defaults();
  await box.put(_privacyKey, defaults.toJson());
  return defaults;
});

final privacyControllerProvider =
    StateNotifierProvider<PrivacyController, AsyncValue<PrivacySettings>>(
  (ref) {
    final box = Hive.box(_privacyBox);
    return PrivacyController(box: box);
  },
);

class PrivacyController extends StateNotifier<AsyncValue<PrivacySettings>> {
  final Box _box;

  PrivacyController({required Box box})
      : _box = box,
        super(const AsyncValue.loading()) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    state = const AsyncValue.loading();
    final raw = _box.get(_privacyKey);
    final settings =
        raw != null ? _deserialize(raw) : PrivacySettings.defaults();
    state = AsyncValue.data(settings);
  }

  Future<bool> updateSettings(PrivacySettings settings) async {
    state = AsyncValue.data(settings);
    try {
      await _box.put(_privacyKey, settings.toJson());
      return true;
    } catch (_) {
      final currentSettings = _deserialize(_box.get(_privacyKey));
      state = AsyncValue.data(currentSettings);
      return false;
    }
  }
}

PrivacySettings _deserialize(dynamic raw) {
  if (raw is Map) {
    return PrivacySettings.fromJson(Map<String, dynamic>.from(raw));
  }
  return PrivacySettings.defaults();
}
