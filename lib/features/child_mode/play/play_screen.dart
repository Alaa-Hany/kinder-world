import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/constants/app_constants.dart';

class PlayScreen extends ConsumerWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const SizedBox(height: 20),
              Text(
                'Play & Fun',
                style: TextStyle(
                  fontSize: AppConstants.largeFontSize * 1.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enjoy games, stories, and entertainment!',
                style: TextStyle(
                  fontSize: AppConstants.fontSize,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              
              // Game Categories
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildGameCard(
                      'Educational Games',
                      Icons.games,
                      AppColors.entertaining,
                      'Fun learning games',
                    ),
                    _buildGameCard(
                      'Interactive Stories',
                      Icons.book,
                      AppColors.behavioral,
                      'Choose your adventure',
                    ),
                    _buildGameCard(
                      'Music & Songs',
                      Icons.music_note,
                      AppColors.skillful,
                      'Sing and dance',
                    ),
                    _buildGameCard(
                      'Puzzle Games',
                      Icons.extension,
                      AppColors.educational,
                      'Challenge your mind',
                    ),
                    _buildGameCard(
                      'Creative Corner',
                      Icons.palette,
                      AppColors.skillful,
                      'Draw and create',
                    ),
                    _buildGameCard(
                      'Nature Videos',
                      Icons.nature,
                      AppColors.success,
                      'Explore the world',
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

  Widget _buildGameCard(String title, IconData icon, Color color, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 30,
              color: color,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: AppConstants.fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}