import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kinder_world/app.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/core/localization/app_localizations.dart';
import 'package:kinder_world/core/models/child_profile.dart';
import 'package:kinder_world/core/providers/auth_controller.dart';
import 'package:kinder_world/core/providers/child_session_controller.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/widgets/picture_password_row.dart';
import 'package:kinder_world/features/child_mode/paywall/child_paywall_screen.dart';

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

class ChildLoginScreen extends ConsumerStatefulWidget {
  const ChildLoginScreen({super.key});

  @override
  ConsumerState<ChildLoginScreen> createState() => _ChildLoginScreenState();
}

class _ChildLoginScreenState extends ConsumerState<ChildLoginScreen> {
  final TextEditingController _childIdController = TextEditingController();
  late Future<List<ChildProfile>> _childrenFuture;

  final List<String> _selectedPictures = [];
  String? _selectedChildId;
  ChildProfile? _selectedChildProfile;
  bool _isLoading = false;
  String? _error;

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

  final List<PicturePasswordOption> _pictureOptions = picturePasswordOptions;

  @override
  void initState() {
    super.initState();
    _childrenFuture = _loadChildren();
  }

  @override
  void dispose() {
    _childIdController.dispose();
    super.dispose();
  }

  Future<List<ChildProfile>> _loadChildren() async {
    return ref.read(childRepositoryProvider).getAllChildProfiles();
  }

  void _refreshChildren() {
    setState(() {
      _childrenFuture = _loadChildren();
    });
  }

  void _showError(String message) {
    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _error = message;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }

  void _resetSelection() {
    setState(() {
      _selectedChildId = null;
      _selectedChildProfile = null;
      _selectedPictures.clear();
      _error = null;
    });
  }

  void _selectChild(ChildProfile child) {
    setState(() {
      _selectedChildId = child.id;
      _selectedChildProfile = child;
      _selectedPictures.clear();
      _error = null;
    });
  }

  void _queueSelectChild(ChildProfile child) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _selectedChildId != null) return;
      _selectChild(child);
    });
  }

  void _togglePicture(String pictureId) {
    if (_isLoading) return;
    setState(() {
      if (_selectedPictures.contains(pictureId)) {
        _selectedPictures.remove(pictureId);
      } else if (_selectedPictures.length < 3) {
        _selectedPictures.add(pictureId);
      }
    });
  }

  _AvatarOption? _avatarForValue(String? value) {
    if (value == null || value.isEmpty) return null;
    for (final option in _avatarOptions) {
      if (option.id == value || option.assetPath == value) {
        return option;
      }
    }
    return null;
  }

  ChildProfile? _resolveSelectedChild(List<ChildProfile> children) {
    if (_selectedChildId == null) return null;
    if (_selectedChildProfile != null &&
        _selectedChildProfile!.id == _selectedChildId) {
      return _selectedChildProfile;
    }
    for (final child in children) {
      if (child.id == _selectedChildId) {
        return child;
      }
    }
    return null;
  }

  String _mapChildLoginError(AppLocalizations l10n, String? error) {
    switch (error) {
      case 'child_login_404':
        return l10n.childLoginNotFound;
      case 'child_login_401':
        return l10n.childLoginIncorrectPictures;
      case 'child_login_422':
        return l10n.childLoginMissingData;
      default:
        return l10n.loginError;
    }
  }

  String _mapChildRegisterError(AppLocalizations l10n, String? error) {
    switch (error) {
      case 'child_register_404':
        return l10n.childRegisterParentNotFound;
      case 'child_register_401':
        return l10n.childRegisterForbidden;
      case 'child_register_422':
        return l10n.childLoginMissingData;
      case 'child_register_limit':
        return l10n.childRegisterLimitReached;
      default:
        return l10n.registerError;
    }
  }

  Future<bool> _openPaywall() async {
    if (!mounted) return false;
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => const ChildPaywallScreen(),
      ),
    );
    return result == true;
  }

  bool _samePictures(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  List<ChildProfile> _dedupeChildren(List<ChildProfile> children) {
    final seen = <String, ChildProfile>{};
    for (final child in children) {
      if (!seen.containsKey(child.id)) {
        seen[child.id] = child;
      }
    }
    return seen.values.toList();
  }

  Future<ChildProfile?> _ensureLocalChildProfile(
    String childId,
    ChildProfile? childProfile,
  ) async {
    final repo = ref.read(childRepositoryProvider);
    final existing = childProfile ?? await repo.getChildProfile(childId);
    final selectedPassword = _selectedPictures.length == 3
        ? List<String>.from(_selectedPictures)
        : const <String>[];

    if (existing != null) {
      if (selectedPassword.isNotEmpty &&
          !_samePictures(existing.picturePassword, selectedPassword)) {
        final updated = existing.copyWith(
          picturePassword: selectedPassword,
          updatedAt: DateTime.now(),
        );
        final saved = await repo.updateChildProfile(updated);
        if (saved != null) {
          _refreshChildren();
          return saved;
        }
      }
      return existing;
    }

    final now = DateTime.now();
    final newProfile = ChildProfile(
      id: childId,
      name: (childProfile?.name.isNotEmpty ?? false)
          ? childProfile!.name
          : childId,
      age: childProfile?.age ?? 0,
      avatar: childProfile?.avatar ?? _avatarOptions.first.id,
      interests: childProfile?.interests ?? const [],
      level: childProfile?.level ?? 1,
      xp: childProfile?.xp ?? 0,
      streak: childProfile?.streak ?? 0,
      favorites: childProfile?.favorites ?? const [],
      parentId: childProfile?.parentId ?? 'local',
      parentEmail: childProfile?.parentEmail,
      picturePassword: selectedPassword,
      createdAt: childProfile?.createdAt ?? now,
      updatedAt: now,
      lastSession: childProfile?.lastSession,
      totalTimeSpent: childProfile?.totalTimeSpent ?? 0,
      activitiesCompleted: childProfile?.activitiesCompleted ?? 0,
      currentMood: childProfile?.currentMood,
      learningStyle: childProfile?.learningStyle,
      specialNeeds: childProfile?.specialNeeds,
      accessibilityNeeds: childProfile?.accessibilityNeeds,
    );

    final created = await repo.createChildProfile(newProfile);
    if (created != null) {
      _refreshChildren();
    }
    return created;
  }

  Future<void> _loginWithChildId({
    required String childId,
    ChildProfile? childProfile,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final trimmedId = childId.trim();

    if (trimmedId.isEmpty || _selectedPictures.length != 3) {
      _showError(l10n.childLoginMissingData);
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final authController = ref.read(authControllerProvider.notifier);
      final authSuccess = await authController.loginChild(
        childId: trimmedId,
        picturePassword: List<String>.from(_selectedPictures),
      );

      if (!authSuccess) {
        final authError = ref.read(authControllerProvider).error;
        _showError(_mapChildLoginError(l10n, authError));
        return;
      }

      final storedProfile =
          await _ensureLocalChildProfile(trimmedId, childProfile);
      if (storedProfile == null) {
        _showError(l10n.childProfileNotFound);
        return;
      }

      final sessionController =
          ref.read(childSessionControllerProvider.notifier);
      final sessionSuccess = await sessionController.startChildSession(
        childId: trimmedId,
        childProfile: storedProfile,
      );

      if (!sessionSuccess) {
        _showError(l10n.failedToStartSession);
        return;
      }

      if (mounted) {
        context.go('/child/home');
      }
    } catch (_) {
      _showError(l10n.loginError);
    }
  }

  Future<void> _showCreateProfileDialog(AppLocalizations l10n) async {
    final storedParentEmail =
        await ref.read(secureStorageProvider).getParentEmail();
    final parentEmailController =
        TextEditingController(text: storedParentEmail ?? '');
    final childNameController = TextEditingController();
    final messenger = ScaffoldMessenger.of(context);
    final repo = ref.read(childRepositoryProvider);
    int? age;
    String selectedAvatar = _avatarOptions.first.id;
    final selectedPassword = <String>[];
    bool nameTouched = false;
    bool emailTouched = false;
    bool passwordTouched = false;
    bool isSaving = false;

    bool isValidEmail(String value) {
      final trimmed = value.trim();
      if (trimmed.isEmpty) return false;
      return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(trimmed);
    }

    void togglePicture(
      String pictureId,
      void Function(void Function()) setDialogState,
    ) {
      if (isSaving) return;
      setDialogState(() {
        passwordTouched = true;
        if (selectedPassword.contains(pictureId)) {
          selectedPassword.remove(pictureId);
        } else if (selectedPassword.length < 3) {
          selectedPassword.add(pictureId);
        }
      });
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final childName = childNameController.text.trim();
            final parentEmail = parentEmailController.text.trim();
            final canSave = childName.isNotEmpty &&
                isValidEmail(parentEmail) &&
                selectedPassword.length == 3 &&
                !isSaving;
            final nameError =
                nameTouched && childName.isEmpty ? l10n.fieldRequired : null;
            final emailError = emailTouched && !isValidEmail(parentEmail)
                ? (parentEmail.isEmpty
                    ? l10n.fieldRequired
                    : l10n.invalidEmail)
                : null;
            final showPasswordError =
                passwordTouched && selectedPassword.length != 3;

            return AlertDialog(
              title: Text(l10n.createChildProfile),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: childNameController,
                      decoration: InputDecoration(
                        labelText: l10n.childName,
                        errorText: nameError,
                        prefixIcon: const Icon(Icons.person),
                      ),
                      textCapitalization: TextCapitalization.words,
                      onChanged: (_) => setDialogState(() {
                        nameTouched = true;
                      }),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: parentEmailController,
                      decoration: InputDecoration(
                        labelText: l10n.parentEmail,
                        errorText: emailError,
                        prefixIcon: const Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
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
                              .map(
                                (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text('$value'),
                                ),
                              )
                              .toList(),
                          onChanged: (value) => setDialogState(() {
                            age = value;
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(l10n.avatar),
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
                                child: ClipOval(
                                  child: option.assetPath.isNotEmpty
                                      ? Image.asset(
                                          option.assetPath,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Icon(
                                            option.icon,
                                            color: option.iconColor,
                                            size: 26,
                                          ),
                                        )
                                      : Icon(
                                          option.icon,
                                          color: option.iconColor,
                                          size: 26,
                                        ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(l10n.selectPicturePassword),
                    const SizedBox(height: 8),
                    PicturePasswordRow(
                      picturePassword: selectedPassword,
                      size: 22,
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
                    const SizedBox(height: 12),
                    SizedBox(
                      width: 320,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _pictureOptions.map((option) {
                          final isSelected = selectedPassword.contains(option.id);
                          return InkWell(
                            onTap: () => togglePicture(option.id, setDialogState),
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? option.color.withValues(alpha: 0.2)
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected
                                      ? option.color
                                      : AppColors.lightGrey,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                option.icon,
                                size: 26,
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
                  onPressed:
                      isSaving ? null : () => Navigator.of(dialogContext).pop(),
                  child: Text(l10n.cancel),
                ),
                ElevatedButton(
                  onPressed: canSave
                      ? () async {
                          setDialogState(() {
                            isSaving = true;
                            nameTouched = true;
                            emailTouched = true;
                            passwordTouched = true;
                          });

                          final trimmedName = childNameController.text.trim();
                          final trimmedEmail =
                              parentEmailController.text.trim();

                          if (trimmedName.isEmpty ||
                              !isValidEmail(trimmedEmail) ||
                              selectedPassword.length != 3) {
                            setDialogState(() {
                              isSaving = false;
                            });
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(l10n.childLoginMissingData),
                                backgroundColor: AppColors.error,
                              ),
                            );
                            return;
                          }

                          final authController =
                              ref.read(authControllerProvider.notifier);
                          var response = await authController.registerChild(
                            name: trimmedName,
                            picturePassword:
                                List<String>.from(selectedPassword),
                            parentEmail: trimmedEmail,
                          );

                          if (response == null &&
                              ref.read(authControllerProvider).error ==
                                  'child_register_limit') {
                            setDialogState(() {
                              isSaving = false;
                            });
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(l10n.childRegisterLimitReached),
                                backgroundColor: AppColors.error,
                              ),
                            );
                            final upgraded = await _openPaywall();
                            if (!upgraded) {
                              return;
                            }
                            if (!mounted) return;
                            setDialogState(() {
                              isSaving = true;
                            });
                            response = await authController.registerChild(
                              name: trimmedName,
                              picturePassword:
                                  List<String>.from(selectedPassword),
                              parentEmail: trimmedEmail,
                            );
                          }

                          if (response == null) {
                            setDialogState(() {
                              isSaving = false;
                            });
                            final error =
                                ref.read(authControllerProvider).error;
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(_mapChildRegisterError(l10n, error)),
                                backgroundColor: AppColors.error,
                              ),
                            );
                            return;
                          }

                          await ref
                              .read(secureStorageProvider)
                              .saveUserEmail(trimmedEmail);

                          final resolvedName = response.name?.trim().isNotEmpty ==
                                  true
                              ? response.name!.trim()
                              : trimmedName;
                          final now = DateTime.now();
                          final existing =
                              await repo.getChildProfile(response.childId);
                          final updatedProfile = (existing ??
                                  ChildProfile(
                                    id: response.childId,
                                    name: resolvedName,
                                    age: age ?? 0,
                                    avatar: selectedAvatar,
                                    interests: const [],
                                    level: 1,
                                    xp: 0,
                                    streak: 0,
                                    favorites: const [],
                                    parentId: trimmedEmail,
                                    parentEmail: trimmedEmail,
                                    picturePassword:
                                        List<String>.from(selectedPassword),
                                    createdAt: now,
                                    updatedAt: now,
                                    lastSession: null,
                                    totalTimeSpent: 0,
                                    activitiesCompleted: 0,
                                    currentMood: null,
                                    learningStyle: null,
                                    specialNeeds: null,
                                    accessibilityNeeds: null,
                                  ))
                              .copyWith(
                            name: resolvedName,
                            age: age ?? existing?.age ?? 0,
                            avatar: selectedAvatar,
                            parentId: trimmedEmail,
                            parentEmail: trimmedEmail,
                            picturePassword:
                                List<String>.from(selectedPassword),
                            updatedAt: now,
                          );

                          final saved = existing == null
                              ? await repo.createChildProfile(updatedProfile)
                              : await repo.updateChildProfile(updatedProfile);

                          if (saved == null) {
                            setDialogState(() {
                              isSaving = false;
                            });
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(l10n.childProfileAddFailed),
                                backgroundColor: AppColors.error,
                              ),
                            );
                            return;
                          }

                          if (mounted) {
                            Navigator.of(dialogContext).pop();
                            _refreshChildren();
                            _selectChild(saved);
                          }
                        }
                      : null,
                  child: isSaving
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(l10n.save),
                ),
              ],
            );
          },
        );
      },
    );

    childNameController.dispose();
    parentEmailController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: _isLoading ? null : () => context.go('/select-user-type'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                l10n.childLogin,
                style: const TextStyle(
                  fontSize: AppConstants.largeFontSize * 1.2,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.chooseProfileToContinue,
                style: const TextStyle(
                  fontSize: AppConstants.fontSize,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              FutureBuilder<List<ChildProfile>>(
                future: _childrenFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: CircularProgressIndicator(color: AppColors.primary),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return _buildErrorState(l10n);
                  }

                  final children =
                      _dedupeChildren(snapshot.data ?? const <ChildProfile>[]);
                  return _buildLoginFlow(l10n, children);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginFlow(AppLocalizations l10n, List<ChildProfile> children) {
    if (children.isEmpty) {
      return _buildManualLogin(l10n);
    }

    final selectedChild = _resolveSelectedChild(children);
    if (selectedChild == null) {
      if (_selectedChildId != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          _resetSelection();
        });
      }
      if (children.length == 1) {
        _queueSelectChild(children.first);
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        );
      }
      return _buildChildSelection(l10n, children);
    }

    return _buildSelectedChildLogin(
      l10n,
      selectedChild,
      canChangeChild: children.length > 1,
    );
  }

  Widget _buildErrorState(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.child_care_outlined,
            size: 80,
            color: AppColors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            _error ?? l10n.noChildProfilesFound,
            style: const TextStyle(
              fontSize: AppConstants.fontSize,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 220,
            height: 48,
            child: ElevatedButton(
              onPressed: _isLoading ? null : () => context.go('/select-user-type'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(l10n.goBack),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManualLogin(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.childId,
          style: const TextStyle(
            fontSize: AppConstants.fontSize,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _childIdController,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
            labelText: l10n.childId,
            prefixIcon: const Icon(Icons.badge),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_-]')),
          ],
        ),
        const SizedBox(height: 24),
        _buildPicturePasswordPicker(l10n),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _isLoading
                ? null
                : () => _loginWithChildId(childId: _childIdController.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.behavioral,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: _isLoading
                ? const CircularProgressIndicator(color: AppColors.white)
                : Text(
                    l10n.login,
                    style: const TextStyle(
                      fontSize: AppConstants.fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: _isLoading ? null : () => _showCreateProfileDialog(l10n),
            icon: const Icon(Icons.add),
            label: Text(l10n.createChildProfile),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChildSelection(AppLocalizations l10n, List<ChildProfile> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.chooseYourProfile,
          style: const TextStyle(
            fontSize: AppConstants.fontSize,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            ...children.map((child) => _buildChildCard(child, l10n)),
            _buildCreateProfileCard(l10n),
          ],
        ),
      ],
    );
  }

  Widget _buildSelectedChildLogin(
    AppLocalizations l10n,
    ChildProfile child, {
    required bool canChangeChild,
  }) {
    final fallback = child.name.isNotEmpty ? child.name[0] : '?';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              _buildAvatarCircle(
                avatar: child.avatar,
                fallback: fallback,
                size: 50,
                backgroundColor: AppColors.primary,
                textColor: AppColors.white,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      child.name.isNotEmpty ? child.name : child.id,
                      style: const TextStyle(
                        fontSize: AppConstants.fontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (child.age > 0)
                      Text(
                        l10n.yearsOld(child.age),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              if (canChangeChild)
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textSecondary),
                  onPressed: _isLoading ? null : _resetSelection,
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildPicturePasswordPicker(l10n),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _isLoading
                ? null
                : () => _loginWithChildId(
                      childId: child.id,
                      childProfile: child,
                    ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.behavioral,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: _isLoading
                ? const CircularProgressIndicator(color: AppColors.white)
                : Text(
                    l10n.login,
                    style: const TextStyle(
                      fontSize: AppConstants.fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildPicturePasswordPicker(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.selectPicturePassword,
          style: const TextStyle(
            fontSize: AppConstants.fontSize,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        PicturePasswordRow(
          picturePassword: _selectedPictures,
          size: 20,
          showPlaceholders: true,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _pictureOptions.length,
          itemBuilder: (context, index) {
            final option = _pictureOptions[index];
            final isSelected = _selectedPictures.contains(option.id);
            return InkWell(
              onTap: () => _togglePicture(option.id),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      isSelected ? option.color.withValues(alpha: 0.2) : AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? option.color : AppColors.lightGrey,
                    width: 2,
                  ),
                ),
                child: Icon(
                  option.icon,
                  size: 28,
                  color: option.color,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAvatarCircle({
    required String? avatar,
    required String fallback,
    required double size,
    required Color backgroundColor,
    required Color textColor,
  }) {
    final fallbackWidget = Center(
      child: Text(
        fallback,
        style: TextStyle(
          fontSize: size * 0.45,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );

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

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: ClipOval(
        child: avatar != null && avatar.isNotEmpty && avatar.startsWith('assets/')
            ? Image.asset(
                avatar,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => fallbackWidget,
              )
            : fallbackWidget,
      ),
    );
  }

  Widget _buildChildCard(ChildProfile child, AppLocalizations l10n) {
    final isSelected = _selectedChildId == child.id;

    return InkWell(
      onTap: _isLoading ? null : () => _selectChild(child),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.lightGrey,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            _buildAvatarCircle(
              avatar: child.avatar,
              fallback: child.name.isNotEmpty ? child.name[0] : '?',
              size: 64,
              backgroundColor: AppColors.behavioral.withValues(alpha: 0.2),
              textColor: AppColors.behavioral,
            ),
            const SizedBox(height: 12),
            Text(
              child.name.isNotEmpty ? child.name : child.id,
              style: const TextStyle(
                fontSize: AppConstants.fontSize,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            if (child.age > 0) ...[
              const SizedBox(height: 4),
              Text(
                l10n.yearsOld(child.age),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.xpColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${l10n.level} ${child.level}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.xpColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateProfileCard(AppLocalizations l10n) {
    return InkWell(
      onTap: _isLoading ? null : () => _showCreateProfileDialog(l10n),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: AppColors.primary),
              ),
              child: const Icon(
                Icons.add,
                color: AppColors.primary,
                size: 30,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.createChildProfile,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
