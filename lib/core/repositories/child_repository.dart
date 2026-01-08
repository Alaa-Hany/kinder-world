import 'dart:async';
import 'package:hive/hive.dart';
import 'package:kinder_world/core/models/child_profile.dart';
import 'package:logger/logger.dart';

/// Repository for child profile operations
/// Uses Hive for local persistence (offline-first)
class ChildRepository {
  final Box<ChildProfile> _childBox;
  final Logger _logger;

  ChildRepository({
    required Box<ChildProfile> childBox,
    required Logger logger,
  })  : _childBox = childBox,
        _logger = logger;

  // ==================== CRUD OPERATIONS ====================

  /// Create new child profile
  Future<ChildProfile?> createChildProfile({
    required String name,
    required int age,
    required String avatar,
    required List<String> interests,
    required List<String> picturePassword,
    required String parentId,
    String? learningStyle,
    List<String>? specialNeeds,
    List<String>? accessibilityNeeds,
  }) async {
    try {
      _logger.d('Creating child profile: $name');
      
      // Generate unique ID
      final childId = 'child_${DateTime.now().millisecondsSinceEpoch}';
      
      // Create child profile
      final child = ChildProfile(
        id: childId,
        name: name,
        age: age,
        avatar: avatar,
        interests: interests,
        level: 1,
        xp: 0,
        streak: 0,
        favorites: [],
        parentId: parentId,
        picturePassword: picturePassword,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        totalTimeSpent: 0,
        activitiesCompleted: 0,
        currentMood: MoodTypes.happy,
        learningStyle: learningStyle,
        specialNeeds: specialNeeds,
        accessibilityNeeds: accessibilityNeeds,
      );
      
      // Save to Hive
      await _childBox.put(childId, child);
      
      _logger.d('Child profile created: $childId');
      return child;
    } catch (e, stack) {
      _logger.e('Error creating child profile', e, stack);
      return null;
    }
  }

  /// Get child profile by ID
  Future<ChildProfile?> getChildProfile(String childId) async {
    try {
      return _childBox.get(childId);
    } catch (e, stack) {
      _logger.e('Error getting child profile: $childId', e, stack);
      return null;
    }
  }

  /// Get all child profiles for a parent
  Future<List<ChildProfile>> getChildProfilesForParent(String parentId) async {
    try {
      return _childBox.values
          .where((child) => child.parentId == parentId)
          .toList();
    } catch (e, stack) {
      _logger.e('Error getting child profiles for parent: $parentId', e, stack);
      return [];
    }
  }

  /// Update child profile
  Future<ChildProfile?> updateChildProfile(ChildProfile updatedProfile) async {
    try {
      _logger.d('Updating child profile: ${updatedProfile.id}');
      
      // Update timestamp
      final updated = updatedProfile.copyWith(
        updatedAt: DateTime.now(),
      );
      
      // Save to Hive
      await _childBox.put(updated.id, updated);
      
      _logger.d('Child profile updated: ${updated.id}');
      return updated;
    } catch (e, stack) {
      _logger.e('Error updating child profile: ${updatedProfile.id}', e, stack);
      return null;
    }
  }

  /// Delete child profile
  Future<bool> deleteChildProfile(String childId) async {
    try {
      _logger.d('Deleting child profile: $childId');
      await _childBox.delete(childId);
      _logger.d('Child profile deleted: $childId');
      return true;
    } catch (e, stack) {
      _logger.e('Error deleting child profile: $childId', e, stack);
      return false;
    }
  }

  // ==================== PROGRESS OPERATIONS ====================

  /// Add XP to child
  Future<ChildProfile?> addXP(String childId, int xpAmount) async {
    try {
      final child = _childBox.get(childId);
      if (child == null) return null;
      
      final newXP = child.xp + xpAmount;
      final newLevel = (newXP / 1000).floor() + 1;
      final levelUp = newLevel > child.level;
      
      final updated = child.copyWith(
        xp: newXP,
        level: newLevel,
        updatedAt: DateTime.now(),
      );
      
      await _childBox.put(childId, updated);
      
      if (levelUp) {
        _logger.d('Child $childId leveled up to level $newLevel');
      }
      
      return updated;
    } catch (e, stack) {
      _logger.e('Error adding XP to child: $childId', e, stack);
      return null;
    }
  }

  /// Update streak
  Future<ChildProfile?> updateStreak(String childId) async {
    try {
      final child = _childBox.get(childId);
      if (child == null) return null;
      
      final now = DateTime.now();
      int newStreak = child.streak;
      
      if (child.lastSession != null) {
        final lastSession = child.lastSession!;
        final daysDifference = now.difference(lastSession).inDays;
        
        if (daysDifference == 0) {
          // Same day, keep current streak
        } else if (daysDifference == 1) {
          // Consecutive day, increment streak
          newStreak++;
        } else {
          // Streak broken, reset to 1
          newStreak = 1;
        }
      } else {
        // First activity, start streak
        newStreak = 1;
      }
      
      final updated = child.copyWith(
        streak: newStreak,
        lastSession: now,
        updatedAt: now,
      );
      
      await _childBox.put(childId, updated);
      _logger.d('Updated streak for $childId: $newStreak');
      return updated;
    } catch (e, stack) {
      _logger.e('Error updating streak for child: $childId', e, stack);
      return null;
    }
  }

  /// Complete activity
  Future<ChildProfile?> completeActivity({
    required String childId,
    required int xpEarned,
    required int timeSpent,
  }) async {
    try {
      final child = _childBox.get(childId);
      if (child == null) return null;
      
      // Add XP
      final withXP = await addXP(childId, xpEarned);
      if (withXP == null) return null;
      
      // Update activity count and time
      final updated = withXP.copyWith(
        activitiesCompleted: withXP.activitiesCompleted + 1,
        totalTimeSpent: withXP.totalTimeSpent + timeSpent,
        updatedAt: DateTime.now(),
      );
      
      await _childBox.put(childId, updated);
      _logger.d('Activity completed for $childId: +$xpEarned XP, +$timeSpent min');
      return updated;
    } catch (e, stack) {
      _logger.e('Error completing activity for child: $childId', e, stack);
      return null;
    }
  }

  // ==================== FAVORITES & INTERESTS ====================

  /// Add activity to favorites
  Future<ChildProfile?> addToFavorites(String childId, String activityId) async {
    try {
      final child = _childBox.get(childId);
      if (child == null) return null;
      
      if (!child.favorites.contains(activityId)) {
        final updated = child.copyWith(
          favorites: [...child.favorites, activityId],
          updatedAt: DateTime.now(),
        );
        
        await _childBox.put(childId, updated);
        _logger.d('Added $activityId to favorites for $childId');
        return updated;
      }
      
      return child;
    } catch (e, stack) {
      _logger.e('Error adding to favorites for child: $childId', e, stack);
      return null;
    }
  }

  /// Remove activity from favorites
  Future<ChildProfile?> removeFromFavorites(String childId, String activityId) async {
    try {
      final child = _childBox.get(childId);
      if (child == null) return null;
      
      final updated = child.copyWith(
        favorites: child.favorites.where((id) => id != activityId).toList(),
        updatedAt: DateTime.now(),
      );
      
      await _childBox.put(childId, updated);
      _logger.d('Removed $activityId from favorites for $childId');
      return updated;
    } catch (e, stack) {
      _logger.e('Error removing from favorites for child: $childId', e, stack);
      return null;
    }
  }

  /// Update child interests
  Future<ChildProfile?> updateInterests(String childId, List<String> newInterests) async {
    try {
      final child = _childBox.get(childId);
      if (child == null) return null;
      
      final updated = child.copyWith(
        interests: newInterests,
        updatedAt: DateTime.now(),
      );
      
      await _childBox.put(childId, updated);
      _logger.d('Updated interests for $childId: $newInterests');
      return updated;
    } catch (e, stack) {
      _logger.e('Error updating interests for child: $childId', e, stack);
      return null;
    }
  }

  // ==================== MOOD & LEARNING STYLE ====================

  /// Update child mood
  Future<ChildProfile?> updateMood(String childId, String mood) async {
    try {
      final child = _childBox.get(childId);
      if (child == null) return null;
      
      final updated = child.copyWith(
        currentMood: mood,
        updatedAt: DateTime.now(),
      );
      
      await _childBox.put(childId, updated);
      _logger.d('Updated mood for $childId: $mood');
      return updated;
    } catch (e, stack) {
      _logger.e('Error updating mood for child: $childId', e, stack);
      return null;
    }
  }

  /// Update learning style
  Future<ChildProfile?> updateLearningStyle(String childId, String learningStyle) async {
    try {
      final child = _childBox.get(childId);
      if (child == null) return null;
      
      final updated = child.copyWith(
        learningStyle: learningStyle,
        updatedAt: DateTime.now(),
      );
      
      await _childBox.put(childId, updated);
      _logger.d('Updated learning style for $childId: $learningStyle');
      return updated;
    } catch (e, stack) {
      _logger.e('Error updating learning style for child: $childId', e, stack);
      return null;
    }
  }

  // ==================== QUERY OPERATIONS ====================

  /// Get all child profiles
  Future<List<ChildProfile>> getAllChildProfiles() async {
    try {
      return _childBox.values.toList();
    } catch (e, stack) {
      _logger.e('Error getting all child profiles', e, stack);
      return [];
    }
  }

  /// Get children by age range
  Future<List<ChildProfile>> getChildrenByAgeRange(int minAge, int maxAge) async {
    try {
      return _childBox.values
          .where((child) => child.age >= minAge && child.age <= maxAge)
          .toList();
    } catch (e, stack) {
      _logger.e('Error getting children by age range', e, stack);
      return [];
    }
  }

  /// Get children by interests
  Future<List<ChildProfile>> getChildrenByInterests(List<String> interests) async {
    try {
      return _childBox.values
          .where((child) => 
              child.interests.any((interest) => interests.contains(interest)))
          .toList();
    } catch (e, stack) {
      _logger.e('Error getting children by interests', e, stack);
      return [];
    }
  }

  // ==================== STATISTICS ====================

  /// Get child statistics
  Future<Map<String, dynamic>> getChildStats(String childId) async {
    try {
      final child = _childBox.get(childId);
      if (child == null) {
        return {};
      }
      
      return {
        'totalActivities': child.activitiesCompleted,
        'totalHours': child.totalHoursSpent,
        'currentLevel': child.level,
        'totalXP': child.xp,
        'currentStreak': child.streak,
        'favoriteInterests': child.interests,
        'completedActivities': child.favorites.length,
        'averageSessionTime': child.activitiesCompleted > 0 
            ? child.totalTimeSpent / child.activitiesCompleted 
            : 0,
      };
    } catch (e, stack) {
      _logger.e('Error getting child stats: $childId', e, stack);
      return {};
    }
  }

  // ==================== SYNC OPERATIONS ====================

  /// Mark child profile for sync
  Future<bool> markForSync(String childId) async {
    try {
      // In a real app, this would mark the record for server sync
      _logger.d('Marked child profile for sync: $childId');
      return true;
    } catch (e) {
      _logger.e('Error marking child for sync: $childId', e);
      return false;
    }
  }

  /// Sync child profile with server (placeholder)
  Future<bool> syncWithServer(String childId) async {
    try {
      _logger.d('Syncing child profile with server: $childId');
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      _logger.e('Error syncing child profile: $childId', e);
      return false;
    }
  }
}