import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/core/models/activity.dart';
import 'package:kinder_world/core/providers/content_controller.dart';
import 'package:kinder_world/core/providers/child_session_controller.dart';

class LearnScreen extends ConsumerStatefulWidget {
  const LearnScreen({super.key});

  @override
  ConsumerState<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends ConsumerState<LearnScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  
  String _selectedAspect = ActivityAspects.educational;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    
    _slideAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    
    _controller.forward();

    // Load activities when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(contentControllerProvider.notifier).loadAllActivities();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contentState = ref.watch(contentControllerProvider);
    final activities = contentState.activities;
    final filteredActivities = activities.where(
      (activity) => activity.aspect == _selectedAspect
    ).toList();
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _slideAnimation.value,
          child: child,
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Learn',
                      style: TextStyle(
                        fontSize: AppConstants.largeFontSize * 1.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Choose what you want to learn today!',
                      style: TextStyle(
                        fontSize: AppConstants.fontSize,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Aspect Tabs
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: ActivityAspects.all.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final aspect = ActivityAspects.all[index];
                    final isSelected = aspect == _selectedAspect;
                    final color = _getAspectColor(aspect);
                    
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedAspect = aspect;
                        });
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? color : AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? color : AppColors.lightGrey,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _getAspectIcon(aspect),
                              size: 20,
                              color: isSelected ? AppColors.white : color,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              ActivityAspects.getDisplayName(aspect),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                color: isSelected ? AppColors.white : AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Activities Grid
              Expanded(
                child: contentState.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: AppColors.primary),
                      )
                    : contentState.error != null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 64,
                                  color: AppColors.error,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  contentState.error!,
                                  style: TextStyle(
                                    fontSize: AppConstants.fontSize,
                                    color: AppColors.textSecondary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    ref.read(contentControllerProvider.notifier).loadAllActivities();
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          )
                        : filteredActivities.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.school_outlined,
                                      size: 64,
                                      color: AppColors.grey,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No activities available',
                                      style: TextStyle(
                                        fontSize: AppConstants.fontSize,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : GridView.builder(
                                padding: const EdgeInsets.all(16),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 0.85,
                                ),
                                itemCount: filteredActivities.length,
                                itemBuilder: (context, index) {
                                  final activity = filteredActivities[index];
                                  return _buildActivityCard(activity);
                                },
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard(Activity activity) {
    final color = _getAspectColor(activity.aspect);
    
    return GestureDetector(
      onTap: () {
        context.go('/child/learn/lesson/${activity.id}');
      },
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Activity thumbnail
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Center(
                child: Icon(
                  _getCategoryIcon(activity.category),
                  size: 50,
                  color: color,
                ),
              ),
            ),
            
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      activity.title,
                      style: TextStyle(
                        fontSize: AppConstants.fontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    
                    // Description
                    Text(
                      activity.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    
                    // Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // XP
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.xpColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.star, size: 12, color: AppColors.xpColor),
                              const SizedBox(width: 4),
                              Text(
                                '${activity.xpReward} XP',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.xpColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Duration
                        Text(
                          '${activity.duration} min',
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
            ),
          ],
        ),
      ),
    );
  }

  Color _getAspectColor(String aspect) {
    switch (aspect) {
      case ActivityAspects.behavioral:
        return AppColors.behavioral;
      case ActivityAspects.skillful:
        return AppColors.skillful;
      case ActivityAspects.educational:
        return AppColors.educational;
      case ActivityAspects.entertaining:
        return AppColors.entertaining;
      default:
        return AppColors.primary;
    }
  }

  IconData _getAspectIcon(String aspect) {
    switch (aspect) {
      case ActivityAspects.behavioral:
        return Icons.psychology;
      case ActivityAspects.skillful:
        return Icons.handyman;
      case ActivityAspects.educational:
        return Icons.school;
      case ActivityAspects.entertaining:
        return Icons.games;
      default:
        return Icons.star;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case ActivityCategories.mathematics:
        return Icons.calculate;
      case ActivityCategories.science:
        return Icons.science;
      case ActivityCategories.reading:
        return Icons.book;
      case ActivityCategories.socialSkills:
        return Icons.people;
      case ActivityCategories.creativity:
        return Icons.palette;
      case ActivityCategories.music:
        return Icons.music_note;
      default:
        return Icons.star;
    }
  }
}