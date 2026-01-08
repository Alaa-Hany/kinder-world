import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/core/storage/secure_storage.dart';
import 'package:kinder_world/core/models/child_profile.dart';
import 'package:kinder_world/app.dart';

class ChildLoginScreen extends ConsumerStatefulWidget {
  const ChildLoginScreen({super.key});

  @override
  ConsumerState<ChildLoginScreen> createState() => _ChildLoginScreenState();
}

class _ChildLoginScreenState extends ConsumerState<ChildLoginScreen> 
    with SingleTickerProviderStateMixin {
  final List<String> _selectedPictures = [];
  bool _isLoading = false;
  
  // Mock child profiles for demo
  final List<ChildProfile> _mockChildren = [
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
      totalTimeSpent: 0,
      activitiesCompleted: 0,
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
      totalTimeSpent: 0,
      activitiesCompleted: 0,
    ),
  ];

  // Available picture options for password
  final List<Map<String, dynamic>> _pictureOptions = [
    {'id': 'apple', 'icon': '🍎', 'name': 'Apple'},
    {'id': 'ball', 'icon': '⚽', 'name': 'Ball'},
    {'id': 'cat', 'icon': '🐱', 'name': 'Cat'},
    {'id': 'dog', 'icon': '🐶', 'name': 'Dog'},
    {'id': 'elephant', 'icon': '🐘', 'name': 'Elephant'},
    {'id': 'fish', 'icon': '🐠', 'name': 'Fish'},
    {'id': 'guitar', 'icon': '🎸', 'name': 'Guitar'},
    {'id': 'house', 'icon': '🏠', 'name': 'House'},
    {'id': 'icecream', 'icon': '🍦', 'name': 'Ice Cream'},
    {'id': 'jelly', 'icon': '🍇', 'name': 'Jelly'},
    {'id': 'kite', 'icon': '🪁', 'name': 'Kite'},
    {'id': 'lion', 'icon': '🦁', 'name': 'Lion'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go('/select-user-type'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const SizedBox(height: 20),
              Text(
                'Child Login',
                style: TextStyle(
                  fontSize: AppConstants.largeFontSize * 1.2,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select your picture password to continue',
                style: TextStyle(
                  fontSize: AppConstants.fontSize,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              
              // Child Selection (for demo)
              Text(
                'Choose Your Profile:',
                style: TextStyle(
                  fontSize: AppConstants.fontSize,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _mockChildren.map((child) => 
                  _buildChildCard(child)
                ).toList(),
              ),
              const SizedBox(height: 40),
              
              // Picture Password Selection
              Text(
                'Select Your Picture Password:',
                style: TextStyle(
                  fontSize: AppConstants.fontSize,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              
              // Selected pictures display
              Container(
                height: 80,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.lightGrey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.grey),
                      ),
                      child: _selectedPictures.length > index
                          ? Center(
                              child: Text(
                                _pictureOptions.firstWhere(
                                  (p) => p['id'] == _selectedPictures[index]
                                )['icon'],
                                style: const TextStyle(fontSize: 24),
                              ),
                            )
                          : null,
                    );
                  }),
                ),
              ),
              const SizedBox(height: 24),
              
              // Picture options grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: _pictureOptions.length,
                itemBuilder: (context, index) {
                  final picture = _pictureOptions[index];
                  final isSelected = _selectedPictures.contains(picture['id']);
                  
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (_selectedPictures.length < 3 && !isSelected) {
                          _selectedPictures.add(picture['id']);
                        } else if (isSelected) {
                          _selectedPictures.remove(picture['id']);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? AppColors.primary.withOpacity(0.2)
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.lightGrey,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            picture['icon'],
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            picture['name'],
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              
              // Clear button
              if (_selectedPictures.isNotEmpty)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedPictures.clear();
                    });
                  },
                  child: const Text('Clear Selection'),
                ),
              
              // Login button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedPictures.length == 3 ? _login : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.behavioral,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: AppColors.white)
                      : Text(
                          'Login',
                          style: TextStyle(
                            fontSize: AppConstants.fontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 40),
              
              // Demo note
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.info.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Demo Passwords:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.info,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ahmed: 🍎⚽🐱\nSara: 🐶🐘🐠',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
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

  Widget _buildChildCard(ChildProfile child) {
    return InkWell(
      onTap: () {
        // For demo, we'll just show the child is selected
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected ${child.name}'),
            backgroundColor: AppColors.success,
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Column(
          children: [
            // Avatar placeholder
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.behavioral.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  child.name[0],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.behavioral,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              child.name,
              style: TextStyle(
                fontSize: AppConstants.fontSize,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '${child.age} years old',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            // Level indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.xpColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Level ${child.level}',
                style: TextStyle(
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

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      // Simulate login process
      await Future.delayed(const Duration(seconds: 2));
      
      // Store child session
      final secureStorage = ref.read(secureStorageProvider);
      await secureStorage.saveAuthToken('mock_child_token');
      await secureStorage.saveUserRole('child');
      await secureStorage.saveChildSession('child1');
      
      if (mounted) {
        context.go('/child/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed. Please try again.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}