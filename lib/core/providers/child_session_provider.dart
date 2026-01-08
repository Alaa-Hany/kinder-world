import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/models/child_profile.dart';
import 'package:kinder_world/core/storage/secure_storage.dart';
import 'package:logger/logger.dart';

// Child Session State
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
  bool get hasProfile => childProfile != null;
}

// Child Session Provider
class ChildSessionNotifier extends StateNotifier<ChildSessionState> {
  final SecureStorage _secureStorage;
  final Logger _logger;

  ChildSessionNotifier({
    required SecureStorage secureStorage,
    required Logger logger,
  })  : _secureStorage = secureStorage,
        _logger = logger,
        super(const ChildSessionState()) {
    _loadChildSession();
  }

  Future<void> _loadChildSession() async {
    try {
      final childId = await _secureStorage.getChildSession();
      
      if (childId != null) {
        state = state.copyWith(childId: childId);
        await loadChildProfile(childId);
      }
    } catch (e) {
      _logger.e('Error loading child session: $e');
      state = state.copyWith(error: 'Failed to load child session');
    }
  }

  Future<void> loadChildProfile(String childId) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // In a real app, this would fetch from API or local database
      // For now, we'll use mock data
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mock child profiles - in real app, fetch from repository
      final mockProfiles = {
        'child1': const ChildProfile(
          id: 'child1',
          name: 'Ahmed',
          age: 8,
          avatar: 'assets/images/avatars/boy1.png',
          interests: ['math', 'science'],
          level: 3,
          xp: 2500,
          streak: 5,
          favorites: ['activity1', 'activity2'],
          parentId: 'parent1',
          picturePassword: ['apple', 'ball', 'cat'],
          createdAt: null,
          updatedAt: null,
          totalTimeSpent: 0,
          activitiesCompleted: 0,
          currentMood: 'happy',
        ),
        'child2': const ChildProfile(
          id: 'child2',
          name: 'Sara',
          age: 6,
          avatar: 'assets/images/avatars/girl1.png',
          interests: ['reading', 'art'],
          level: 2,
          xp: 1800,
          streak: 3,
          favorites: ['activity3', 'activity4'],
          parentId: 'parent1',
          picturePassword: ['dog', 'elephant', 'fish'],
          createdAt: null,
          updatedAt: null,
          totalTimeSpent: 0,
          activitiesCompleted: 0,
          currentMood: 'excited',
        ),
      };
      
      final profile = mockProfiles[childId];
      
      if (profile != null) {
        state = state.copyWith(
          childId: childId,
          childProfile: profile,
          isLoading: false,
        );
        
        _logger.d('Child profile loaded: ${profile.name}');
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Child profile not found',
        );
      }
    } catch (e) {
      _logger.e('Error loading child profile: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load child profile',
      );
    }
  }

  Future<void> startChildSession({
    required String childId,
    required ChildProfile childProfile,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _secureStorage.saveChildSession(childId);
      
      state = ChildSessionState(
        childId: childId,
        childProfile: childProfile,
        isLoading: false,
      );
      
      _logger.d('Child session started: ${childProfile.name}');
    } catch (e) {
      _logger.e('Error starting child session: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to start child session',
      );
    }
  }

  Future<void> endChildSession() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _secureStorage.clearChildSession();
      
      state = const ChildSessionState(
        childId: null,
        childProfile: null,
        isLoading: false,
      );
      
      _logger.d('Child session ended');
    } catch (e) {
      _logger.e('Error ending child session: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to end child session',
      );
    }
  }

  Future<void> updateChildProfile(ChildProfile updatedProfile) async {
    state = state.copyWith(childProfile: updatedProfile);
    _logger.d('Child profile updated: ${updatedProfile.name}');
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider
final childSessionProvider = StateNotifierProvider<ChildSessionNotifier, ChildSessionState>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final logger = ref.watch(loggerProvider);
  
  return ChildSessionNotifier(
    secureStorage: secureStorage,
    logger: logger,
  );
});

// Helper providers
final hasChildSessionProvider = Provider<bool>((ref) {
  return ref.watch(childSessionProvider).hasActiveSession;
});

final currentChildProvider = Provider<ChildProfile?>((ref) {
  return ref.watch(childSessionProvider).childProfile;
});