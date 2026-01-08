import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/constants/app_constants.dart';

class ParentNotificationsScreen extends ConsumerWidget {
  const ParentNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = _getMockNotifications();
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: AppConstants.fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read
            },
            child: Text(
              'Mark All Read',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(24.0),
          itemCount: notifications.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return _NotificationCard(
              notification: notification,
              onTap: () {
                // Handle notification tap
              },
            );
          },
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getMockNotifications() {
    return [
      {
        'id': '1',
        'title': 'Daily Goal Achieved',
        'message': 'Ahmed completed 3 activities today!',
        'time': '2 hours ago',
        'type': 'achievement',
        'isRead': false,
        'childName': 'Ahmed',
      },
      {
        'id': '2',
        'title': 'Screen Time Alert',
        'message': 'Sara has reached her daily limit of 2 hours.',
        'time': '4 hours ago',
        'type': 'warning',
        'isRead': false,
        'childName': 'Sara',
      },
      {
        'id': '3',
        'title': 'New Achievement',
        'message': 'Ahmed unlocked the "Math Master" badge!',
        'time': '1 day ago',
        'type': 'achievement',
        'isRead': true,
        'childName': 'Ahmed',
      },
      {
        'id': '4',
        'title': 'Weekly Report Ready',
        'message': 'Your child\'s progress report for this week is available.',
        'time': '2 days ago',
        'type': 'report',
        'isRead': true,
        'childName': 'All Children',
      },
      {
        'id': '5',
        'title': 'Learning Milestone',
        'message': 'Sara completed her 50th activity!',
        'time': '3 days ago',
        'type': 'milestone',
        'isRead': true,
        'childName': 'Sara',
      },
      {
        'id': '6',
        'title': 'Content Recommendation',
        'message': 'New educational content available for Ahmed based on his interests.',
        'time': '1 week ago',
        'type': 'recommendation',
        'isRead': true,
        'childName': 'Ahmed',
      },
    ];
  }
}

class _NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback onTap;
  
  const _NotificationCard({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: notification['isRead'] ? AppColors.white : AppColors.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: notification['isRead'] ? AppColors.lightGrey : AppColors.primary.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon based on type
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getTypeColor(notification['type']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                _getTypeIcon(notification['type']),
                size: 24,
                color: _getTypeColor(notification['type']),
              ),
            ),
            const SizedBox(width: 16),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification['title'],
                          style: TextStyle(
                            fontSize: AppConstants.fontSize,
                            fontWeight: notification['isRead'] ? FontWeight.normal : FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      if (!notification['isRead'])
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  Text(
                    notification['message'],
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  Row(
                    children: [
                      Text(
                        notification['childName'],
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        notification['time'],
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'achievement':
        return AppColors.success;
      case 'warning':
        return AppColors.error;
      case 'report':
        return AppColors.info;
      case 'milestone':
        return AppColors.xpColor;
      case 'recommendation':
        return AppColors.secondary;
      default:
        return AppColors.primary;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'achievement':
        return Icons.emoji_events;
      case 'warning':
        return Icons.warning;
      case 'report':
        return Icons.analytics;
      case 'milestone':
        return Icons.flag;
      case 'recommendation':
        return Icons.thumb_up;
      default:
        return Icons.notifications;
    }
  }
}