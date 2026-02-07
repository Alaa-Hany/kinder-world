import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/app.dart';
import 'package:kinder_world/core/storage/secure_storage.dart';
import 'package:logger/logger.dart';

final profileControllerProvider =
    StateNotifierProvider<ProfileController, AsyncValue<void>>(
  (ref) {
    final storage = ref.watch(secureStorageProvider);
    final logger = ref.watch(loggerProvider);
    return ProfileController(storage: storage, logger: logger);
  },
);

final parentNameProvider = FutureProvider<String?>((ref) async {
  final storage = ref.watch(secureStorageProvider);
  return await storage.getParentName();
});

class ProfileController extends StateNotifier<AsyncValue<void>> {
  final SecureStorage _storage;
  final Logger _logger;

  ProfileController({
    required SecureStorage storage,
    required Logger logger,
  })  : _storage = storage,
        _logger = logger,
        super(const AsyncValue.data(null));

  Future<bool> updateParentName(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      state = AsyncValue.error('Name cannot be empty', StackTrace.current);
      return false;
    }

    state = const AsyncValue.loading();
    try {
      final saved = await _storage.saveParentName(trimmed);
      if (saved) {
        state = const AsyncValue.data(null);
        return true;
      }
      state = AsyncValue.error(
        'Failed to save name',
        StackTrace.current,
      );
      return false;
    } catch (e, st) {
      _logger.e('Error saving parent name: $e', stackTrace: st);
      state = AsyncValue.error('Failed to save name', st);
      return false;
    }
  }
}
