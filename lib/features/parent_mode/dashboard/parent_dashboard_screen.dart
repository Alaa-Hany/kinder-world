import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/core/models/child_profile.dart';
import 'package:fl_chart/fl_chart.dart';

class ParentDashboardScreen extends ConsumerStatefulWidget {
  const ParentDashboardScreen({super.key});

  @override
  ConsumerState<ParentDashboardScreen> createState() => _ParentDashboardScreenState();
}

class _ParentDashboardScreenState extends ConsumerState<ParentDashboardScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  // Mock child profiles
  final List<ChildProfile> _children = [
    ChildProfile(
      id: 'child1',
      name: 'Ahmed',
      age: 8,
      avatar: 'assets/images/avatars/boy1.png',
      interests: ['math', 'science'],
      level: 3,
      xp: 2500,
      streak: 5,
      favorites: ['activity1', 'activity2'],
      parentId: 'parent1',
      picturePassword: ['apple', 'ball', 'cat'],
      createdAt: DateTime(2024, 1, 1),
      updatedAt: DateTime(2024, 1, 1),
      totalTimeSpent: 120,
      activitiesCompleted: 25,
      currentMood: 'happy',
    ),
    ChildProfile(
      id: 'child2',
      name: 'Sara',
      age: 6,
      avatar: 'assets/images/avatars/girl1.png',
      interests: ['reading', 'art'],
      level: 2,
      xp: 1800,
      streak: 3,
      favorites: ['activity3', 'activity4'],
      parentId: 'parent1',
      picturePassword: ['dog', 'elephant', 'fish'],
      createdAt: DateTime(2024, 1, 1),
      updatedAt: DateTime(2024, 1, 1),
      totalTimeSpent: 90,
      activitiesCompleted: 18,
      currentMood: 'excited',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: child,
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                backgroundColor: AppColors.background,
                elevation: 0,
                floating: true,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Parent Dashboard',
                      style: TextStyle(
                        fontSize: AppConstants.largeFontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Welcome back! Here\'s what\'s happening',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                actions: [
                  // Notifications
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    color: AppColors.textPrimary,
                    onPressed: () {
                      // TODO: Navigate to notifications
                    },
                  ),
                  
                  // Settings
                  IconButton(
                    icon: const Icon(Icons.settings),
                    color: AppColors.textPrimary,
                    onPressed: () {
                      context.go('/parent/settings');
                    },
                  ),
                ],
              ),
              
              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Children Overview
                      _buildChildrenOverview(),
                      const SizedBox(height: 24),
                      
                      // Quick Stats
                      _buildQuickStats(),
                      const SizedBox(height: 24),
                      
                      // AI Insights
                      _buildAiInsights(),
                      const SizedBox(height: 24),
                      
                      // Recent Activities
                      _buildRecentActivities(),
                      const SizedBox(height: 24),
                      
                      // Weekly Progress Chart
                      _buildWeeklyProgressChart(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Floating Action Button
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.go('/parent/child-management');
          },
          backgroundColor: AppColors.primary,
          icon: const Icon(Icons.add),
          label: const Text('Add Child'),
        ),
      ),
    );
  }

  Widget _buildChildrenOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Children',
          style: TextStyle(
            fontSize: AppConstants.fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        
        ..._children.map((child) => _buildChildCard(child)),
      ],
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
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                child.name[0],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  child.name,
                  style: TextStyle(
                    fontSize: AppConstants.fontSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${child.age} years old • Level ${child.level}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                
                Row(
                  children: [
                    _buildInfoChip('${child.activitiesCompleted} activities', AppColors.success),
                    const SizedBox(width: 8),
                    _buildInfoChip('${child.totalTimeSpent} min today', AppColors.info),
                    const SizedBox(width: 8),
                    _buildInfoChip('${child.streak} day streak', AppColors.streakColor),
                  ],
                ),
              ],
            ),
          ),
          
          // Mood
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              MoodTypes.getEmoji(child.currentMood ?? 'happy'),
              style: const TextStyle(fontSize: 24),
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
        color: color.withOpacity(0.1),
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

  Widget _buildQuickStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Overview',
          style: TextStyle(
            fontSize: AppConstants.fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Total Time',
                '3h 25m',
                Icons.timer,
                AppColors.info,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Activities',
                '12',
                Icons.check_circle,
                AppColors.success,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Avg Score',
                '85%',
                Icons.star,
                AppColors.xpColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 20,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: AppConstants.fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiInsights() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.psychology,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'AI Insights',
                style: TextStyle(
                  fontSize: AppConstants.fontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          Text(
            'Ahmed is showing great progress in mathematics! Sara enjoys creative activities. Consider adding more art-based learning to her routine.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          
          ElevatedButton(
            onPressed: () {
              context.go('/parent/reports');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('View Detailed Report'),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activities',
              style: TextStyle(
                fontSize: AppConstants.fontSize,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () {
                context.go('/parent/reports');
              },
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        Column(
          children: [
            _buildActivityItem('Ahmed completed Math Adventure', '2 hours ago', AppColors.educational),
            _buildActivityItem('Sara finished Reading Time', '3 hours ago', AppColors.behavioral),
            _buildActivityItem('Ahmed earned 50 XP', '5 hours ago', AppColors.xpColor),
            _buildActivityItem('Sara started Art & Craft', '1 day ago', AppColors.skillful),
          ],
        ),
      ],
    );
  }

  Widget _buildActivityItem(String text, String time, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyProgressChart() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Progress',
            style: TextStyle(
              fontSize: AppConstants.fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          
          Container(
            height: 200,
            child: BarChart(
              BarChartData(
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                        return Text(days[value.toInt()]);
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(x: 0, barRods: [
                    BarChartRodData(toY: 3, color: AppColors.educational, width: 16),
                  ]),
                  BarChartGroupData(x: 1, barRods: [
                    BarChartRodData(toY: 5, color: AppColors.educational, width: 16),
                  ]),
                  BarChartGroupData(x: 2, barRods: [
                    BarChartRodData(toY: 2, color: AppColors.educational, width: 16),
                  ]),
                  BarChartGroupData(x: 3, barRods: [
                    BarChartRodData(toY: 4, color: AppColors.educational, width: 16),
                  ]),
                  BarChartGroupData(x: 4, barRods: [
                    BarChartRodData(toY: 6, color: AppColors.educational, width: 16),
                  ]),
                  BarChartGroupData(x: 5, barRods: [
                    BarChartRodData(toY: 3, color: AppColors.educational, width: 16),
                  ]),
                  BarChartGroupData(x: 6, barRods: [
                    BarChartRodData(toY: 2, color: AppColors.educational, width: 16),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}