import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;
  final Logger _logger;

  SecureStorage({
    FlutterSecureStorage? storage,
    Logger? logger,
  })  : _storage = storage ?? const FlutterSecureStorage(),
        _logger = logger ?? Logger();

  // Keys
  static const String _authTokenKey = 'auth_token';
  static const String _parentPinKey = 'parent_pin';
  static const String _childSessionKey = 'child_session';
  static const String _userRoleKey = 'user_role';
  static const String _subscriptionStatusKey = 'subscription_status';

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
      _logger.e('Error saving parent PIN: $e');
      rethrow;
    }
  }

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

  Future<String?> getUserRole() async {
    try {
      return await _storage.read(key: _userRoleKey);
    } catch (e) {
      _logger.e('Error reading user role: $e');
      return null;
    }
  }

  // Subscription Status
  Future<void> saveSubscriptionStatus(String status) async {
    try {
      await _storage.write(key: _subscriptionStatusKey, value: status);
      _logger.d('Subscription status saved: $status');
    } catch (e) {
      _logger.e('Error saving subscription status: $e');
      rethrow;
    }
  }

  Future<String?> getSubscriptionStatus() async {
    try {
      return await _storage.read(key: _subscriptionStatusKey);
    } catch (e) {
      _logger.e('Error reading subscription status: $e');
      return null;
    }
  }

  // Clear all data
  Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
      _logger.d('All secure storage data cleared');
    } catch (e) {
      _logger.e('Error clearing secure storage: $e');
      rethrow;
    }
  }

  // Privacy compliance - COPPA/GDPR
  Future<void> deleteSensitiveData() async {
    try {
      await Future.wait([
        _storage.delete(key: _authTokenKey),
        _storage.delete(key: _childSessionKey),
        _storage.delete(key: _subscriptionStatusKey),
      ]);
      _logger.d('Sensitive data deleted for compliance');
    } catch (e) {
      _logger.e('Error deleting sensitive data: $e');
      rethrow;
    }
  }
}