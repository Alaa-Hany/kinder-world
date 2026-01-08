import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'child_profile.freezed.dart';
part 'child_profile.g.dart';

@freezed
class ChildProfile with _$ChildProfile {
  @HiveType(typeId: 2)
  const factory ChildProfile({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required int age,
    @HiveField(3) required String avatar,
    @HiveField(4) required List<String> interests,
    @HiveField(5) required int level,
    @HiveField(6) required int xp,
    @HiveField(7) required int streak,
    @HiveField(8) required List<String> favorites,
    @HiveField(9) required String parentId,
    @HiveField(10) @JsonKey(name: 'picture_password') required List<String> picturePassword,
    @HiveField(11) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(12) @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @HiveField(13) @JsonKey(name: 'last_session') DateTime? lastSession,
    @HiveField(14) @JsonKey(name: 'total_time_spent') required int totalTimeSpent,
    @HiveField(15) @JsonKey(name: 'activities_completed') required int activitiesCompleted,
    @HiveField(16) @JsonKey(name: 'current_mood') String? currentMood,
    @HiveField(17) @JsonKey(name: 'learning_style') String? learningStyle,
    @HiveField(18) @JsonKey(name: 'special_needs') List<String>? specialNeeds,
    @HiveField(19) @JsonKey(name: 'accessibility_needs') List<String>? accessibilityNeeds,
  }) = _ChildProfile;

  const ChildProfile._();

  factory ChildProfile.fromJson(Map<String, dynamic> json) => 
      _$ChildProfileFromJson(json);

  // Calculate level from XP
  int get calculatedLevel {
    // Simple level calculation: every 1000 XP = 1 level
    return (xp / 1000).floor() + 1;
  }

  // Check if streak is active (last activity was today or yesterday)
  bool get hasActiveStreak {
    if (lastSession == null) return false;
    final now = DateTime.now();
    final difference = now.difference(lastSession!).inDays;
    return difference <= 1;
  }

  // Get next level XP requirement
  int get xpForNextLevel {
    return level * 1000;
  }

  // Get XP progress to next level
  int get xpProgress {
    return xp % 1000;
  }

  // Convert total time spent to hours
  double get totalHoursSpent {
    return totalTimeSpent / 60.0;
  }

  // Get age-appropriate content rating
  String get contentRating {
    if (age <= 7) return 'early_childhood';
    if (age <= 10) return 'middle_childhood';
    return 'late_childhood';
  }

  // Check if child needs accessibility features
  bool get hasAccessibilityNeeds {
    return accessibilityNeeds != null && accessibilityNeeds!.isNotEmpty;
  }

  // Get recommended daily time limit based on age (in minutes)
  int get recommendedDailyLimit {
    if (age <= 6) return 60; // 1 hour for ages 5-6
    if (age <= 8) return 90; // 1.5 hours for ages 7-8
    if (age <= 10) return 120; // 2 hours for ages 9-10
    return 150; // 2.5 hours for ages 11-12
  }
}

// Mood types
class MoodTypes {
  static const String happy = 'happy';
  static const String sad = 'sad';
  static const String excited = 'excited';
  static const String tired = 'tired';
  static const String angry = 'angry';
  static const String calm = 'calm';
  
  static const List<String> all = [
    happy, sad, excited, tired, angry, calm
  ];
  
  static String getEmoji(String mood) {
    switch (mood) {
      case happy:
        return '😊';
      case sad:
        return '😢';
      case excited:
        return '🤩';
      case tired:
        return '😴';
      case angry:
        return '😠';
      case calm:
        return '😌';
      default:
        return '😐';
    }
  }
}

// Learning styles
class LearningStyles {
  static const String visual = 'visual';
  static const String auditory = 'auditory';
  static const String kinesthetic = 'kinesthetic';
  static const String social = 'social';
  static const String solitary = 'solitary';
  
  static const List<String> all = [
    visual, auditory, kinesthetic, social, solitary
  ];
}

// Special needs categories
class SpecialNeeds {
  static const String autism = 'autism';
  static const String adhd = 'adhd';
  static const String dyslexia = 'dyslexia';
  static const String hearingImpairment = 'hearing_impairment';
  static const String visualImpairment = 'visual_impairment';
  static const String motorDifficulties = 'motor_difficulties';
  
  static const List<String> all = [
    autism, adhd, dyslexia, hearingImpairment, 
    visualImpairment, motorDifficulties
  ];
}

// Accessibility needs
class AccessibilityNeeds {
  static const String largeText = 'large_text';
  static const String highContrast = 'high_contrast';
  static const String voiceGuidance = 'voice_guidance';
  static const String simplifiedInterface = 'simplified_interface';
  static const String switchAccess = 'switch_access';
  static const String closedCaptions = 'closed_captions';
  
  static const List<String> all = [
    largeText, highContrast, voiceGuidance, 
    simplifiedInterface, switchAccess, closedCaptions
  ];
}