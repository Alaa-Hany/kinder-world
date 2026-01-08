import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'screen_time_rule.freezed.dart';
part 'screen_time_rule.g.dart';

@freezed
class ScreenTimeRule with _$ScreenTimeRule {
  @HiveType(typeId: 5)
  const factory ScreenTimeRule({
    @HiveField(0) required String id,
    @HiveField(1) required String childId,
    @HiveField(2) @JsonKey(name: 'daily_limit_minutes') required int dailyLimitMinutes,
    @HiveField(3) @JsonKey(name: 'allowed_hours') required List<TimeSlot> allowedHours,
    @HiveField(4) @JsonKey(name: 'sleep_mode_enabled') required bool sleepModeEnabled,
    @HiveField(5) @JsonKey(name: 'sleep_start_time') String? sleepStartTime,
    @HiveField(6) @JsonKey(name: 'sleep_end_time') String? sleepEndTime,
    @HiveField(7) @JsonKey(name: 'break_reminders_enabled') required bool breakRemindersEnabled,
    @HiveField(8) @JsonKey(name: 'break_interval_minutes') int? breakIntervalMinutes,
    @HiveField(9) @JsonKey(name: 'break_duration_minutes') int? breakDurationMinutes,
    @HiveField(10) @JsonKey(name: 'emergency_lock_enabled') required bool emergencyLockEnabled,
    @HiveField(11) @JsonKey(name: 'smart_control_enabled') required bool smartControlEnabled,
    @HiveField(12) @JsonKey(name: 'ai_recommendations_enabled') required bool aiRecommendationsEnabled,
    @HiveField(13) @JsonKey(name: 'content_restrictions') required ContentRestrictions contentRestrictions,
    @HiveField(14) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(15) @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @HiveField(16) @JsonKey(name: 'is_active') required bool isActive,
  }) = _ScreenTimeRule;

  const ScreenTimeRule._();

  factory ScreenTimeRule.fromJson(Map<String, dynamic> json) => 
      _$ScreenTimeRuleFromJson(json);

  // Check if current time is within allowed hours
  bool isTimeAllowed(DateTime time) {
    if (allowedHours.isEmpty) return true;
    
    final currentTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    
    for (final slot in allowedHours) {
      if (slot.containsTime(currentTime)) {
        return true;
      }
    }
    return false;
  }

  // Check if sleep mode is active
  bool isSleepModeActive(DateTime time) {
    if (!sleepModeEnabled || sleepStartTime == null || sleepEndTime == null) {
      return false;
    }
    
    final currentTime = time.hour * 60 + time.minute;
    final startParts = sleepStartTime!.split(':');
    final endParts = sleepEndTime!.split(':');
    
    final startTime = int.parse(startParts[0]) * 60 + int.parse(startParts[1]);
    final endTime = int.parse(endParts[0]) * 60 + int.parse(endParts[1]);
    
    // Handle overnight sleep periods
    if (startTime > endTime) {
      return currentTime >= startTime || currentTime <= endTime;
    } else {
      return currentTime >= startTime && currentTime <= endTime;
    }
  }

  // Check if it's time for a break
  bool shouldTakeBreak(int sessionTimeMinutes) {
    if (!breakRemindersEnabled || breakIntervalMinutes == null) {
      return false;
    }
    return sessionTimeMinutes >= breakIntervalMinutes!;
  }

  // Get remaining time for today
  int getRemainingTime(int timeUsedToday) {
    return (dailyLimitMinutes - timeUsedToday).clamp(0, dailyLimitMinutes);
  }

  // Check if daily limit is exceeded
  bool isDailyLimitExceeded(int timeUsedToday) {
    return timeUsedToday >= dailyLimitMinutes;
  }
}

@freezed
class TimeSlot with _$TimeSlot {
  @HiveType(typeId: 6)
  const factory TimeSlot({
    @HiveField(0) required String start,
    @HiveField(1) required String end,
    @HiveField(2) required List<String> days,
  }) = _TimeSlot;

  const TimeSlot._();

  factory TimeSlot.fromJson(Map<String, dynamic> json) => 
      _$TimeSlotFromJson(json);

  // Check if time falls within this slot
  bool containsTime(String time) {
    final timeMinutes = _timeToMinutes(time);
    final startMinutes = _timeToMinutes(start);
    final endMinutes = _timeToMinutes(end);
    
    return timeMinutes >= startMinutes && timeMinutes <= endMinutes;
  }

  // Check if slot is active on a specific day
  bool isActiveOnDay(String day) {
    return days.contains(day.toLowerCase());
  }

  // Convert HH:MM time to minutes
  int _timeToMinutes(String time) {
    final parts = time.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }
}

@freezed
class ContentRestrictions with _$ContentRestrictions {
  @HiveType(typeId: 7)
  const factory ContentRestrictions({
    @HiveField(0) @JsonKey(name: 'blocked_categories') required List<String> blockedCategories,
    @HiveField(1) @JsonKey(name: 'blocked_activities') required List<String> blockedActivities,
    @HiveField(2) @JsonKey(name: 'allowed_categories') required List<String> allowedCategories,
    @HiveField(3) @JsonKey(name: 'max_difficulty') String? maxDifficulty,
    @HiveField(4) @JsonKey(name: 'require_approval_for') required List<String> requireApprovalFor,
    @HiveField(5) @JsonKey(name: 'age_appropriate_only') required bool ageAppropriateOnly,
    @HiveField(6) @JsonKey(name: 'educational_focus') bool? educationalFocus,
  }) = _ContentRestrictions;

  const ContentRestrictions._();

  factory ContentRestrictions.fromJson(Map<String, dynamic> json) => 
      _$ContentRestrictionsFromJson(json);

  // Check if activity is allowed
  bool isActivityAllowed(String activityCategory, String activityId, String difficulty) {
    // Check if activity is explicitly blocked
    if (blockedActivities.contains(activityId)) {
      return false;
    }
    
    // Check if category is blocked
    if (blockedCategories.contains(activityCategory)) {
      return false;
    }
    
    // Check if category is in allowed list (if list is not empty)
    if (allowedCategories.isNotEmpty && !allowedCategories.contains(activityCategory)) {
      return false;
    }
    
    // Check difficulty limit
    if (maxDifficulty != null) {
      final activityDiff = _getDifficultyValue(difficulty);
      final maxDiff = _getDifficultyValue(maxDifficulty!);
      if (activityDiff > maxDiff) {
        return false;
      }
    }
    
    return true;
  }

  // Check if activity requires approval
  bool requiresApproval(String activityCategory, String activityId) {
    return requireApprovalFor.contains(activityCategory) ||
           requireApprovalFor.contains(activityId);
  }

  // Convert difficulty string to numeric value
  int _getDifficultyValue(String difficulty) {
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
}

// Days of week
class DaysOfWeek {
  static const String monday = 'monday';
  static const String tuesday = 'tuesday';
  static const String wednesday = 'wednesday';
  static const String thursday = 'thursday';
  static const String friday = 'friday';
  static const String saturday = 'saturday';
  static const String sunday = 'sunday';
  
  static const List<String> all = [
    monday, tuesday, wednesday, thursday, friday, saturday, sunday
  ];
  
  static String getDisplayName(String day, String language) {
    if (language == 'ar') {
      switch (day) {
        case monday:
          return 'الاثنين';
        case tuesday:
          return 'الثلاثاء';
        case wednesday:
          return 'الأربعاء';
        case thursday:
          return 'الخميس';
        case friday:
          return 'الجمعة';
        case saturday:
          return 'السبت';
        case sunday:
          return 'الأحد';
        default:
          return day;
      }
    } else {
      return day[0].toUpperCase() + day.substring(1);
    }
  }
}