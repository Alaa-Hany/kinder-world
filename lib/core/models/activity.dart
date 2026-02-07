import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

@freezed
class Activity with _$Activity {
  @HiveType(typeId: 3)
  const factory Activity({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String description,
    @HiveField(3) required String category,
    @HiveField(4) required String type,
    @HiveField(5) required String aspect,
    @HiveField(6) required List<String> ageRange,
    @HiveField(7) required String difficulty,
    @HiveField(8) required int duration,
    @HiveField(9) required int xpReward,
    @HiveField(10) required String thumbnailUrl,
    @HiveField(11) String? contentUrl,
    @HiveField(12) required List<String> tags,
    @HiveField(13) required List<String> learningObjectives,
    @HiveField(14) String? instructions,
    @HiveField(15) List<String>? materialsNeeded,
    @HiveField(16) @JsonKey(name: 'is_offline_available') required bool isOfflineAvailable,
    @HiveField(17) @JsonKey(name: 'is_premium') required bool isPremium,
    @HiveField(18) @JsonKey(name: 'parent_approval_required') required bool parentApprovalRequired,
    @HiveField(19) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(20) @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @HiveField(21) @JsonKey(name: 'completion_rate') double? completionRate,
    @HiveField(22) @JsonKey(name: 'average_rating') double? averageRating,
    @HiveField(23) @JsonKey(name: 'play_count') required int playCount,
  }) = _Activity;

  const Activity._();

  factory Activity.fromJson(Map<String, dynamic> json) => 
      _$ActivityFromJson(json);

  // Check if activity is appropriate for age
  bool isAppropriateForAge(int age) {
    if (ageRange.isEmpty) return true;
    
    for (final range in ageRange) {
      if (range.contains('-')) {
        final parts = range.split('-');
        if (parts.length == 2) {
          final minAge = int.tryParse(parts[0]) ?? 0;
          final maxAge = int.tryParse(parts[1]) ?? 99;
          if (age >= minAge && age <= maxAge) return true;
        }
      } else {
        final targetAge = int.tryParse(range);
        if (targetAge == age) return true;
      }
    }
    return false;
  }

  // Get difficulty level as integer
  int get difficultyLevel {
    switch (difficulty) {
      case 'beginner':
        return 1;
      case 'easy':
        return 2;
      case 'medium':
        return 3;
      case 'hard':
        return 4;
      case 'expert':
        return 5;
      default:
        return 2;
    }
  }

  // Get aspect color
  String get aspectColor {
    switch (aspect) {
      case 'behavioral':
        return '#E91E63';
      case 'skillful':
        return '#9C27B0';
      case 'educational':
        return '#3F51B5';
      case 'entertaining':
        return '#00BCD4';
      default:
        return '#4A86E8';
    }
  }

  // Check if activity is interactive
  bool get isInteractive {
    return type == 'game' || type == 'quiz' || type == 'interactive_story';
  }

  // Get estimated completion time as string
  String get estimatedTime {
    if (duration < 60) {
      return '$duration min';
    } else {
      final hours = duration ~/ 60;
      final minutes = duration % 60;
      if (minutes == 0) {
        return '$hours hour${hours > 1 ? 's' : ''}';
      } else {
        return '$hours hour${hours > 1 ? 's' : ''} $minutes min';
      }
    }
  }

  // Get rating as stars
  int get ratingStars {
    if (averageRating == null) return 0;
    return (averageRating! * 2).round() ~/ 2;
  }
}

// Activity categories
class ActivityCategories {
  static const String mathematics = 'mathematics';
  static const String science = 'science';
  static const String reading = 'reading';
  static const String history = 'history';
  static const String geography = 'geography';
  static const String languages = 'languages';
  static const String socialSkills = 'social_skills';
  static const String emotionalIntelligence = 'emotional_intelligence';
  static const String creativity = 'creativity';
  static const String motorSkills = 'motor_skills';
  static const String problemSolving = 'problem_solving';
  static const String music = 'music';
  static const String games = 'games';
  static const String stories = 'stories';
  static const String videos = 'videos';
  
  static const List<String> all = [
    mathematics, science, reading, history, geography, languages,
    socialSkills, emotionalIntelligence, creativity, motorSkills,
    problemSolving, music, games, stories, videos
  ];
}

// Activity types
class ActivityTypes {
  static const String lesson = 'lesson';
  static const String game = 'game';
  static const String quiz = 'quiz';
  static const String story = 'story';
  static const String video = 'video';
  static const String interactiveStory = 'interactive_story';
  static const String craft = 'craft';
  static const String song = 'song';
  static const String challenge = 'challenge';
  static const String simulation = 'simulation';
  
  static const List<String> all = [
    lesson, game, quiz, story, video, interactiveStory,
    craft, song, challenge, simulation
  ];
}

// Activity aspects (from SRS)
class ActivityAspects {
  static const String behavioral = 'behavioral';
  static const String skillful = 'skillful';
  static const String educational = 'educational';
  static const String entertaining = 'entertaining';
  
  static const List<String> all = [
    behavioral, skillful, educational, entertaining
  ];
  
  static String getDisplayName(String aspect) {
    switch (aspect) {
      case behavioral:
        return 'Behavioral';
      case skillful:
        return 'Skillful';
      case educational:
        return 'Educational';
      case entertaining:
        return 'Entertaining';
      default:
        return aspect;
    }
  }
}

// Difficulty levels
class DifficultyLevels {
  static const String beginner = 'beginner';
  static const String easy = 'easy';
  static const String medium = 'medium';
  static const String hard = 'hard';
  static const String expert = 'expert';
  
  static const List<String> all = [
    beginner, easy, medium, hard, expert
  ];
  
  static String getDisplayName(String difficulty) {
    switch (difficulty) {
      case beginner:
        return 'Beginner';
      case easy:
        return 'Easy';
      case medium:
        return 'Medium';
      case hard:
        return 'Hard';
      case expert:
        return 'Expert';
      default:
        return difficulty;
    }
  }
}