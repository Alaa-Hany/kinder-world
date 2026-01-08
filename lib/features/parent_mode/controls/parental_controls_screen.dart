import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/constants/app_constants.dart';

class ParentalControlsScreen extends ConsumerWidget {
  const ParentalControlsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Parental Controls'),
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
                'Content Restrictions & Screen Time',
                style: TextStyle(
                  fontSize: AppConstants.largeFontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage what your child can access and for how long',
                style: TextStyle(
                  fontSize: AppConstants.fontSize,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              
              _buildControlSection(
                'Screen Time Limits',
                Icons.timer,
                [
                  _buildToggleSetting('Daily Limit', true),
                  _buildSliderSetting('Hours per day', 2, 0, 6),
                  _buildToggleSetting('Break Reminders', true),
                ],
              ),
              
              const SizedBox(height: 24),
              
              _buildControlSection(
                'Content Filtering',
                Icons.filter_list,
                [
                  _buildToggleSetting('Age-Appropriate Only', true),
                  _buildToggleSetting('Block Educational Content', false),
                  _buildToggleSetting('Require Approval', false),
                ],
              ),
              
              const SizedBox(height: 24),
              
              _buildControlSection(
                'Time Restrictions',
                Icons.access_time,
                [
                  _buildToggleSetting('Sleep Mode', true),
                  _buildTimeSetting('Bedtime', '8:00 PM'),
                  _buildTimeSetting('Wake Time', '7:00 AM'),
                ],
              ),
              
              const SizedBox(height: 40),
              
              // Emergency Controls
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.error.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Emergency Controls',
                      style: TextStyle(
                        fontSize: AppConstants.fontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement emergency lock
                      },
                      icon: const Icon(Icons.lock),
                      label: const Text('Lock App Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: AppColors.white,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlSection(String title, IconData icon, List<Widget> controls) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: AppConstants.fontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...controls,
        ],
      ),
    );
  }

  Widget _buildToggleSetting(String title, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppConstants.fontSize,
              color: AppColors.textPrimary,
            ),
          ),
          Switch(
            value: value,
            onChanged: (newValue) {
              // TODO: Implement setting change
            },
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSetting(String title, double value, double min, double max) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppConstants.fontSize,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Slider(
            value: value,
            min: min,
            max: max,
            onChanged: (newValue) {
              // TODO: Implement setting change
            },
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSetting(String title, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppConstants.fontSize,
              color: AppColors.textPrimary,
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement time picker
            },
            child: Text(
              time,
              style: TextStyle(
                fontSize: AppConstants.fontSize,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}