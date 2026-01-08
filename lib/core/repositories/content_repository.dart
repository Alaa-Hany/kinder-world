import 'dart:async';
import 'package:hive/hive.dart';
import 'package:kinder_world/core/models/activity.dart';
import 'package:kinder_world/core/models/child_profile.dart';
import 'package:logger/logger.dart';

/// Repository for content management
/// Provides offline-first access to activities with local seed data
/// Stores data as JSON maps since Freezed models don't support Hive TypeAdapters
class ContentRepository {
  final Box _activityBox;
  final Logger _logger;

  ContentRepository({
    required Box activityBox,
    required Logger logger,
  })  : _activityBox = activityBox,
        _logger = logger {
    _initializeSeedData();
  }

  // Helper methods for JSON serialization
  Activity? _getActivityFromBox(String activityId) {
    final data = _activityBox.get(activityId);
    if (data == null) return null;
    try {
      final map = data as Map<String, dynamic>;
      return Activity.fromJson(map);
    } catch (e) {
      _logger.e('Error deserializing activity: $activityId, $e');
      return null;
    }
  }

  Future<void> _saveActivityToBox(String activityId, Activity activity) async {
    await _activityBox.put(activityId, activity.toJson());
  }

  List<Activity> _getAllActivitiesFromBox() {
    return _activityBox.values
        .map((data) {
          try {
            final map = data as Map<String, dynamic>;
            return Activity.fromJson(map);
          } catch (e) {
            _logger.e('Error deserializing activity from box: $e');
            return null;
          }
        })
        .whereType<Activity>()
        .toList();
  }

  // ==================== SEED DATA ====================

  /// Initialize with seed data if empty
  Future<void> _initializeSeedData() async {
    try {
      if (_activityBox.isEmpty) {
        _logger.d('Initializing seed data');
        
        final seedActivities = _getSeedActivities();
        
        for (final activity in seedActivities) {
          await _saveActivityToBox(activity.id, activity);
        }
        
        _logger.d('Initialized ${seedActivities.length} seed activities');
      }
    } catch (e, stack) {
      _logger.e('Error initializing seed data: $e');
    }
  }

  /// Get seed activities data
  List<Activity> _getSeedActivities() {
    return [
      // Mathematics Activities
      Activity(
        id: 'math_counting_01',
        title: 'Counting Numbers 1-10',
        description: 'Learn to count from 1 to 10 with colorful objects',
        category: ActivityCategories.mathematics,
        type: ActivityTypes.lesson,
        aspect: ActivityAspects.educational,
        ageRange: ['5-7'],
        difficulty: DifficultyLevels.beginner,
        duration: 15,
        xpReward: 50,
        thumbnailUrl: 'assets/images/math/counting.png',
        tags: ['counting', 'numbers', 'basic'],
        learningObjectives: ['Count to 10', 'Recognize numbers', 'One-to-one correspondence'],
        isOfflineAvailable: true,
        isPremium: false,
        parentApprovalRequired: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        playCount: 0,
      ),
      
      Activity(
        id: 'math_addition_01',
        title: 'Simple Addition',
        description: 'Add small numbers with visual aids',
        category: ActivityCategories.mathematics,
        type: ActivityTypes.game,
        aspect: ActivityAspects.educational,
        ageRange: ['6-8'],
        difficulty: DifficultyLevels.easy,
        duration: 20,
        xpReward: 75,
        thumbnailUrl: 'assets/images/math/addition.png',
        tags: ['addition', 'arithmetic', 'visual'],
        learningObjectives: ['Add numbers 1-5', 'Use visual aids', 'Understand addition concept'],
        isOfflineAvailable: true,
        isPremium: false,
        parentApprovalRequired: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        playCount: 0,
      ),
      
      // Science Activities
      Activity(
        id: 'sci_plants_01',
        title: 'Parts of a Plant',
        description: 'Learn about roots, stem, leaves, and flowers',
        category: ActivityCategories.science,
        type: ActivityTypes.lesson,
        aspect: ActivityAspects.educational,
        ageRange: ['6-9'],
        difficulty: DifficultyLevels.easy,
        duration: 18,
        xpReward: 60,
        thumbnailUrl: 'assets/images/science/plants.png',
        tags: ['plants', 'biology', 'nature'],
        learningObjectives: ['Identify plant parts', 'Understand plant functions', 'Nature awareness'],
        isOfflineAvailable: true,
        isPremium: false,
        parentApprovalRequired: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        playCount: 0,
      ),
      
      Activity(
        id: 'sci_animals_01',
        title: 'Animal Sounds Quiz',
        description: 'Match animals with their sounds',
        category: ActivityCategories.science,
        type: ActivityTypes.quiz,
        aspect: ActivityAspects.entertaining,
        ageRange: ['5-7'],
        difficulty: DifficultyLevels.beginner,
        duration: 12,
        xpReward: 40,
        thumbnailUrl: 'assets/images/science/animals.png',
        tags: ['animals', 'sounds', 'matching'],
        learningObjectives: ['Recognize animal sounds', 'Animal identification', 'Audio-visual matching'],
        isOfflineAvailable: true,
        isPremium: false,
        parentApprovalRequired: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        playCount: 0,
      ),
      
      // Reading Activities
      Activity(
        id: 'read_alphabet_01',
        title: 'Alphabet Adventure',
        description: 'Learn letters A-Z with fun characters',
        category: ActivityCategories.reading,
        type: ActivityTypes.lesson,
        aspect: ActivityAspects.educational,
        ageRange: ['5-6'],
        difficulty: DifficultyLevels.beginner,
        duration: 25,
        xpReward: 55,
        thumbnailUrl: 'assets/images/reading/alphabet.png',
        tags: ['alphabet', 'letters', 'phonics'],
        learningObjectives: ['Recognize letters', 'Learn letter sounds', 'Alphabet sequence'],
        isOfflineAvailable: true,
        isPremium: false,
        parentApprovalRequired: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        playCount: 0,
      ),
      
      Activity(
        id: 'read_story_01',
        title: 'The Brave Little Ant',
        description: 'A story about courage and friendship',
        category: ActivityCategories.reading,
        type: ActivityTypes.story,
        aspect: ActivityAspects.behavioral,
        ageRange: ['6-8'],
        difficulty: DifficultyLevels.easy,
        duration: 15,
        xpReward: 45,
        thumbnailUrl: 'assets/images/stories/ant.png',
        tags: ['story', 'courage', 'friendship'],
        learningObjectives: ['Story comprehension', 'Moral values', 'Vocabulary building'],
        isOfflineAvailable: true,
        isPremium: false,
        parentApprovalRequired: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        playCount: 0,
      ),
      
      // Games
      Activity(
        id: 'game_memory_01',
        title: 'Memory Match',
        description: 'Match pairs of colorful cards',
        category: ActivityCategories.games,
        type: ActivityTypes.game,
        aspect: ActivityAspects.skillful,
        ageRange: ['5-10'],
        difficulty: DifficultyLevels.medium,
        duration: 10,
        xpReward: 35,
        thumbnailUrl: 'assets/images/games/memory.png',
        tags: ['memory', 'matching', 'concentration'],
        learningObjectives: ['Memory skills', 'Pattern recognition', 'Focus and attention'],
        isOfflineAvailable: true,
        isPremium: false,
        parentApprovalRequired: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        playCount: 0,
      ),
      
      Activity(
        id: 'game_puzzle_01',
        title: 'Shape Puzzle',
        description: 'Fit shapes into their correct places',
        category: ActivityCategories.games,
        type: ActivityTypes.game,
        aspect: ActivityAspects.skillful,
        ageRange: ['4-6'],
        difficulty: DifficultyLevels.beginner,
        duration: 8,
        xpReward: 30,
        thumbnailUrl: 'assets/images/games/puzzle.png',
        tags: ['shapes', 'puzzle', 'spatial'],
        learningObjectives: ['Shape recognition', 'Spatial awareness', 'Problem solving'],
        isOfflineAvailable: true,
        isPremium: false,
        parentApprovalRequired: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        playCount: 0,
      ),
      
      // Music Activities
      Activity(
        id: 'music_songs_01',
        title: 'Sing Along Songs',
        description: 'Learn fun children songs',
        category: ActivityCategories.music,
        type: ActivityTypes.song,
        aspect: ActivityAspects.entertaining,
        ageRange: ['5-8'],
        difficulty: DifficultyLevels.easy,
        duration: 12,
        xpReward: 40,
        thumbnailUrl: 'assets/images/music/songs.png',
        tags: ['songs', 'singing', 'music'],
        learningObjectives: ['Rhythm', 'Vocabulary', 'Musical expression'],
        isOfflineAvailable: false,
        isPremium: false,
        parentApprovalRequired: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        playCount: 0,
      ),
      
      // Social Skills
      Activity(
        id: 'social_friends_01',
        title: 'Making Friends',
        description: 'Learn how to make and keep friends',
        category: ActivityCategories.socialSkills,
        type: ActivityTypes.interactiveStory,
        aspect: ActivityAspects.behavioral,
        ageRange: ['6-9'],
        difficulty: DifficultyLevels.easy,
        duration: 16,
        xpReward: 50,
        thumbnailUrl: 'assets/images/social/friends.png',
        tags: ['friendship', 'social', 'emotions'],
        learningObjectives: ['Social skills', 'Empathy', 'Communication'],
        isOfflineAvailable: true,
        isPremium: false,
        parentApprovalRequired: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        playCount: 0,
      ),
      
      // Problem Solving
      Activity(
        id: 'problem_logic_01',
        title: 'Logic Puzzles',
        description: 'Solve fun logic problems',
        category: ActivityCategories.problemSolving,
        type: ActivityTypes.challenge,
        aspect: ActivityAspects.educational,
        ageRange: ['8-12'],
        difficulty: DifficultyLevels.medium,
        duration: 25,
        xpReward: 80,
        thumbnailUrl: 'assets/images/problem/logic.png',
        tags: ['logic', 'reasoning', 'problems'],
        learningObjectives: ['Logical thinking', 'Problem solving', 'Critical analysis'],
        isOfflineAvailable: true,
        isPremium: true,
        parentApprovalRequired: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        playCount: 0,
      ),
    ];
  }

  // ==================== CRUD OPERATIONS ====================

  /// Get activity by ID
  Future<Activity?> getActivity(String activityId) async {
    try {
      return _getActivityFromBox(activityId);
    } catch (e, stack) {
      _logger.e('Error getting activity: $activityId, $e');
      return null;
    }
  }

  /// Get all activities
  Future<List<Activity>> getAllActivities() async {
    try {
      return _getAllActivitiesFromBox();
    } catch (e, stack) {
      _logger.e('Error getting all activities: $e');
      return [];
    }
  }

  /// Get activities by category
  Future<List<Activity>> getActivitiesByCategory(String category) async {
    try {
      return _getAllActivitiesFromBox()
          .where((activity) => activity.category == category)
          .toList();
    } catch (e, stack) {
      _logger.e('Error getting activities by category: $category, $e');
      return [];
    }
  }

  /// Get activities by type
  Future<List<Activity>> getActivitiesByType(String type) async {
    try {
      return _getAllActivitiesFromBox()
          .where((activity) => activity.type == type)
          .toList();
    } catch (e, stack) {
      _logger.e('Error getting activities by type: $type, $e');
      return [];
    }
  }

  /// Get activities by aspect
  Future<List<Activity>> getActivitiesByAspect(String aspect) async {
    try {
      return _getAllActivitiesFromBox()
          .where((activity) => activity.aspect == aspect)
          .toList();
    } catch (e, stack) {
      _logger.e('Error getting activities by aspect: $aspect, $e');
      return [];
    }
  }

  /// Search activities by query
  Future<List<Activity>> searchActivities(String query) async {
    try {
      final lowerQuery = query.toLowerCase();
      return _getAllActivitiesFromBox().where((activity) {
        return activity.title.toLowerCase().contains(lowerQuery) ||
               activity.description.toLowerCase().contains(lowerQuery) ||
               activity.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
      }).toList();
    } catch (e, stack) {
      _logger.e('Error searching activities: $query, $e');
      return [];
    }
  }

  // ==================== FILTERING OPERATIONS ====================

  /// Get activities appropriate for child
  Future<List<Activity>> getActivitiesForChild(ChildProfile child) async {
    try {
      return _getAllActivitiesFromBox().where((activity) {
        // Check age appropriateness
        if (!activity.isAppropriateForAge(child.age)) {
          return false;
        }
        
        // Check accessibility needs
        if (child.hasAccessibilityNeeds && !activity.isOfflineAvailable) {
          return false; // Prefer offline activities for accessibility
        }
        
        return true;
      }).toList();
    } catch (e, stack) {
      _logger.e('Error getting activities for child: ${child.id}, $e');
      return [];
    }
  }

  /// Get recommended activities for child
  Future<List<Activity>> getRecommendedActivities(ChildProfile child) async {
    try {
      final allActivities = await getActivitiesForChild(child);
      
      // Score activities based on child's interests
      final scoredActivities = allActivities.map((activity) {
        double score = 0.0;
        
        // Interest matching
        final commonInterests = activity.tags.where(
          (tag) => child.interests.contains(tag)
        ).length;
        score += commonInterests * 2.0;
        
        // Category matching
        if (child.interests.contains(activity.category)) {
          score += 3.0;
        }
        
        // Difficulty appropriateness
        final levelDiff = (activity.difficultyLevel - child.level).abs();
        if (levelDiff <= 1) {
          score += 2.0;
        } else if (levelDiff <= 2) {
          score += 1.0;
        }
        
        // Popularity
        score += activity.playCount * 0.1;
        
        // Rating
        if (activity.averageRating != null) {
          score += activity.averageRating! * 0.5;
        }
        
        return {'activity': activity, 'score': score};
      }).toList();
      
      // Sort by score and return top activities
      scoredActivities.sort((a, b) => (b['score'] as num).compareTo(a['score'] as num));
      
      return scoredActivities
          .take(10)
          .map((item) => item['activity'] as Activity)
          .toList();
    } catch (e, stack) {
      _logger.e('Error getting recommended activities for child: ${child.id}, $e');
      return [];
    }
  }

  /// Get activities by difficulty
  Future<List<Activity>> getActivitiesByDifficulty(String difficulty) async {
    try {
      return _getAllActivitiesFromBox()
          .where((activity) => activity.difficulty == difficulty)
          .toList();
    } catch (e, stack) {
      _logger.e('Error getting activities by difficulty: $difficulty, $e');
      return [];
    }
  }

  // ==================== OFFLINE SUPPORT ====================

  /// Get offline available activities
  Future<List<Activity>> getOfflineActivities() async {
    try {
      return _getAllActivitiesFromBox()
          .where((activity) => activity.isOfflineAvailable)
          .toList();
    } catch (e, stack) {
      _logger.e('Error getting offline activities: $e');
      return [];
    }
  }

  /// Download activity for offline use
  Future<bool> downloadForOffline(String activityId) async {
    try {
      final activity = _getActivityFromBox(activityId);
      if (activity == null) return false;
      
      // In a real app, this would download content files
      _logger.d('Downloading activity for offline: $activityId');
      await Future.delayed(const Duration(seconds: 2)); // Simulate download
      
      return true;
    } catch (e, stack) {
      _logger.e('Error downloading activity for offline: $activityId, $e');
      return false;
    }
  }

  // ==================== ANALYTICS ====================

  /// Get popular activities
  Future<List<Activity>> getPopularActivities({int limit = 10}) async {
    try {
      final activities = _getAllActivitiesFromBox();
      activities.sort((a, b) => b.playCount.compareTo(a.playCount));
      return activities.take(limit).toList();
    } catch (e, stack) {
      _logger.e('Error getting popular activities: $e');
      return [];
    }
  }

  /// Get recently added activities
  Future<List<Activity>> getRecentlyAddedActivities({int limit = 10}) async {
    try {
      final activities = _getAllActivitiesFromBox();
      activities.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return activities.take(limit).toList();
    } catch (e, stack) {
      _logger.e('Error getting recently added activities: $e');
      return [];
    }
  }

  /// Increment play count
  Future<bool> incrementPlayCount(String activityId) async {
    try {
      final activity = _getActivityFromBox(activityId);
      if (activity == null) return false;
      
      final updated = activity.copyWith(
        playCount: activity.playCount + 1,
        updatedAt: DateTime.now(),
      );
      
      await _saveActivityToBox(activityId, updated);
      return true;
    } catch (e, stack) {
      _logger.e('Error incrementing play count: $activityId, $e');
      return false;
    }
  }

  // ==================== SYNC OPERATIONS ====================

  /// Get activities that need sync
  Future<List<Activity>> getActivitiesNeedingSync() async {
    try {
      // In a real app, this would check sync status
      return [];
    } catch (e, stack) {
      _logger.e('Error getting activities needing sync: $e');
      return [];
    }
  }

  /// Sync with server (placeholder)
  Future<bool> syncWithServer() async {
    try {
      _logger.d('Syncing activities with server');
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      return true;
    } catch (e, stack) {
      _logger.e('Error syncing with server: $e');
      return false;
    }
  }
}