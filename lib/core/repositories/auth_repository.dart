import 'dart:async';
import 'package:kinder_world/core/models/user.dart';
import 'package:kinder_world/core/storage/secure_storage.dart';
import 'package:logger/logger.dart';

/// Repository for authentication operations
/// Uses SecureStorage for token persistence
class AuthRepository {
  final SecureStorage _secureStorage;
  final Logger _logger;

  AuthRepository({
    required SecureStorage secureStorage,
    required Logger logger,
  })  : _secureStorage = secureStorage,
        _logger = logger;

  // ==================== PARENT AUTHENTICATION ====================

  /// Login parent with email and password
  Future<User?> loginParent({
    required String email,
    required String password,
  }) async {
    try {
      _logger.d('Attempting parent login for: $email');
      
      // Simulate API call - replace with real authentication
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock validation
      if (email.isNotEmpty && password.isNotEmpty && password.length >= 6) {
        // Generate mock token
        final token = 'parent_token_${DateTime.now().millisecondsSinceEpoch}_$email';
        
        // Create mock parent user
        final parent = User(
          id: 'parent_${email.hashCode}',
          email: email,
          name: email.split('@')[0],
          role: UserRoles.parent,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isActive: true,
        );
        
        // Save to secure storage
        await _secureStorage.saveAuthToken(token);
        await _secureStorage.saveUserRole(UserRoles.parent);
        await _secureStorage.saveParentId(parent.id);
        
        _logger.d('Parent login successful: ${parent.id}');
        return parent;
      } else {
        _logger.w('Parent login failed: Invalid credentials');
        return null;
      }
    } catch (e, stack) {
      _logger.e('Parent login error: $e');
      return null;
    }
  }

  /// Register new parent account
  Future<User?> registerParent({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      _logger.d('Attempting parent registration for: $email');
      
      // Validate input
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        _logger.w('Registration failed: Missing required fields');
        return null;
      }
      
      if (password != confirmPassword) {
        _logger.w('Registration failed: Passwords do not match');
        return null;
      }
      
      if (password.length < 6) {
        _logger.w('Registration failed: Password too short');
        return null;
      }
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Generate mock token
      final token = 'parent_token_${DateTime.now().millisecondsSinceEpoch}_$email';
      
      // Create parent user
      final parent = User(
        id: 'parent_${email.hashCode}_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: name,
        role: UserRoles.parent,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isActive: true,
      );
      
      // Save to secure storage
      await _secureStorage.saveAuthToken(token);
      await _secureStorage.saveUserRole(UserRoles.parent);
      await _secureStorage.saveParentId(parent.id);
      
      _logger.d('Parent registration successful: ${parent.id}');
      return parent;
    } catch (e, stack) {
      _logger.e('Parent registration error: $e');
      return null;
    }
  }

  // ==================== CHILD AUTHENTICATION ====================

  /// Login child with picture password
  Future<User?> loginChild({
    required String childId,
    required List<String> picturePassword,
  }) async {
    try {
      _logger.d('Attempting child login for: $childId');
      
      // Validate picture password
      if (picturePassword.length != 3) {
        _logger.w('Child login failed: Invalid picture password length');
        return null;
      }
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Generate mock token
      final token = 'child_token_${DateTime.now().millisecondsSinceEpoch}_$childId';
      
      // Create mock child user
      final child = User(
        id: childId,
        email: 'child_$childId@local',
        name: 'Child_$childId',
        role: UserRoles.child,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isActive: true,
      );
      
      // Save to secure storage
      await _secureStorage.saveAuthToken(token);
      await _secureStorage.saveUserRole(UserRoles.child);
      await _secureStorage.saveChildSession(childId);
      
      _logger.d('Child login successful: $childId');
      return child;
    } catch (e, stack) {
      _logger.e('Child login error: $e');
      return null;
    }
  }

  // ==================== AUTHENTICATION STATE ====================

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    try {
      final token = await _secureStorage.getAuthToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      _logger.e('Error checking authentication: $e');
      return false;
    }
  }

  /// Get current user role
  Future<String?> getUserRole() async {
    try {
      return await _secureStorage.getUserRole();
    } catch (e) {
      _logger.e('Error getting user role: $e');
      return null;
    }
  }

  /// Get current user info
  Future<User?> getCurrentUser() async {
    try {
      final token = await _secureStorage.getAuthToken();
      final role = await _secureStorage.getUserRole();
      final parentId = await _secureStorage.getParentId();
      
      if (token == null || role == null) {
        return null;
      }
      
      // Create user from stored data
      return User(
        id: parentId ?? 'current_user',
        email: 'user@local',
        name: 'Current User',
        role: role,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isActive: true,
      );
    } catch (e, stack) {
      _logger.e('Error getting current user: $e');
      return null;
    }
  }

  // ==================== LOGOUT ====================

  /// Logout current user
  Future<void> logout() async {
    try {
      _logger.d('Logging out user');
      await _secureStorage.clearAll();
      _logger.d('User logged out successfully');
    } catch (e, stack) {
      _logger.e('Error during logout: $e');
    }
  }

  // ==================== PARENT PIN ====================

  /// Set parent PIN
  Future<bool> setParentPin(String pin) async {
    try {
      if (pin.length < 4) {
        _logger.w('PIN too short');
        return false;
      }
      
      await _secureStorage.saveParentPin(pin);
      _logger.d('Parent PIN set successfully');
      return true;
    } catch (e) {
      _logger.e('Error setting parent PIN: $e');
      return false;
    }
  }

  /// Verify parent PIN
  Future<bool> verifyParentPin(String enteredPin) async {
    try {
      final storedPin = await _secureStorage.getParentPin();
      
      if (storedPin == null) {
        _logger.w('No PIN set');
        return false;
      }
      
      return storedPin == enteredPin;
    } catch (e) {
      _logger.e('Error verifying PIN: $e');
      return false;
    }
  }

  /// Check if PIN is required
  Future<bool> isPinRequired() async {
    try {
      final pin = await _secureStorage.getParentPin();
      return pin != null && pin.isNotEmpty;
    } catch (e) {
      _logger.e('Error checking PIN requirement: $e');
      return false;
    }
  }

  // ==================== CHILD SESSION ====================

  /// Save child session
  Future<bool> saveChildSession(String childId) async {
    try {
      await _secureStorage.saveChildSession(childId);
      _logger.d('Child session saved: $childId');
      return true;
    } catch (e) {
      _logger.e('Error saving child session: $e');
      return false;
    }
  }

  /// Get current child session
  Future<String?> getChildSession() async {
    try {
      return await _secureStorage.getChildSession();
    } catch (e) {
      _logger.e('Error getting child session: $e');
      return null;
    }
  }

  /// Clear child session
  Future<bool> clearChildSession() async {
    try {
      await _secureStorage.clearChildSession();
      _logger.d('Child session cleared');
      return true;
    } catch (e) {
      _logger.e('Error clearing child session: $e');
      return false;
    }
  }

  // ==================== AUTHENTICATION HELPERS ====================

  /// Refresh authentication token
  Future<String?> refreshToken() async {
    try {
      final currentToken = await _secureStorage.getAuthToken();
      if (currentToken == null) return null;
      
      // Simulate token refresh
      await Future.delayed(const Duration(milliseconds: 500));
      
      final newToken = currentToken.replaceFirst(
        'token_',
        'token_${DateTime.now().millisecondsSinceEpoch}_',
      );
      
      await _secureStorage.saveAuthToken(newToken);
      _logger.d('Token refreshed successfully');
      return newToken;
    } catch (e) {
      _logger.e('Error refreshing token: $e');
      return null;
    }
  }

  /// Validate authentication token
  Future<bool> validateToken() async {
    try {
      final token = await _secureStorage.getAuthToken();
      if (token == null || token.isEmpty) {
        return false;
      }
      
      // Simple token validation - in real app, verify with server
      return !token.contains('expired');
    } catch (e) {
      _logger.e('Error validating token: $e');
      return false;
    }
  }
}