import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/localization/app_localizations.dart';
import 'package:kinder_world/core/models/privacy_settings.dart';
import 'package:kinder_world/core/providers/privacy_provider.dart';

class ParentPrivacySettingsScreen extends ConsumerStatefulWidget {
  const ParentPrivacySettingsScreen({super.key});

  @override
  ConsumerState<ParentPrivacySettingsScreen> createState() =>
      _ParentPrivacySettingsScreenState();
}

class _ParentPrivacySettingsScreenState
    extends ConsumerState<ParentPrivacySettingsScreen> {
  Timer? _debounceTimer;
  PrivacySettings? _currentSettings;
  PrivacySettings? _lastKnownSettings;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onToggle(PrivacySettings Function(PrivacySettings) updater) {
    final rollback = _lastKnownSettings ?? _currentSettings;
    if (_currentSettings == null || rollback == null) return;

    final updated = updater(_currentSettings!);
    setState(() {
      _currentSettings = updated;
    });

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      final success = await ref
          .read(privacyControllerProvider.notifier)
          .updateSettings(updated);
      if (!mounted) return;

      if (success) {
        _lastKnownSettings = updated;
        ref.invalidate(privacyProvider);
      } else {
        setState(() {
          _currentSettings = rollback;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update privacy settings'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final privacyState = ref.watch(privacyProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.parentPrivacySettings ?? 'Privacy Settings'),
        elevation: 0,
      ),
      body: privacyState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Unable to load privacy settings'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(privacyProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (settings) {
          _lastKnownSettings = settings;
          _currentSettings ??= settings;
          final displaySettings = _currentSettings!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                SwitchListTile(
                  title: const Text('Analytics'),
                  subtitle:
                      const Text('Help improve Kinder World with usage data'),
                  value: displaySettings.analyticsEnabled,
                  onChanged: (value) => _onToggle(
                    (prev) => prev.copyWith(analyticsEnabled: value),
                  ),
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('Personalized recommendations'),
                  subtitle:
                      const Text('Receive customized content suggestions'),
                  value: displaySettings.personalizedRecommendations,
                  onChanged: (value) => _onToggle(
                    (prev) => prev.copyWith(personalizedRecommendations: value),
                  ),
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('Opt-out of data collection'),
                  subtitle: const Text('Pause data collection across the app'),
                  value: displaySettings.dataCollectionOptOut,
                  onChanged: (value) => _onToggle(
                    (prev) => prev.copyWith(dataCollectionOptOut: value),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(color: Colors.blue[200]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Privacy Information',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your privacy is important to us. These toggles control usage data collection.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
