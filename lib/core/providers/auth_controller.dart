import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/models/user.dart';
import 'package:kinder_world/core/repositories/auth_repository.dart';
import 'package:logger/logger.dart';

/// Authentication state
class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  bool get isParent => user?.role == UserRole.parent;
  bool get isChild => user?.role == UserRole.child;
}

/// Authentication controller using AuthRepository
class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final Logger _logger;

  AuthController({
    required AuthRepository authRepository,
    required Logger logger,
  })  : _authRepository = authRepository,
        _logger = logger,
        super(const AuthState()) {
    _initialize();
  }

  /// Initialize authentication state
  Future<void> _initialize() async {
    _logger.d('Initializing auth controller');
    
    final isAuthenticated = await _authRepository.isAuthenticated();
    final user = await _authRepository.getCurrentUser();
    
    state = state.copyWith(
      isAuthenticated: isAuthenticated,
      user: user,
    );
    
    _logger.d('Auth controller initialized: ${state.isAuthenticated}');
  }

  // ==================== PARENT AUTHENTICATION ====================

  /// Login parent with email and password
  Future<bool> loginParent({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final user = await _authRepository.loginParent(
        email: email,
        password: password,
      );
      
      if (user != null) {
        state = state.copyWith(
          user: user,
          isAuthenticated: true,
          isLoading: false,
        );
        
        _logger.d('Parent login successful: ${user.id}');
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Invalid email or password',
        );
        return false;
      }
    } catch (e, stack) {
      _logger.e('Parent login error', e, stack);
      state = state.copyWith(
        isLoading: false,
        error: 'Login failed. Please try again.',
      );
      return false;
    }
  }

  /// Register new parent account
  Future<bool> registerParent({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final user = await _authRepository.registerParent(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      
      if (user != null) {
        state = state.copyWith(
          user: user,
          isAuthenticated: true,
          isLoading: false,
        );
        
        _logger.d('Parent registration successful: ${user.id}');
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Registration failed. Please check your information.',
        );
        return false;
      }
    } catch (e, stack) {
      _logger.e('Parent registration error', e, stack);
      state = state.copyWith(
        isLoading: false,
        error: 'Registration failed. Please try again.',
      );
      return false;
    }
  }

  // ==================== CHILD AUTHENTICATION ====================

  /// Login child with picture password
  Future<bool> loginChild({
    required String childId,
    required List<String> picturePassword,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final user = await _authRepository.loginChild(
        childId: childId,
        picturePassword: picturePassword,
      );
      
      if (user != null) {
        state = state.copyWith(
          user: user,
          isAuthenticated: true,
          isLoading: false,
        );
        
        _logger.d('Child login successful: ${user.id}');
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Invalid picture password',
        );
        return false;
      }
    } catch (e, stack) {
      _logger.e('Child login error', e, stack);
      state = state.copyWith(
        isLoading: false,
        error: 'Login failed. Please try again.',
      );
      return false;
    }
  }

  // ==================== AUTHENTICATION STATE ====================

  /// Check if user is authenticated
  Future<bool> checkAuthentication() async {
    try {
      final isAuthenticated = await _authRepository.isAuthenticated();
      
      if (isAuthenticated && state.user == null) {
        // Load user if authenticated but user not in state
        final user = await _authRepository.getCurrentUser();
        state = state.copyWith(
          isAuthenticated: true,
          user: user,
        );
      }
      
      return isAuthenticated;
    } catch (e, stack) {
      _logger.e('Error checking authentication', e, stack);
      return false;
    }
  }

  /// Get current user role
  Future<String?> getUserRole() async {
    try {
      return await _authRepository.getUserRole();
    } catch (e, stack) {
      _logger.e('Error getting user role', e, stack);
      return null;
    }
  }

  /// Refresh user data
  Future<void> refreshUser() async {
    try {
      final user = await _authRepository.getCurrentUser();
      state = state.copyWith(user: user);
    } catch (e, stack) {
      _logger.e('Error refreshing user', e, stack);
    }
  }

  // ==================== LOGOUT ====================

  /// Logout current user
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    
    try {
      await _authRepository.logout();
      
      state = const AuthState(
        user: null,
        isAuthenticated: false,
        isLoading: false,
        error: null,
      );
      
      _logger.d('User logged out successfully');
    } catch (e, stack) {
      _logger.e('Error during logout', e, stack);
      state = state.copyWith(
        isLoading: false,
        error: 'Logout failed',
      );
    }
  }

  // ==================== PARENT PIN ====================

  /// Set parent PIN
  Future<bool> setParentPin(String pin) async {
    try {
      return await _authRepository.setParentPin(pin);
    } catch (e, stack) {
      _logger.e('Error setting parent PIN', e, stack);
      return false;
    }
  }

  /// Verify parent PIN
  Future<bool> verifyParentPin(String enteredPin) async {
    try {
      return await _authRepository.verifyParentPin(enteredPin);
    } catch (e, stack) {
      _logger.e('Error verifying PIN', e, stack);
      return false;
    }
  }

  /// Check if PIN is required
  Future<bool> isPinRequired() async {
    try {
      return await _authRepository.isPinRequired();
    } catch (e, stack) {
      _logger.e('Error checking PIN requirement', e, stack);
      return false;
    }
  }

  // ==================== CHILD SESSION ====================

  /// Save child session
  Future<bool> saveChildSession(String childId) async {
    try {
      return await _authRepository.saveChildSession(childId);
    } catch (e, stack) {
      _logger.e('Error saving child session', e, stack);
      return false;
    }
  }

  /// Get current child session
  Future<String?> getChildSession() async {
    try {
      return await _authRepository.getChildSession();
    } catch (e, stack) {
      _logger.e('Error getting child session', e, stack);
      return null;
    }
  }

  /// Clear child session
  Future<bool> clearChildSession() async {
    try {
      return await _authRepository.clearChildSession();
    } catch (e, stack) {
      _logger.e('Error clearing child session', e, stack);
      return false;
    }
  }

  // ==================== ERROR HANDLING ====================

  /// Clear error state
  void clearError() {
    state = state.copyWith(error: null);
  }

  // ==================== TOKEN MANAGEMENT ====================

  /// Refresh authentication token
  Future<String?> refreshToken() async {
    try {
      return await _authRepository.refreshToken();
    } catch (e, stack) {
      _logger.e('Error refreshing token', e, stack);
      return null;
    }
  }

  /// Validate authentication token
  Future<bool> validateToken() async {
    try {
      return await _authRepository.validateToken();
    } catch (e, stack) {
      _logger.e('Error validating token', e, stack);
      return false;
    }
  }
}

// Provider
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final logger = ref.watch(loggerProvider);
  
  return AuthController(
    authRepository: authRepository,
    logger: logger,
  );
});

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final logger = ref.watch(loggerProvider);
  
  return AuthRepository(
    secureStorage: secureStorage,
    logger: logger,
  );
});

// Helper providers
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authControllerProvider).isAuthenticated;
});

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authControllerProvider).user;
});

final isParentProvider = Provider<bool>((ref) {
  return ref.watch(authControllerProvider).isParent;
});

final isChildProvider = Provider<bool>((ref) {
  return ref.watch(authControllerProvider).isChild;
});