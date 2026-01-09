import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/core/localization/app_localizations.dart';
import 'package:kinder_world/core/models/child_profile.dart';
import 'package:kinder_world/core/providers/auth_controller.dart';
import 'package:kinder_world/core/providers/child_session_controller.dart';
import 'package:kinder_world/core/theme/app_colors.dart';

class ChildProfileScreen extends ConsumerWidget {
  const ChildProfileScreen({super.key});

  ChildProfile _demoChild() {
    final now = DateTime.now();
    return ChildProfile(
      id: 'demo_child',
      name: 'Lina',
      age: 7,
      avatar: 'assets/images/avatars/girl1.png',
      interests: const ['math', 'science', 'reading'],
      level: 1,
      xp: 120,
      streak: 1,
      favorites: const [],
      parentId: 'demo-parent',
      picturePassword: const ['apple', 'ball', 'cat'],
      createdAt: now,
      updatedAt: now,
      totalTimeSpent: 30,
      activitiesCompleted: 3,
      currentMood: 'happy',
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final child = ref.watch(currentChildProvider) ?? _demoChild();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              const SizedBox(height: 20),
              
              // Avatar
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(
                    color: AppColors.primary,
                    width: 4,
                  ),
                ),
                child: Center(
                  child: Text(
                    child.name[0],
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Name and Level
              Text(
                child.name,
                style: const TextStyle(
                  fontSize: AppConstants.largeFontSize * 1.2,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                l10n.levelExplorer(child.level),
                style: const TextStyle(
                  fontSize: AppConstants.fontSize,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 30),
              
              // Stats Grid
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('${child.xp}', l10n.xp, AppColors.xpColor, Icons.star),
                  _buildStatItem('${child.streak}', l10n.streak, AppColors.streakColor, Icons.local_fire_department),
                  _buildStatItem('${child.activitiesCompleted}', l10n.activities, AppColors.success, Icons.check_circle),
                ],
              ),
              const SizedBox(height: 30),
              
              // Progress Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.yourProgress,
                      style: const TextStyle(
                        fontSize: AppConstants.fontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // XP Progress
                    _buildProgressBar(
                      l10n.xpToLevel(child.level + 1),
                      child.xpProgress / 1000,
                      AppColors.xpColor,
                      '${child.xpProgress}/1000',
                    ),
                    const SizedBox(height: 16),
                    
                    // Daily Goal
                    _buildProgressBar(
                      l10n.dailyGoal,
                      0.7,
                      AppColors.success,
                      '7/10 ${l10n.activities}',
                    ),
                    const SizedBox(height: 16),
                    
                    // Weekly Challenge
                    _buildProgressBar(
                      l10n.weeklyChallenge,
                      0.5,
                      AppColors.secondary,
                      '3/6',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Interests Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.yourInterests,
                      style: const TextStyle(
                        fontSize: AppConstants.fontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: child.interests.map((interest) => 
                        _buildInterestChip(interest)
                      ).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Achievements Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.recentAchievements,
                      style: const TextStyle(
                        fontSize: AppConstants.fontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildAchievementBadge('🏆', 'First Quiz', 'Completed first quiz'),
                        _buildAchievementBadge('🔥', '5 Day Streak', 'Keep it up!'),
                        _buildAchievementBadge('⭐', 'Math Master', '100% accuracy'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Settings Button
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Navigate to child settings
                },
                icon: const Icon(Icons.settings),
                label: Text(l10n.settings),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.grey,
                  foregroundColor: AppColors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Logout Button
              OutlinedButton.icon(
                onPressed: () async {
                  await ref.read(childSessionControllerProvider.notifier).endChildSession();
                  await ref.read(authControllerProvider.notifier).logout();
                  if (!context.mounted) return;
                  context.go('/welcome');
                },
                icon: const Icon(Icons.logout),
                label: Text(l10n.logout),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 25,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: AppConstants.fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(String label, double value, Color color, String valueText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              valueText,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: AppColors.lightGrey,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildInterestChip(String interest) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        interest,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAchievementBadge(String emoji, String title, String description) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.xpColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          description,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
