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

  // Helper methods
  int get nextLevelXP => level * 1000;
  double get xpProgress => (xp % 1000) / 1000.0;
  String get displayAge => age <= 0 ? '—' : age.toString();
  
  bool get hasStreak => streak > 0;
  
  String get ageGroup {
    if (age <= 6) return 'early_childhood';
    if (age <= 9) return 'middle_childhood';
    return 'late_childhood';
  }
}

// Learning styles
class LearningStyles {
  static const String visual = 'visual';
  static const String auditory = 'auditory';
  static const String kinesthetic = 'kinesthetic';
  static const String reading = 'reading';
  
  static const List<String> all = [visual, auditory, kinesthetic, reading];
}

// Moods
class ChildMoods {
  static const String happy = 'happy';
  static const String sad = 'sad';
  static const String excited = 'excited';
  static const String tired = 'tired';
  static const String angry = 'angry';
  
  static const List<String> all = [happy, excited, calm, tired, sad, angry];
}

// Backwards-compatible MoodTypes API expected by UI
class MoodTypes {
  static const String happy = ChildMoods.happy;
  static const String excited = ChildMoods.excited;
  static const String calm = ChildMoods.calm;
  static const String tired = ChildMoods.tired;
  static const String sad = ChildMoods.sad;
  static const String angry = ChildMoods.angry;

  static String getEmoji(String mood) {
    switch (mood) {
      case happy:
        return '😊';
      case excited:
        return '🤩';
      case calm:
        return '😌';
      case tired:
        return '😴';
      case sad:
        return '😢';
      case angry:
        return '😠';
      default:
        return '🙂';
    }
  }

  static String getLabel(String mood) {
    switch (mood) {
      case happy:
        return 'Happy';
      case excited:
        return 'Excited';
      case calm:
        return '😌';
      default:
        return 'Neutral';
    }
  }
} 
