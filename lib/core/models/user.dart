import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @HiveType(typeId: 1)
  const factory User({
    @HiveField(0) required String id,
    @HiveField(1) required String email,
    @HiveField(2) required String role,
    @HiveField(3) String? name,
    @HiveField(4) String? phone,
    @HiveField(5) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(6) @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @HiveField(7) @JsonKey(name: 'is_active') required bool isActive,
    @HiveField(8) @JsonKey(name: 'subscription_status') String? subscriptionStatus,
    @HiveField(9) @JsonKey(name: 'trial_end_date') DateTime? trialEndDate,
  }) = _User;

  const User._();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // Check if user is a parent
  bool get isParent => role == 'parent';
  
  // Check if user is a child
  bool get isChild => role == 'child';
  
  // Check if user is an admin
  bool get isAdmin => role == 'admin';
  
  // Check if subscription is active
  bool get hasActiveSubscription {
    if (subscriptionStatus == 'active') return true;
    if (trialEndDate != null && trialEndDate!.isAfter(DateTime.now())) return true;
    return false;
  }
  
  // Check if trial is active
  bool get hasActiveTrial {
    return trialEndDate != null && trialEndDate!.isAfter(DateTime.now());
  }
  
  // Get remaining trial days
  int get remainingTrialDays {
    if (trialEndDate == null) return 0;
    final difference = trialEndDate!.difference(DateTime.now()).inDays;
    return difference > 0 ? difference : 0;
  }
}

// User roles
class UserRoles {
  static const String parent = 'parent';
  static const String child = 'child';
  static const String admin = 'admin';
}

// Subscription statuses
class SubscriptionStatus {
  static const String active = 'active';
  static const String expired = 'expired';
  static const String canceled = 'canceled';
  static const String trial = 'trial';
}