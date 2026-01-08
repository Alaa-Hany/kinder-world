import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kinder_world/core/storage/secure_storage.dart';
import 'package:kinder_world/features/app_core/splash_screen.dart';
import 'package:kinder_world/features/app_core/language_selection_screen.dart';
import 'package:kinder_world/features/app_core/onboarding_screen.dart';
import 'package:kinder_world/features/app_core/welcome_screen.dart';
import 'package:kinder_world/features/auth/user_type_selection_screen.dart';
import 'package:kinder_world/features/auth/parent_login_screen.dart';
import 'package:kinder_world/features/auth/parent_register_screen.dart';
import 'package:kinder_world/features/auth/child_login_screen.dart';
import 'package:kinder_world/features/child_mode/home/child_home_screen.dart';
import 'package:kinder_world/features/child_mode/learn/learn_screen.dart';
import 'package:kinder_world/features/child_mode/play/play_screen.dart';
import 'package:kinder_world/features/child_mode/ai_buddy/ai_buddy_screen.dart';
import 'package:kinder_world/features/child_mode/profile/child_profile_screen.dart';
import 'package:kinder_world/features/parent_mode/dashboard/parent_dashboard_screen.dart';
import 'package:kinder_world/features/parent_mode/child_management/child_management_screen.dart';
import 'package:kinder_world/features/parent_mode/reports/reports_screen.dart';
import 'package:kinder_world/features/parent_mode/controls/parental_controls_screen.dart';
import 'package:kinder_world/features/parent_mode/settings/parent_settings_screen.dart';
import 'package:kinder_world/features/parent_mode/subscription/subscription_screen.dart';
import 'package:kinder_world/features/system_pages/no_internet_screen.dart';
import 'package:kinder_world/features/system_pages/error_screen.dart';
import 'package:kinder_world/features/system_pages/maintenance_screen.dart';

// Router provider
final routerProvider = Provider<GoRouter>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      // Check authentication status
      final authToken = await secureStorage.getAuthToken();
      final userRole = await secureStorage.getUserRole();
      final childSession = await secureStorage.getChildSession();
      
      final isAuthenticated = authToken != null;
      final isOnboarding = state.uri.path.contains('onboarding');
      final isSplash = state.uri.path == '/splash';
      final isLanguage = state.uri.path == '/language';
      final isWelcome = state.uri.path == '/welcome';
      final isAuth = state.uri.path.contains('login') || state.uri.path.contains('register');
      
      // Allow splash, language selection, and onboarding for new users
      if (isSplash || isLanguage || isOnboarding || isWelcome) {
        return null;
      }
      
      // Redirect to login if not authenticated
      if (!isAuthenticated && !isAuth) {
        return '/welcome';
      }
      
      // Handle role-based routing
      if (isAuthenticated && !isAuth) {
        if (userRole == 'parent' && !state.uri.path.contains('parent')) {
          return '/parent/dashboard';
        } else if (userRole == 'child' && childSession == null && !state.uri.path.contains('child/login')) {
          return '/child/login';
        } else if (userRole == 'child' && childSession != null && !state.uri.path.contains('child/home')) {
          return '/child/home';
        }
      }
      
      return null;
    },
    routes: [
      // App Core Routes
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/language',
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      
      // Auth Routes
      GoRoute(
        path: '/select-user-type',
        builder: (context, state) => const UserTypeSelectionScreen(),
      ),
      GoRoute(
        path: '/parent/login',
        builder: (context, state) => const ParentLoginScreen(),
      ),
      GoRoute(
        path: '/parent/register',
        builder: (context, state) => const ParentRegisterScreen(),
      ),
      GoRoute(
        path: '/child/login',
        builder: (context, state) => const ChildLoginScreen(),
      ),
      
      // Child Mode Routes with Bottom Navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ChildHomeScreen(navigationShell: navigationShell);
        },
        branches: [
          // Home Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/child/home',
                builder: (context, state) => const ChildHomeContent(),
              ),
            ],
          ),
          // Learn Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/child/learn',
                builder: (context, state) => const LearnScreen(),
              ),
            ],
          ),
          // Play Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/child/play',
                builder: (context, state) => const PlayScreen(),
              ),
            ],
          ),
          // AI Buddy Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/child/ai-buddy',
                builder: (context, state) => const AiBuddyScreen(),
              ),
            ],
          ),
          // Profile Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/child/profile',
                builder: (context, state) => const ChildProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      
      // Parent Mode Routes
      GoRoute(
        path: '/parent/dashboard',
        builder: (context, state) => const ParentDashboardScreen(),
      ),
      GoRoute(
        path: '/parent/child-management',
        builder: (context, state) => const ChildManagementScreen(),
      ),
      GoRoute(
        path: '/parent/reports',
        builder: (context, state) => const ReportsScreen(),
      ),
      GoRoute(
        path: '/parent/controls',
        builder: (context, state) => const ParentalControlsScreen(),
      ),
      GoRoute(
        path: '/parent/settings',
        builder: (context, state) => const ParentSettingsScreen(),
      ),
      GoRoute(
        path: '/parent/subscription',
        builder: (context, state) => const SubscriptionScreen(),
      ),
      
      // System Pages
      GoRoute(
        path: '/no-internet',
        builder: (context, state) => const NoInternetScreen(),
      ),
      GoRoute(
        path: '/error',
        builder: (context, state) => ErrorScreen(
          error: state.extra as String? ?? 'An unexpected error occurred',
        ),
      ),
      GoRoute(
        path: '/maintenance',
        builder: (context, state) => const MaintenanceScreen(),
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(
      error: state.error?.toString() ?? 'Page not found',
    ),
  );
});