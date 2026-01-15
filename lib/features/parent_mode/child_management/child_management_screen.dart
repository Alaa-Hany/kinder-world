import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/app.dart';
import 'package:kinder_world/core/localization/app_localizations.dart';
import 'package:kinder_world/core/models/child_profile.dart';
import 'package:kinder_world/core/providers/auth_controller.dart';
import 'package:kinder_world/core/providers/child_session_controller.dart';
import 'package:kinder_world/core/widgets/picture_password_row.dart';

class _AvatarOption {
  final String id;
  final String assetPath;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const _AvatarOption({
    required this.id,
    required this.assetPath,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });
}

class ChildManagementScreen extends ConsumerStatefulWidget {
  const ChildManagementScreen({super.key});

  @override
  ConsumerState<ChildManagementScreen> createState() =>
      _ChildManagementScreenState();
}

class _ChildManagementScreenState
    extends ConsumerState<ChildManagementScreen> {
  final List<_AvatarOption> _avatarOptions = const [
    _AvatarOption(
      id: 'avatar_1',
      assetPath: 'assets/images/avatars/boy1.png',
      icon: Icons.face,
      backgroundColor: Color(0xFFE3F2FD),
      iconColor: Color(0xFF1E88E5),
    ),
    _AvatarOption(
      id: 'avatar_2',
      assetPath: 'assets/images/avatars/boy2.png',
      icon: Icons.sentiment_satisfied,
      backgroundColor: Color(0xFFF3E5F5),
      iconColor: Color(0xFF8E24AA),
    ),
    _AvatarOption(
      id: 'avatar_3',
      assetPath: 'assets/images/avatars/girl1.png',
      icon: Icons.sentiment_very_satisfied,
      backgroundColor: Color(0xFFE8F5E9),
      iconColor: Color(0xFF43A047),
    ),
    _AvatarOption(
      id: 'avatar_4',
      assetPath: 'assets/images/avatars/girl2.png',
      icon: Icons.star,
      backgroundColor: Color(0xFFFFF3E0),
      iconColor: Color(0xFFFB8C00),
    ),
  ];

  _AvatarOption? _avatarForValue(String? value) {
    if (value == null || value.isEmpty) return null;
    for (final option in _avatarOptions) {
      if (option.id == value || option.assetPath == value) {
        return option;
      }
    }
    return null;
  }

  Widget _buildAvatarCircle({
    required String? avatar,
    required String fallback,
    required double size,
  }) {
    final option = _avatarForValue(avatar);
    if (option != null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: option.backgroundColor,
          borderRadius: BorderRadius.circular(size / 2),
        ),
        child: ClipOval(
          child: option.assetPath.isNotEmpty
              ? Image.asset(
                  option.assetPath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Center(
                    child: Icon(
                      option.icon,
                      color: option.iconColor,
                      size: size * 0.5,
                    ),
                  ),
                )
              : Center(
                  child: Icon(
                    option.icon,
                    color: option.iconColor,
                    size: size * 0.5,
                  ),
                ),
        ),
      );
    }

    if (avatar != null && avatar.startsWith('assets/')) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(size / 2),
        ),
        child: ClipOval(
          child: Image.asset(
            avatar,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Center(
              child: Text(
                fallback,
                style: TextStyle(
                  fontSize: size * 0.45,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Center(
        child: Text(
          fallback,
          style: TextStyle(
            fontSize: size * 0.45,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    final parentId = parentIdSnapshot.data ?? '';
                    return FutureBuilder<List<ChildProfile>>(
                      future: ref
                          .read(childRepositoryProvider)
                          .getChildProfilesForParent(parentId),
                      builder: (context, childrenSnapshot) {
                        final repoChildren = childrenSnapshot.data ?? [];
                        final children = repoChildren;

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
          final parentContext = context;
          final messenger = ScaffoldMessenger.of(parentContext);
          final storedParentEmail =
              await ref.read(secureStorageProvider).getParentEmail();
          final authEmail = ref.read(authControllerProvider).user?.email;
          final fallbackEmail =
              authEmail != null && authEmail != 'user@example.com'
                  ? authEmail
                  : null;
          String? normalizeParentEmail(String? value) {
            final trimmed = value?.trim();
            if (trimmed == null ||
                trimmed.isEmpty ||
                trimmed == 'user@example.com') {
              return null;
            }
            return trimmed;
          }

          final knownParentEmail = normalizeParentEmail(fallbackEmail) ??
              normalizeParentEmail(storedParentEmail);
          final parentEmailController = TextEditingController(
            text: knownParentEmail ?? '',
          );
          String name = '';
          int? age;
          String selectedAvatar = _avatarOptions.first.id;
          final List<String> picturePassword = [];
          bool emailTouched = false;
          bool passwordTouched = false;

          bool isValidEmail(String value) {
            final trimmed = value.trim();
            if (trimmed.isEmpty) return false;
            return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                .hasMatch(trimmed);
          }

          await showDialog<void>(
            context: parentContext,
            builder: (dialogContext) {
              return StatefulBuilder(
                builder: (context, setDialogState) {
                  final emailValue = parentEmailController.text.trim();
                  final emailValid = isValidEmail(emailValue);
                  final matchesKnownParent = knownParentEmail != null &&
                      knownParentEmail!.isNotEmpty &&
                      emailValue.toLowerCase() ==
                          knownParentEmail!.toLowerCase();
                  final canSave =
                      name.trim().isNotEmpty &&
                      age != null &&
                      emailValid &&
                      matchesKnownParent &&
                      picturePassword.length == 3;
                  final String? emailError = emailTouched
                      ? (emailValue.isEmpty
                          ? l10n.fieldRequired
                          : (!emailValid
                              ? l10n.invalidEmail
                              : (matchesKnownParent
                                  ? null
                                  : l10n.parentEmailNotFound)))
                      : null;
                  final showPasswordError =
                      passwordTouched && picturePassword.length != 3;
                  void togglePicture(String pictureId) {
                    setDialogState(() {
                      passwordTouched = true;
                      if (picturePassword.contains(pictureId)) {
                        picturePassword.remove(pictureId);
                      } else if (picturePassword.length < 3) {
                        picturePassword.add(pictureId);
                      }
                    });
                  }
                  return AlertDialog(
                    title: Text(l10n.addChild),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(labelText: l10n.childName),
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.name,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r"[a-zA-Z\u0600-\u06FF\s'-]"),
                              ),
                            ],
                            onChanged: (v) => setDialogState(() {
                              name = v;
                            }),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: parentEmailController,
                            decoration: InputDecoration(
                              labelText: l10n.parentEmail,
                              errorText: emailError,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            autocorrect: false,
                            enableSuggestions: false,
                            onChanged: (_) => setDialogState(() {
                              emailTouched = true;
                            }),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Text('${l10n.childAge}:'),
                              const SizedBox(width: 12),
                              DropdownButton<int>(
                                value: age,
                                hint: const Text('-'),
                                items: List.generate(12, (i) => i + 3)
                                    .map((v) => DropdownMenuItem(
                                          value: v,
                                          child: Text('$v'),
                                        ))
                                    .toList(),
                                onChanged: (v) => setDialogState(() {
                                  age = v;
                                }),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(l10n.avatar),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 320,
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _avatarOptions.map((option) {
                                final isSelected = selectedAvatar == option.id;
                                return InkWell(
                                  onTap: () {
                                    setDialogState(() {
                                      selectedAvatar = option.id;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primary.withValues(alpha: 0.2)
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.primary
                                            : AppColors.lightGrey,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: _buildAvatarOption(option),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(l10n.selectPicturePassword),
                          ),
                          const SizedBox(height: 8),
                          PicturePasswordRow(
                            picturePassword: picturePassword,
                            size: 20,
                            showPlaceholders: true,
                          ),
                          if (showPasswordError) ...[
                            const SizedBox(height: 6),
                            Text(
                              l10n.picturePasswordError,
                              style: const TextStyle(
                                color: AppColors.error,
                                fontSize: 12,
                              ),
                            ),
                          ],
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 320,
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: picturePasswordOptions.map((option) {
                                final isSelected =
                                    picturePassword.contains(option.id);
                                return InkWell(
                                  onTap: () => togglePicture(option.id),
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? option.color.withValues(alpha: 0.2)
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? option.color
                                            : AppColors.lightGrey,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      option.icon,
                                      size: 24,
                                      color: option.color,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(l10n.cancel),
                      ),
                      ElevatedButton(
                        onPressed: canSave
                            ? () async {
                                if (!isValidEmail(
                                    parentEmailController.text.trim())) {
                                  setDialogState(() {
                                    emailTouched = true;
                                  });
                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.invalidEmail),
                                      backgroundColor: AppColors.error,
                                    ),
                                  );
                                  return;
                                }
                                final normalizedKnownEmail =
                                    knownParentEmail?.trim();
                                if (normalizedKnownEmail == null ||
                                    normalizedKnownEmail.isEmpty ||
                                    normalizedKnownEmail.toLowerCase() !=
                                        parentEmailController.text
                                            .trim()
                                            .toLowerCase()) {
                                  setDialogState(() {
                                    emailTouched = true;
                                  });
                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.parentEmailNotFound),
                                      backgroundColor: AppColors.error,
                                    ),
                                  );
                                  return;
                                }
                                Navigator.of(dialogContext).pop();
                                final parentEmail =
                                    parentEmailController.text.trim();
                                await ref
                                    .read(secureStorageProvider)
                                    .saveUserEmail(parentEmail);
                                final parentId = await ref
                                    .read(secureStorageProvider)
                                    .getParentId();
                                final newProfile = ChildProfile(
                                  id: 'child_${DateTime.now().millisecondsSinceEpoch}',
                                  name: name.trim(),
                                  age: age!,
                                  avatar: selectedAvatar,
                                  interests: [],
                                  level: 1,
                                  xp: 0,
                                  streak: 0,
                                  favorites: [],
                                  parentId: parentId ?? parentEmail,
                                  parentEmail: parentEmail,
                                  picturePassword:
                                      List<String>.from(picturePassword),
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now(),
                                  totalTimeSpent: 0,
                                  activitiesCompleted: 0,
                                  currentMood: 'happy',
                                );

                                final created = await ref
                                    .read(childRepositoryProvider)
                                    .createChildProfile(newProfile);

                                if (!mounted) {
                                  return;
                                }

                                if (created != null) {
                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.childProfileAdded),
                                    ),
                                  );
                                } else {
                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.childProfileAddFailed),
                                    ),
                                  );
                                }
                                if (!mounted) {
                                  return;
                                }
                                setState(() {});
                              }
                            : null,
                        child: Text(l10n.addChild),
                      ),
                    ],
                  );
                },
              );
            },
          );
          parentEmailController.dispose();
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildChildCard(ChildProfile child) {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () => context.push('/parent/child-profile', extra: child),
      borderRadius: BorderRadius.circular(20),
      child: Container(
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildAvatarCircle(
                  avatar: child.avatar,
                  fallback: child.name.isNotEmpty ? child.name[0] : '?',
                  size: 60,
                ),
                const SizedBox(height: 6),
                PicturePasswordRow(
                  picturePassword: child.picturePassword,
                  size: 14,
                  showPlaceholders: true,
                ),
              ],
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
                    '${l10n.yearsOld(child.age)} - ${l10n.level} ${child.level}',
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
                        '${child.activitiesCompleted} ${l10n.activities}',
                        AppColors.success,
                      ),
                      _buildInfoChip(
                        '${child.totalTimeSpent} ${l10n.timeSpent}',
                        AppColors.info,
                      ),
                      _buildInfoChip(
                        '${child.streak} ${l10n.dailyStreak}',
                        AppColors.streakColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                const SizedBox(height: 8),
                Tooltip(
                  message: l10n.activityReports,
                  child: IconButton(
                    onPressed: () =>
                        context.push('/parent/reports', extra: child.id),
                    icon: const Icon(Icons.pie_chart),
                    color: AppColors.primary,
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints.tightFor(
                      width: 32,
                      height: 32,
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
          ],
        ),
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

  Widget _buildAvatarOption(_AvatarOption option) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: option.backgroundColor,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: option.assetPath.isNotEmpty
            ? Image.asset(
                option.assetPath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Center(
                  child: Icon(
                    option.icon,
                    color: option.iconColor,
                    size: 24,
                  ),
                ),
              )
            : Center(
                child: Icon(
                  option.icon,
                  color: option.iconColor,
                  size: 24,
                ),
              ),
      ),
    );
  }
}
