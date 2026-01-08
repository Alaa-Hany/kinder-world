import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/storage/secure_storage.dart';
import 'package:logger/logger.dart';

// Authentication state
class AuthState {
  final String? authToken;
  final String? userRole;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.authToken,
    this.userRole,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    String? authToken,
    String? userRole,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      authToken: authToken ?? this.authToken,
      userRole: userRole ?? this.userRole,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool get isAuthenticated => authToken != null;
  bool get isParent => userRole == 'parent';
  bool get isChild => userRole == 'child';
}

// Auth Provider
class AuthNotifier extends StateNotifier<AuthState> {
  final SecureStorage _secureStorage;
  final Logger _logger;

  AuthNotifier({
    required SecureStorage secureStorage,
    required Logger logger,
  })  : _secureStorage = secureStorage,
        _logger = logger,
        super(const AuthState()) {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    try {
      final token = await _secureStorage.getAuthToken();
      final role = await _secureStorage.getUserRole();
      
      state = state.copyWith(
        authToken: token,
        userRole: role,
      );
    } catch (e) {
      _logger.e('Error loading auth state: $e');
      state = state.copyWith(error: 'Failed to load authentication state');
    }
  }

  Future<bool> loginParent({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simulate API call - replace with real authentication
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock validation - replace with real API call
      if (email.isNotEmpty && password.isNotEmpty) {
        const mockToken = 'parent_auth_token_${DateTime.now().millisecondsSinceEpoch}';
        
        await _secureStorage.saveAuthToken(mockToken);
        await _secureStorage.saveUserRole('parent');
        
        state = state.copyWith(
          authToken: mockToken,
          userRole: 'parent',
          isLoading: false,
        );
        
        _logger.d('Parent login successful');
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Please enter valid credentials',
        );
        return false;
      }
    } catch (e) {
      _logger.e('Parent login failed: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Login failed. Please try again.',
      );
      return false;
    }
  }

  Future<bool> registerParent({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Validate input
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          error: 'Please fill in all fields',
        );
        return false;
      }
      
      if (password != confirmPassword) {
        state = state.copyWith(
          isLoading: false,
          error: 'Passwords do not match',
        );
        return false;
      }
      
      if (password.length < 6) {
        state = state.copyWith(
          isLoading: false,
          error: 'Password must be at least 6 characters',
        );
        return false;
      }
      
      // Simulate API call - replace with real registration
      await Future.delayed(const Duration(seconds: 2));
      
      const mockToken = 'parent_auth_token_${DateTime.now().millisecondsSinceEpoch}';
      
      await _secureStorage.saveAuthToken(mockToken);
      await _secureStorage.saveUserRole('parent');
      
      state = state.copyWith(
        authToken: mockToken,
        userRole: 'parent',
        isLoading: false,
      );
      
      _logger.d('Parent registration successful');
      return true;
    } catch (e) {
      _logger.e('Parent registration failed: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Registration failed. Please try again.',
      );
      return false;
    }
  }

  Future<bool> loginChild({
    required String childId,
    required List<String> picturePassword,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simulate validation - replace with real API call
      await Future.delayed(const Duration(seconds: 1));
      
      if (picturePassword.length == 3) {
        const mockToken = 'child_auth_token_${DateTime.now().millisecondsSinceEpoch}';
        
        await _secureStorage.saveAuthToken(mockToken);
        await _secureStorage.saveUserRole('child');
        await _secureStorage.saveChildSession(childId);
        
        state = state.copyWith(
          authToken: mockToken,
          userRole: 'child',
          isLoading: false,
        );
        
        _logger.d('Child login successful');
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Please select 3 pictures for your password',
        );
        return false;
      }
    } catch (e) {
      _logger.e('Child login failed: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Login failed. Please try again.',
      );
      return false;
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _secureStorage.clearAll();
      
      state = const AuthState(
        authToken: null,
        userRole: null,
        isLoading: false,
      );
      
      _logger.d('Logout successful');
    } catch (e) {
      _logger.e('Logout failed: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Logout failed',
      );
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final logger = ref.watch(loggerProvider);
  
  return AuthNotifier(
    secureStorage: secureStorage,
    logger: logger,
  );
});

// Helper providers for route guards
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isAuthenticated;
});

final userRoleProvider = Provider<String?>((ref) {
  return ref.watch(authProvider).userRole;
});

final isParentProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isParent;
});

final isChildProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isChild;
});