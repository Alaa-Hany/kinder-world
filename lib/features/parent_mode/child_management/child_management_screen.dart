import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/constants/app_constants.dart';

class ChildManagementScreen extends ConsumerWidget {
  const ChildManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Child Management'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Manage Child Profiles',
                style: TextStyle(
                  fontSize: AppConstants.largeFontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Add, edit, or manage your children\'s profiles',
                style: TextStyle(
                  fontSize: AppConstants.fontSize,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.child_care,
                      size: 100,
                      color: AppColors.primary.withOpacity(0.3),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Child Management Features',
                      style: TextStyle(
                        fontSize: AppConstants.fontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'This screen allows parents to:',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    _buildFeatureItem(Icons.person_add, 'Add new child profiles'),
                    _buildFeatureItem(Icons.edit, 'Edit existing profiles'),
                    _buildFeatureItem(Icons.lock, 'Set picture passwords'),
                    _buildFeatureItem(Icons.settings, 'Configure preferences'),
                    _buildFeatureItem(Icons.delete, 'Deactivate profiles'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add child
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
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
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}