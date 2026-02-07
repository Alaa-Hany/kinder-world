import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kinder_world/core/models/activity.dart';
import 'package:kinder_world/core/models/child_profile.dart';
import 'package:kinder_world/core/repositories/content_repository.dart';
import 'package:kinder_world/app.dart';
import 'package:logger/logger.dart';

/// State for content/controller
class ContentState {
  final List<Activity> activities;
  final List<Activity> recommendedActivities;
  final List<Activity> popularActivities;
  final bool isLoading;
  final String? error;

  const ContentState({
    this.activities = const [],
    this.recommendedActivities = const [],
    this.popularActivities = const [],
    this.isLoading = false,
    this.error,
  });

  ContentState copyWith({
    List<Activity>? activities,
    List<Activity>? recommendedActivities,
    List<Activity>? popularActivities,
    bool? isLoading,
    String? error,
  }) {
    return ContentState(
      activities: activities ?? this.activities,
      recommendedActivities:
          recommendedActivities ?? this.recommendedActivities,
      popularActivities: popularActivities ?? this.popularActivities,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ContentController extends StateNotifier<ContentState> {
  final ContentRepository _contentRepository;
  final Logger _logger;

  ContentController({
    required ContentRepository contentRepository,
    required Logger logger,
  })  : _contentRepository = contentRepository,
        _logger = logger,
        super(const ContentState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    await loadAllActivities();
    await loadPopularActivities();
  }

  Future<void> loadAllActivities() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final activities = await _contentRepository.getAllActivities();
      state = state.copyWith(
        activities: activities,
        isLoading: false,
      );
      _logger.d('Loaded ${activities.length} activities');
    } catch (e) {
      _logger.e('Error loading activities: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load activities',
      );
    }
  }

  Future<void> loadPopularActivities() async {
    try {
      final activities =
          await _contentRepository.getPopularActivities(limit: 10);
      state = state.copyWith(popularActivities: activities);
      _logger.d('Loaded ${activities.length} popular activities');
    } catch (e) {
      _logger.e('Error loading popular activities: $e');
    }
  }

  Future<List<Activity>> loadActivitiesByCategory(String category) async {
    try {
      final activities =
          await _contentRepository.getActivitiesByCategory(category);
      _logger
          .d('Loaded ${activities.length} activities for category: $category');
      return activities;
    } catch (e) {
      _logger.e('Error filtering by category: $category, $e');
      return [];
    }
  }

  Future<List<Activity>> loadActivitiesByType(String type) async {
    try {
      final activities = await _contentRepository.getActivitiesByType(type);
      _logger.d('Loaded ${activities.length} activities for type: $type');
      return activities;
    } catch (e) {
      _logger.e('Error filtering by type: $type, $e');
      return [];
    }
  }

  Future<List<Activity>> loadActivitiesByAspect(String aspect) async {
    try {
      final activities = await _contentRepository.getActivitiesByAspect(aspect);
      _logger.d('Loaded ${activities.length} activities for aspect: $aspect');
      return activities;
    } catch (e) {
      _logger.e('Error filtering by aspect: $aspect, $e');
      return [];
    }
  }

  Future<List<Activity>> loadActivitiesByDifficulty(String difficulty) async {
    try {
      final activities =
          await _contentRepository.getActivitiesByDifficulty(difficulty);
      _logger.d(
          'Filtered ${activities.length} activities by difficulty: $difficulty');
      return activities;
    } catch (e) {
      _logger.e('Error filtering by difficulty: $difficulty, $e');
      return [];
    }
  }

  Future<List<Activity>> loadRecommendedActivities(ChildProfile child) async {
    try {
      final activities =
          await _contentRepository.getRecommendedActivities(child);
      state = state.copyWith(recommendedActivities: activities);
      _logger
          .d('Loaded ${activities.length} recommendations for ${child.name}');
      return activities;
    } catch (e) {
      _logger.e('Error loading recommended activities: $e');
      return [];
    }
  }

  Future<List<Activity>> loadActivitiesForChild(ChildProfile child) async {
    try {
      final activities = await _contentRepository.getActivitiesForChild(child);
      _logger.d('Loaded ${activities.length} activities for ${child.name}');
      return activities;
    } catch (e) {
      _logger.e('Error loading activities for ${child.name}: $e');
      return [];
    }
  }

  Future<List<Activity>> searchActivities(String query) async {
    try {
      final activities = await _contentRepository.searchActivities(query);
      _logger.d('Search "$query" found ${activities.length} activities');
      return activities;
    } catch (e) {
      _logger.e('Error searching activities: $query, $e');
      return [];
    }
  }

  Future<List<Activity>> getOfflineActivities() async {
    try {
      final activities = await _contentRepository.getOfflineActivities();
      _logger.d('Loaded ${activities.length} offline activities');
      return activities;
    } catch (e) {
      _logger.e('Error loading offline activities: $e');
      return [];
    }
  }

  Future<Activity?> getActivity(String id) async {
    try {
      final activity = await _contentRepository.getActivity(id);
      if (activity == null) {
        _logger.w('Activity not found: $id');
      }
      return activity;
    } catch (e) {
      _logger.e('Error getting activity: $id, $e');
      return null;
    }
  }

  Future<bool> incrementPlayCount(String activityId) async {
    try {
      final success = await _contentRepository.incrementPlayCount(activityId);
      if (success) {
        state = state.copyWith(
          activities: state.activities.map((activity) {
            if (activity.id == activityId) {
              return activity.copyWith(playCount: activity.playCount + 1);
            }
            return activity;
          }).toList(),
        );
      }
      return success;
    } catch (e) {
      _logger.e('Error incrementing play count: $activityId, $e');
      return false;
    }
  }

  Future<List<Activity>> getDailyRecommendations(ChildProfile child) async {
    try {
      final recommended = await loadActivitiesForChild(child);
      final filtered = recommended.where((activity) {
        final interestMatch =
            activity.tags.any((tag) => child.interests.contains(tag));
        final levelDiff = (activity.difficultyLevel - child.level).abs();
        return interestMatch && levelDiff <= 2;
      }).toList();

      filtered.sort((a, b) {
        final aMatches =
            a.tags.where((tag) => child.interests.contains(tag)).length;
        final bMatches =
            b.tags.where((tag) => child.interests.contains(tag)).length;
        if (aMatches != bMatches) {
          return bMatches.compareTo(aMatches);
        }
        final aRating = a.averageRating ?? 0.0;
        final bRating = b.averageRating ?? 0.0;
        return bRating.compareTo(aRating);
      });

      return filtered.take(5).toList();
    } catch (e) {
      _logger.e('Error getting daily recommendations: $e');
      return [];
    }
  }

  Future<List<Activity>> getContinueLearningActivities(
      ChildProfile child) async {
    try {
      return state.popularActivities.take(3).toList();
    } catch (e) {
      _logger.e('Error getting continue learning activities: $e');
      return [];
    }
  }

  List<String> getAllCategories() => ActivityCategories.all;
  List<String> getAllTypes() => ActivityTypes.all;
  List<String> getAllAspects() => ActivityAspects.all;
  String getCategoryDisplayName(String category) =>
      ActivityCategories.getDisplayName(category);
  String getTypeDisplayName(String type) => ActivityTypes.getDisplayName(type);
  String getAspectDisplayName(String aspect) =>
      ActivityAspects.getDisplayName(aspect);

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final contentControllerProvider =
    StateNotifierProvider<ContentController, ContentState>((ref) {
  final contentRepository = ref.watch(contentRepositoryProvider);
  final logger = ref.watch(loggerProvider);
  return ContentController(
    contentRepository: contentRepository,
    logger: logger,
  );
});

final allActivitiesProvider = Provider<List<Activity>>((ref) {
  return ref.watch(contentControllerProvider).activities;
});

final recommendedActivitiesProvider = Provider<List<Activity>>((ref) {
  return ref.watch(contentControllerProvider).recommendedActivities;
});

final popularActivitiesProvider = Provider<List<Activity>>((ref) {
  return ref.watch(contentControllerProvider).popularActivities;
});

final activitiesByCategoryProvider =
    FutureProvider.family<List<Activity>, String>((ref, category) async {
  final controller = ref.watch(contentControllerProvider.notifier);
  return await controller.loadActivitiesByCategory(category);
});

final dailyRecommendationsProvider =
    FutureProvider.family<List<Activity>, ChildProfile>((ref, child) async {
  final controller = ref.watch(contentControllerProvider.notifier);
  return await controller.getDailyRecommendations(child);
});

final offlineActivitiesProvider = FutureProvider<List<Activity>>((ref) async {
  final controller = ref.watch(contentControllerProvider.notifier);
  return await controller.getOfflineActivities();
});

final contentRepositoryProvider = Provider<ContentRepository>((ref) {
  final activityBox = Hive.box('activities');
  final logger = ref.watch(loggerProvider);
  return ContentRepository(
    activityBox: activityBox,
    logger: logger,
  );
});
