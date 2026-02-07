import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kinder_world/core/models/child_profile.dart';
import 'package:kinder_world/core/repositories/child_repository.dart';
import 'package:kinder_world/app.dart';
import 'package:logger/logger.dart';

class ChildSessionState {
  final String? childId;
  final ChildProfile? childProfile;
  final bool isLoading;
  final String? error;

  const ChildSessionState({
    this.childId,
    this.childProfile,
    this.isLoading = false,
    this.error,
  });

  ChildSessionState copyWith({
    String? childId,
    ChildProfile? childProfile,
    bool? isLoading,
    String? error,
  }) {
    return ChildSessionState(
      childId: childId ?? this.childId,
      childProfile: childProfile ?? this.childProfile,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool get hasActiveSession => childId != null;
}

class ChildSessionController extends StateNotifier<ChildSessionState> {
  final ChildRepository _childRepository;
  final Logger _logger;

  ChildSessionController({
    required ChildRepository childRepository,
    required Logger logger,
  })  : _childRepository = childRepository,
        _logger = logger,
        super(const ChildSessionState());

  Future<bool> startChildSession({
    required String childId,
    ChildProfile? childProfile,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final profile =
          childProfile ?? await _childRepository.getChildProfile(childId);

      if (profile == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'Child profile not found',
        );
        return false;
      }

      state = ChildSessionState(
        childId: childId,
        childProfile: profile,
        isLoading: false,
      );

      _logger.d('Child session started: ${profile.name}');
      return true;
    } catch (e) {
      _logger.e('Error starting child session: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to start child session',
      );
      return false;
    }
  }

  Future<bool> loadChild(String childId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final profile = await _childRepository.getChildProfile(childId);

      if (profile != null) {
        state = ChildSessionState(
          childId: childId,
          childProfile: profile,
          isLoading: false,
        );
        _logger.d('Child loaded: ${profile.name}');
        return true;
      }

      state = state.copyWith(
        isLoading: false,
        error: 'Child profile not found',
      );
      return false;
    } catch (e) {
      _logger.e('Error loading child: $childId, $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load child profile',
      );
      return false;
    }
  }

  Future<bool> endChildSession() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      state = const ChildSessionState(
        childId: null,
        childProfile: null,
        isLoading: false,
      );

      _logger.d('Child session ended');
      return true;
    } catch (e) {
      _logger.e('Error ending child session: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to end child session',
      );
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final childRepositoryProvider = Provider<ChildRepository>((ref) {
  final childBox = Hive.box('child_profiles');
  final logger = ref.watch(loggerProvider);
  final apiClient = ref.watch(apiClientProvider);

  return ChildRepository(
    childBox: childBox,
    logger: logger,
    apiClient: apiClient,
  );
});

final childSessionControllerProvider =
    StateNotifierProvider<ChildSessionController, ChildSessionState>((ref) {
  final childRepository = ref.watch(childRepositoryProvider);
  final logger = ref.watch(loggerProvider);

  return ChildSessionController(
    childRepository: childRepository,
    logger: logger,
  );
});

final hasChildSessionProvider = Provider<bool>((ref) {
  return ref.watch(childSessionControllerProvider).hasActiveSession;
});

final currentChildProvider = Provider<ChildProfile?>((ref) {
  return ref.watch(childSessionControllerProvider).childProfile;
});

final currentChildIdProvider = Provider<String?>((ref) {
  return ref.watch(childSessionControllerProvider).childId;
});

final childLoadingProvider = Provider<bool>((ref) {
  return ref.watch(childSessionControllerProvider).isLoading;
});

final childErrorProvider = Provider<String?>((ref) {
  return ref.watch(childSessionControllerProvider).error;
});
