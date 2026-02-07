import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // Storage keys
  static const String _keyAuthToken = 'auth_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserRole = 'user_role';
  static const String _keyParentPin = 'parent_pin';
  static const String _keyChildSession = 'child_session';
  static const String _keyIsPremium = 'is_premium';
  static const String _keyPlanType = 'plan_type';

  // Auth Token
  Future<void> saveAuthToken(String token) async {
    try {
      await _storage.write(key: _authTokenKey, value: token);
      _logger.d('Auth token saved successfully');
    } catch (e) {
      _logger.e('Error saving auth token: $e');
      rethrow;
    }
  }

  Future<String?> getAuthToken() async {
    try {
      return await _storage.read(key: _authTokenKey);
    } catch (e) {
      _logger.e('Error reading auth token: $e');
      return null;
    }
  }

  Future<void> deleteAuthToken() async {
    try {
      await _storage.delete(key: _authTokenKey);
      _logger.d('Auth token deleted');
    } catch (e) {
      _logger.e('Error deleting auth token: $e');
    }
  }

  // Parent PIN
  Future<void> saveParentPin(String pin) async {
    try {
      await _storage.write(key: _parentPinKey, value: pin);
      _logger.d('Parent PIN saved successfully');
    } catch (e) {
      return false;
    }
  }

  // ==================== USER ID ====================

  Future<String?> getUserId() async {
    try {
      return await _storage.read(key: _keyUserId);
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveUserId(String userId) async {
    try {
      await _storage.write(key: _keyUserId, value: userId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUserId() async {
    try {
      await _storage.delete(key: _keyUserId);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ==================== USER EMAIL ====================

  Future<String?> getUserEmail() async {
    try {
      return await _storage.read(key: _keyUserEmail);
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveUserEmail(String email) async {
    try {
      await _storage.write(key: _keyUserEmail, value: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUserEmail() async {
    try {
      await _storage.delete(key: _keyUserEmail);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ==================== USER ROLE ====================

  Future<String?> getUserRole() async {
    try {
      return await _storage.read(key: _keyUserRole);
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveUserRole(String role) async {
    try {
      await _storage.write(key: _keyUserRole, value: role);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUserRole() async {
    try {
      await _storage.delete(key: _keyUserRole);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ==================== PARENT PIN ====================

  Future<String?> getParentPin() async {
    try {
      return await _storage.read(key: _parentPinKey);
    } catch (e) {
      _logger.e('Error reading parent PIN: $e');
      return null;
    }
  }

  Future<bool> verifyParentPin(String pin) async {
    try {
      final storedPin = await getParentPin();
      return storedPin == pin;
    } catch (e) {
      _logger.e('Error verifying parent PIN: $e');
      return false;
    }
  }

  // Child Session
  Future<void> saveChildSession(String childId) async {
    try {
      await _storage.write(key: _childSessionKey, value: childId);
      _logger.d('Child session saved: $childId');
    } catch (e) {
      _logger.e('Error saving child session: $e');
      rethrow;
    }
  }

  Future<String?> getChildSession() async {
    try {
      return await _storage.read(key: _childSessionKey);
    } catch (e) {
      _logger.e('Error reading child session: $e');
      return null;
    }
  }

  Future<void> clearChildSession() async {
    try {
      await _storage.delete(key: _childSessionKey);
      _logger.d('Child session cleared');
    } catch (e) {
      _logger.e('Error clearing child session: $e');
    }
  }

  // User Role
  Future<void> saveUserRole(String role) async {
    try {
      await _storage.write(key: _userRoleKey, value: role);
      _logger.d('User role saved: $role');
    } catch (e) {
      _logger.e('Error saving user role: $e');
      rethrow;
    }
  }

  // ==================== PREMIUM STATUS ====================

  Future<bool?> getIsPremium() async {
    try {
      final value = await _storage.read(key: _keyIsPremium);
      if (value == null) return null;
      return value == 'true';
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveIsPremium(bool isPremium) async {
    try {
      await _storage.write(
        key: _keyIsPremium,
        value: isPremium ? 'true' : 'false',
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearIsPremium() async {
    try {
      await _storage.delete(key: _keyIsPremium);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ==================== PLAN TYPE ====================

  Future<String?> getPlanType() async {
    try {
      return await _storage.read(key: _keyPlanType);
    } catch (e) {
      return null;
    }
  }

  Future<bool> savePlanType(String planType) async {
    try {
      await _storage.write(key: _keyPlanType, value: planType);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearPlanType() async {
    try {
      await _storage.delete(key: _keyPlanType);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ==================== CLEAR ALL ====================

  Future<bool> clearAll() async {
    try {
      await _storage.deleteAll();
      _logger.d('All secure storage data cleared');
    } catch (e) {
      return false;
    }
  }

  /// Clear only authentication/session data while preserving child profiles and preferences
  /// Use this for logout to keep local child data intact
  Future<bool> clearAuthOnly() async {
    try {
      // Clear auth tokens and session
      await _storage.delete(key: _keyAuthToken);
      await _storage.delete(key: _keyUserRole);
      await _storage.delete(key: _keyUserId);
      await _storage.delete(key: _keyUserEmail);
      await _storage.delete(key: _keyChildSession);
      await _storage.delete(key: _keyParentPin);
      
      // Preserve: child profiles, plan type, theme settings, privacy settings
      // These are accessible without authentication
      return true;
    } catch (e) {
      return false;
    }
  }

  // ==================== HELPERS ====================

  Future<bool> isAuthenticated() async {
    try {
      final token = await getAuthToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, String>> getAllSecureData() async {
    try {
      return await _storage.readAll();
    } catch (e) {
      return {};
    }
  }

  /// Backwards-compatible alias for getting the parent id (previous API used getParentId)
  Future<String?> getParentId() async => getUserId();

  /// Backwards-compatible alias for getting the parent email
  Future<String?> getParentEmail() async => getUserEmail();
}
