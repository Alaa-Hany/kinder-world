import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/app.dart';
import 'package:kinder_world/core/localization/app_localizations.dart';
import 'package:kinder_world/core/models/child_profile.dart';
import 'package:kinder_world/core/providers/child_session_controller.dart';

class ChildManagementScreen extends ConsumerWidget {
  const ChildManagementScreen({super.key});

  List<ChildProfile> _demoChildren(String parentId) {
    final now = DateTime.now();
    return [
      ChildProfile(
        id: 'demo_child_1',
        name: 'Lina',
        age: 7,
        avatar: 'assets/images/avatars/girl1.png',
        interests: const ['reading', 'science'],
        level: 1,
        xp: 120,
        streak: 0,
        favorites: const [],
        parentId: parentId,
        picturePassword: const ['apple', 'ball', 'cat'],
        createdAt: now,
        updatedAt: now,
        lastSession: null,
        totalTimeSpent: 0,
        activitiesCompleted: 0,
        currentMood: 'happy',
        learningStyle: null,
        specialNeeds: null,
        accessibilityNeeds: null,
      ),
      ChildProfile(
        id: 'demo_child_2',
        name: 'Omar',
        age: 6,
        avatar: 'assets/images/avatars/boy1.png',
        interests: const ['games', 'music'],
        level: 1,
        xp: 90,
        streak: 0,
        favorites: const [],
        parentId: parentId,
        picturePassword: const ['dog', 'fish', 'kite'],
        createdAt: now,
        updatedAt: now,
        lastSession: null,
        totalTimeSpent: 0,
        activitiesCompleted: 0,
        currentMood: 'happy',
        learningStyle: null,
        specialNeeds: null,
        accessibilityNeeds: null,
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.childManagement),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: FutureBuilder<String?>(
                  future: ref.read(secureStorageProvider).getParentId(),
                  builder: (context, parentIdSnapshot) {
                    final parentId = parentIdSnapshot.data ?? 'demo-parent';
                    return FutureBuilder<List<ChildProfile>>(
                      future: ref
                          .read(childRepositoryProvider)
                          .getChildProfilesForParent(parentId),
                      builder: (context, childrenSnapshot) {
                        final repoChildren = childrenSnapshot.data ?? [];
                        final children = repoChildren.isEmpty
                            ? _demoChildren(parentId)
                            : repoChildren;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              l10n.manageChildProfiles,
                              style: const TextStyle(
                                fontSize: AppConstants.largeFontSize,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n.addEditManageChildren,
                              style: const TextStyle(
                                fontSize: AppConstants.fontSize,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              l10n.yourChildren,
                              style: const TextStyle(
                                fontSize: AppConstants.fontSize,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (children.isEmpty)
                              Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.child_care,
                                      size: 80,
                                      color: AppColors.primary.withValues(alpha: 0.3),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      l10n.noChildProfilesYet,
                                      style: const TextStyle(
                                        fontSize: AppConstants.fontSize,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      l10n.tapToAddChild,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else
                              Column(
                                children:
                                    children.map(_buildChildCard).toList(),
                              ),
                            const SizedBox(height: 24),
                            Text(
                              l10n.childProfiles,
                              style: const TextStyle(
                                fontSize: AppConstants.fontSize,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildFeatureItem(Icons.person_add, l10n.addChildProfiles),
                            _buildFeatureItem(Icons.edit, l10n.editProfiles),
                            _buildFeatureItem(Icons.lock, l10n.picturePasswords),
                            _buildFeatureItem(Icons.settings, l10n.configurePreferences),
                            _buildFeatureItem(Icons.delete, l10n.deactivateProfiles),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String name = '';
          int age = 6;

          await showDialog<void>(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    title: const Text('Add Child'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: const InputDecoration(labelText: 'Name'),
                          onChanged: (v) => name = v,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text('Age:'),
                            const SizedBox(width: 12),
                            DropdownButton<int>(
                              value: age,
                              items: List.generate(12, (i) => i + 3).map((v) => DropdownMenuItem(value: v, child: Text('$v'))).toList(),
                              onChanged: (v) => setState(() {
                                age = v ?? age;
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                              onPressed: name.trim().isEmpty
                                  ? null
                                  : () async {
                                      Navigator.of(context).pop();
                                      final parentId =
                                          await ref.read(secureStorageProvider).getParentId();
                                      final newProfile = ChildProfile(
                                        id: 'child_${DateTime.now().millisecondsSinceEpoch}',
                                        name: name.trim(),
                                        age: age,
                                        avatar: 'assets/images/avatars/boy1.png',
                                        interests: [],
                                        level: 1,
                                        xp: 0,
                                        streak: 0,
                                        favorites: [],
                                        parentId: parentId ?? 'demo-parent',
                                        picturePassword: [],
                                        createdAt: DateTime.now(),
                                        updatedAt: DateTime.now(),
                                        totalTimeSpent: 0,
                                        activitiesCompleted: 0,
                                  currentMood: 'happy',
                                );

                                final created = await ref.read(childRepositoryProvider).createChildProfile(newProfile);

                                if (!context.mounted) {
                                  return;
                                }

                                if (created != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Child profile added')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Failed to add child')),
                                  );
                                }
                              },
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildChildCard(ChildProfile child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                child.name.isNotEmpty ? child.name[0] : '?',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  child.name,
                  style: const TextStyle(
                    fontSize: AppConstants.fontSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${child.age} years old - Level ${child.level}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildInfoChip(
                      '${child.activitiesCompleted} activities',
                      AppColors.success,
                    ),
                    _buildInfoChip(
                      '${child.totalTimeSpent} min today',
                      AppColors.info,
                    ),
                    _buildInfoChip(
                      '${child.streak} day streak',
                      AppColors.streakColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              MoodTypes.getEmoji(child.currentMood ?? MoodTypes.happy),
              style: const TextStyle(fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
