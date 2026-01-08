import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kinder_world/core/models/child_profile.dart';
import 'package:kinder_world/core/repositories/child_repository.dart';
import 'package:kinder_world/app.dart';
import 'package:logger/logger.dart';

/// Child session state
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

/// Child session controller manages the active child session and profile
class ChildSessionController extends StateNotifier<ChildSessionState> {
  final ChildRepository _childRepository;
  final Logger _logger;

  ChildSessionController({
    required ChildRepository childRepository,
    required Logger logger,
  })  : _childRepository = childRepository,
        _logger = logger,
        super(const ChildSessionState()) {
    _initialize();
  }

  /// Initialize child session from storage
  Future<void> _initialize() async {
    _logger.d('Initializing child session controller');
    
    // In a real app, this would load from secure storage
    // For now, we'll use mock initialization
    await loadMockChildProfile();
  }

  /// Load mock child profile for development
  Future<void> loadMockChildProfile() async {
    try {
      state = state.copyWith(isLoading: true);
      
      // Create mock child profile
      final mockChild = ChildProfile(
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
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
        totalTimeSpent: 0,
        activitiesCompleted: 0,
        currentMood: 'happy',
      );
      
      state = ChildSessionState(
        childId: mockChild.id,
        childProfile: mockChild,
        isLoading: false,
      );
      
      _logger.d('Mock child profile loaded: ${mockChild.name}');
    } catch (e, stack) {
      _logger.e('Error loading mock child profile: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load child profile',
      );
    }
  }

  // ==================== SESSION MANAGEMENT ====================

  /// Start child session
  Future<bool> startChildSession({
    required String childId,
    required ChildProfile childProfile,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      state = ChildSessionState(
        childId: childId,
        childProfile: childProfile,
        isLoading: false,
      );
      
      _logger.d('Child session started: ${childProfile.name}');
      return true;
    } catch (e, stack) {
      _logger.e('Error starting child session: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to start child session',
      );
      return false;
    }
  }

  /// End child session
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
    } catch (e, stack) {
      _logger.e('Error ending child session: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to end child session',
      );
      return false;
    }
  }

  // ==================== PROFILE MANAGEMENT ====================

  /// Load child profile
  Future<bool> loadChildProfile(String childId) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final child = await _childRepository.getChildProfile(childId);
      
      if (child != null) {
        state = ChildSessionState(
          childId: childId,
          childProfile: child,
          isLoading: false,
        );
        
        _logger.d('Child profile loaded: ${child.name}');
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Child profile not found',
        );
        return false;
      }
    } catch (e, stack) {
      _logger.e('Error loading child profile: $childId, $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load child profile',
      );
      return false;
    }
  }

  /// Update child profile
  Future<bool> updateChildProfile(ChildProfile updatedProfile) async {
    try {
      final updated = await _childRepository.updateChildProfile(updatedProfile);
      
      if (updated != null) {
        state = state.copyWith(childProfile: updated);
        _logger.d('Child profile updated: ${updated.name}');
        return true;
      }
      
      return false;
    } catch (e, stack) {
      _logger.e('Error updating child profile: $e');
      return false;
    }
  }

  // ==================== PROGRESS OPERATIONS ====================

  /// Add XP to current child
  Future<bool> addXP(int xpAmount) async {
    if (!state.hasActiveSession || state.childProfile == null) {
      _logger.w('Cannot add XP: No active child session');
      return false;
    }
    
    try {
      final updated = await _childRepository.addXP(state.childId!, xpAmount);
      
      if (updated != null) {
        state = state.copyWith(childProfile: updated);
        _logger.d('XP added: $xpAmount, new total: ${updated.xp}');
        return true;
      }
      
      return false;
    } catch (e, stack) {
      _logger.e('Error adding XP: $e');
      return false;
    }
  }

  /// Update streak for current child
  Future<bool> updateStreak() async {
    if (!state.hasActiveSession || state.childProfile == null) {
      _logger.w('Cannot update streak: No active child session');
      return false;
    }
    
    try {
      final updated = await _childRepository.updateStreak(state.childId!);
      
      if (updated != null) {
        state = state.copyWith(childProfile: updated);
        _logger.d('Streak updated: ${updated.streak} days');
        return true;
      }
      
      return false;
    } catch (e, stack) {
      _logger.e('Error updating streak: $e');
      return false;
    }
  }

  /// Complete activity for current child
  Future<bool> completeActivity({
    required int xpEarned,
    required int timeSpent,
  }) async {
    if (!state.hasActiveSession || state.childProfile == null) {
      _logger.w('Cannot complete activity: No active child session');
      return false;
    }
    
    try {
      final updated = await _childRepository.completeActivity(
        childId: state.childId!,
        xpEarned: xpEarned,
        timeSpent: timeSpent,
      );
      
      if (updated != null) {
        state = state.copyWith(childProfile: updated);
        _logger.d('Activity completed: +$xpEarned XP, +$timeSpent min');
        return true;
      }
      
      return false;
    } catch (e, stack) {
      _logger.e('Error completing activity: $e');
      return false;
    }
  }

  // ==================== FAVORITES & INTERESTS ====================

  /// Add activity to favorites
  Future<bool> addToFavorites(String activityId) async {
    if (!state.hasActiveSession || state.childProfile == null) {
      _logger.w('Cannot add to favorites: No active child session');
      return false;
    }
    
    try {
      final updated = await _childRepository.addToFavorites(state.childId!, activityId);
      
      if (updated != null) {
        state = state.copyWith(childProfile: updated);
        _logger.d('Added to favorites: $activityId');
        return true;
      }
      
      return false;
    } catch (e, stack) {
      _logger.e('Error adding to favorites: $e');
      return false;
    }
  }

  /// Remove activity from favorites
  Future<bool> removeFromFavorites(String activityId) async {
    if (!state.hasActiveSession || state.childProfile == null) {
      _logger.w('Cannot remove from favorites: No active child session');
      return false;
    }
    
    try {
      final updated = await _childRepository.removeFromFavorites(state.childId!, activityId);
      
      if (updated != null) {
        state = state.copyWith(childProfile: updated);
        _logger.d('Removed from favorites: $activityId');
        return true;
      }
      
      return false;
    } catch (e, stack) {
      _logger.e('Error removing from favorites: $e');
      return false;
    }
  }

  /// Update child interests
  Future<bool> updateInterests(List<String> newInterests) async {
    if (!state.hasActiveSession || state.childProfile == null) {
      _logger.w('Cannot update interests: No active child session');
      return false;
    }
    
    try {
      final updated = await _childRepository.updateInterests(state.childId!, newInterests);
      
      if (updated != null) {
        state = state.copyWith(childProfile: updated);
        _logger.d('Interests updated: $newInterests');
        return true;
      }
      
      return false;
    } catch (e, stack) {
      _logger.e('Error updating interests: $e');
      return false;
    }
  }

  // ==================== MOOD & LEARNING STYLE ====================

  /// Update child mood
  Future<bool> updateMood(String mood) async {
    if (!state.hasActiveSession || state.childProfile == null) {
      _logger.w('Cannot update mood: No active child session');
      return false;
    }
    
    try {
      final updated = await _childRepository.updateMood(state.childId!, mood);
      
      if (updated != null) {
        state = state.copyWith(childProfile: updated);
        _logger.d('Mood updated: $mood');
        return true;
      }
      
      return false;
    } catch (e, stack) {
      _logger.e('Error updating mood: $e');
      return false;
    }
  }

  /// Update learning style
  Future<bool> updateLearningStyle(String learningStyle) async {
    if (!state.hasActiveSession || state.childProfile == null) {
      _logger.w('Cannot update learning style: No active child session');
      return false;
    }
    
    try {
      final updated = await _childRepository.updateLearningStyle(state.childId!, learningStyle);
      
      if (updated != null) {
        state = state.copyWith(childProfile: updated);
        _logger.d('Learning style updated: $learningStyle');
        return true;
      }
      
      return false;
    } catch (e, stack) {
      _logger.e('Error updating learning style: $e');
      return false;
    }
  }

  // ==================== STATISTICS ====================

  /// Get child statistics
  Future<Map<String, dynamic>> getChildStats() async {
    if (!state.hasActiveSession) {
      return {};
    }
    
    try {
      return await _childRepository.getChildStats(state.childId!);
    } catch (e, stack) {
      _logger.e('Error getting child stats: $e');
      return {};
    }
  }

  // ==================== ERROR HANDLING ====================

  /// Clear error state
  void clearError() {
    state = state.copyWith(error: null);
  }

  // ==================== MOCK DATA HELPERS ====================

  /// Get mock child profile for development
  ChildProfile getMockChildProfile() {
    return ChildProfile(
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
      createdAt: DateTime(2024, 1, 1),
      updatedAt: DateTime(2024, 1, 1),
      totalTimeSpent: 0,
      activitiesCompleted: 0,
      currentMood: 'happy',
    );
  }
}

// Provider
final childSessionControllerProvider = StateNotifierProvider<ChildSessionController, ChildSessionState>((ref) {
  final childRepository = ref.watch(childRepositoryProvider);
  final logger = ref.watch(loggerProvider);
  
  return ChildSessionController(
    childRepository: childRepository,
    logger: logger,
  );
});

// Repository provider
final childRepositoryProvider = Provider<ChildRepository>((ref) {
  final childBox = Hive.box('child_profiles');
  final logger = ref.watch(loggerProvider);
  
  return ChildRepository(
    childBox: childBox,
    logger: logger,
  );
});

// Helper providers
final hasChildSessionProvider = Provider<bool>((ref) {
  return ref.watch(childSessionControllerProvider).hasActiveSession;
});

final currentChildProvider = Provider<ChildProfile?>((ref) {
  return ref.watch(childSessionControllerProvider).childProfile;
});

final childStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final controller = ref.watch(childSessionControllerProvider.notifier);
  return await controller.getChildStats();
});