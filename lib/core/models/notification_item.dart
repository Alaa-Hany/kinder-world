import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'notification_item.freezed.dart';
part 'notification_item.g.dart';

@freezed
class NotificationItem with _$NotificationItem {
  @HiveType(typeId: 8)
  const factory NotificationItem({
    @HiveField(0) required String id,
    @HiveField(1) required String type,
    @HiveField(2) required String title,
    @HiveField(3) required String body,
    @HiveField(4) required String recipientId,
    @HiveField(5) required String recipientRole,
    @HiveField(6) @JsonKey(name: 'related_child_id') String? relatedChildId,
    @HiveField(7) @JsonKey(name: 'related_activity_id') String? relatedActivityId,
    @HiveField(8) @JsonKey(name: 'is_read') required bool isRead,
    @HiveField(9) @JsonKey(name: 'is_sent') required bool isSent,
    @HiveField(10) @JsonKey(name: 'sent_at') DateTime? sentAt,
    @HiveField(11) @JsonKey(name: 'read_at') DateTime? readAt,
    @HiveField(12) @JsonKey(name: 'priority') required String priority,
    @HiveField(13) Map<String, dynamic>? data,
    @HiveField(14) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(15) @JsonKey(name: 'expires_at') DateTime? expiresAt,
  }) = _NotificationItem;

  const NotificationItem._();

  factory NotificationItem.fromJson(Map<String, dynamic> json) => 
      _$NotificationItemFromJson(json);

  // Check if notification is expired
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  // Check if notification is urgent
  bool get isUrgent {
    return priority == NotificationPriority.urgent;
  }

  // Check if notification is for parent
  bool get isForParent {
    return recipientRole == 'parent';
  }

  // Check if notification is for child
  bool get isForChild {
    return recipientRole == 'child';
  }

  // Get time since notification was created
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    
    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      final weeks = difference.inDays ~/ 7;
      return '$weeks weeks ago';
    }
  }

  // Mark as read
  NotificationItem markAsRead() {
    return copyWith(
      isRead: true,
      readAt: DateTime.now(),
    );
  }

  // Mark as sent
  NotificationItem markAsSent() {
    return copyWith(
      isSent: true,
      sentAt: DateTime.now(),
    );
  }
}

// Notification types
class NotificationTypes {
  static const String achievement = 'achievement';
  static const String milestone = 'milestone';
  static const String reminder = 'reminder';
  static const String warning = 'warning';
  static const String reportReady = 'report_ready';
  static const String contentRecommended = 'content_recommended';
  static const String breakReminder = 'break_reminder';
  static const String timeLimitWarning = 'time_limit_warning';
  static const String approvalRequired = 'approval_required';
  static const String subscription = 'subscription';
  static const String system = 'system';
  static const String aiInsight = 'ai_insight';
  
  static const List<String> all = [
    achievement, milestone, reminder, warning, reportReady,
    contentRecommended, breakReminder, timeLimitWarning,
    approvalRequired, subscription, system, aiInsight
  ];
  
  static String getDisplayName(String type) {
    switch (type) {
      case achievement:
        return 'Achievement';
      case milestone:
        return 'Milestone';
      case reminder:
        return 'Reminder';
      case warning:
        return 'Warning';
      case reportReady:
        return 'Report Ready';
      case contentRecommended:
        return 'Content Recommended';
      case breakReminder:
        return 'Break Reminder';
      case timeLimitWarning:
        return 'Time Limit Warning';
      case approvalRequired:
        return 'Approval Required';
      case subscription:
        return 'Subscription';
      case system:
        return 'System';
      case aiInsight:
        return 'AI Insight';
      default:
        return type;
    }
  }
  
  static IconData getIcon(String type) {
    switch (type) {
      case achievement:
        return Icons.emoji_events;
      case milestone:
        return Icons.flag;
      case reminder:
        return Icons.notifications;
      case warning:
        return Icons.warning;
      case reportReady:
        return Icons.assessment;
      case contentRecommended:
        return Icons.recommend;
      case breakReminder:
        return Icons.coffee;
      case timeLimitWarning:
        return Icons.timer;
      case approvalRequired:
        return Icons.approval;
      case subscription:
        return Icons.payment;
      case system:
        return Icons.settings;
      case aiInsight:
        return Icons.psychology;
      default:
        return Icons.notifications;
    }
  }
}

// Notification priorities
class NotificationPriority {
  static const String low = 'low';
  static const String normal = 'normal';
  static const String high = 'high';
  static const String urgent = 'urgent';
  
  static const List<String> all = [
    low, normal, high, urgent
  ];
  
  static Color getColor(String priority) {
    switch (priority) {
      case urgent:
        return Colors.red;
      case high:
        return Colors.orange;
      case normal:
        return Colors.blue;
      case low:
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }
}

// Notification data keys
class NotificationDataKeys {
  static const String activityId = 'activity_id';
  static const String childId = 'child_id';
  static const String reportId = 'report_id';
  static const String achievementType = 'achievement_type';
  static const String xpEarned = 'xp_earned';
  static const String streakCount = 'streak_count';
  static const String timeRemaining = 'time_remaining';
  static const String recommendedContent = 'recommended_content';
}