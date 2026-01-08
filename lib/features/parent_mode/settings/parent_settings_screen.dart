import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/constants/app_constants.dart';

class ParentSettingsScreen extends ConsumerWidget {
  const ParentSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const SizedBox(height: 8),
            
            // Account Section
            _buildSectionHeader('Account'),
            _buildSettingItem(
              'Profile',
              Icons.person,
              onTap: () {
                // TODO: Navigate to profile settings
              },
            ),
            _buildSettingItem(
              'Change Password',
              Icons.lock,
              onTap: () {
                // TODO: Navigate to password change
              },
            ),
            _buildSettingItem(
              'Notifications',
              Icons.notifications,
              onTap: () {
                // TODO: Navigate to notification settings
              },
            ),
            
            const SizedBox(height: 24),
            
            // Family Section
            _buildSectionHeader('Family'),
            _buildSettingItem(
              'Child Profiles',
              Icons.child_care,
              onTap: () {
                context.go('/parent/child-management');
              },
            ),
            _buildSettingItem(
              'Subscription',
              Icons.payment,
              onTap: () {
                context.go('/parent/subscription');
              },
            ),
            _buildSettingItem(
              'Parental Controls',
              Icons.security,
              onTap: () {
                context.go('/parent/controls');
              },
            ),
            
            const SizedBox(height: 24),
            
            // Preferences Section
            _buildSectionHeader('Preferences'),
            _buildSettingItem(
              'Language',
              Icons.language,
              onTap: () {
                // TODO: Navigate to language settings
              },
            ),
            _buildSettingItem(
              'Theme',
              Icons.palette,
              onTap: () {
                // TODO: Navigate to theme settings
              },
            ),
            _buildSettingItem(
              'Privacy Settings',
              Icons.privacy_tip,
              onTap: () {
                // TODO: Navigate to privacy settings
              },
            ),
            
            const SizedBox(height: 24),
            
            // Support Section
            _buildSectionHeader('Support'),
            _buildSettingItem(
              'Help & FAQ',
              Icons.help,
              onTap: () {
                // TODO: Navigate to help
              },
            ),
            _buildSettingItem(
              'Contact Us',
              Icons.contact_mail,
              onTap: () {
                // TODO: Navigate to contact
              },
            ),
            _buildSettingItem(
              'About',
              Icons.info,
              onTap: () {
                // TODO: Navigate to about
              },
            ),
            
            const SizedBox(height: 24),
            
            // Legal Section
            _buildSectionHeader('Legal'),
            _buildSettingItem(
              'Terms of Service',
              Icons.description,
              onTap: () {
                // TODO: Navigate to terms
              },
            ),
            _buildSettingItem(
              'Privacy Policy',
              Icons.security,
              onTap: () {
                // TODO: Navigate to privacy policy
              },
            ),
            _buildSettingItem(
              'COPPA Compliance',
              Icons.child_care,
              onTap: () {
                // TODO: Navigate to COPPA info
              },
            ),
            
            const SizedBox(height: 40),
            
            // Logout Button
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement logout
                context.go('/welcome');
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: AppConstants.fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildSettingItem(String title, IconData icon, {VoidCallback? onTap}) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: AppConstants.fontSize,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.grey),
      onTap: onTap,
    );
  }
}