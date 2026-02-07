import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kinder_world/core/subscription/plan_info.dart';

/// Secure storage service for sensitive data
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
  static const String _keyUserRole = 'user_role';
  static const String _keyParentPin = 'parent_pin';
  static const String _keyChildSession = 'child_session';
  static const String _keyPlanTier = 'plan_tier';
  static const String _keyHasActiveSubscription = 'has_active_subscription';
  static const String _keyParentName = 'parent_name';

  // ==================== AUTH TOKEN ====================

  Future<String?> getAuthToken() async {
    try {
      return await _storage.read(key: _keyAuthToken);
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveAuthToken(String token) async {
    try {
      await _storage.write(key: _keyAuthToken, value: token);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAuthToken() async {
    try {
      await _storage.delete(key: _keyAuthToken);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ==================== REFRESH TOKEN ====================

  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: _keyRefreshToken);
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveRefreshToken(String token) async {
    try {
      await _storage.write(key: _keyRefreshToken, value: token);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteRefreshToken() async {
    try {
      await _storage.delete(key: _keyRefreshToken);
      return true;
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
      return await _storage.read(key: _keyParentPin);
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveParentPin(String pin) async {
    try {
      await _storage.write(key: _keyParentPin, value: pin);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteParentPin() async {
    try {
      await _storage.delete(key: _keyParentPin);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> hasParentPin() async {
    try {
      final pin = await getParentPin();
      return pin != null && pin.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // ==================== CHILD SESSION ====================

  Future<String?> getChildSession() async {
    try {
      return await _storage.read(key: _keyChildSession);
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveChildSession(String childId) async {
    try {
      await _storage.write(key: _keyChildSession, value: childId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearChildSession() async {
    try {
      await _storage.delete(key: _keyChildSession);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ==================== CLEAR ALL ====================

  Future<bool> clearAuthData() async {
    try {
      await deleteAuthToken();
      await deleteRefreshToken();
      await deleteUserId();
      await deleteUserRole();
      await clearChildSession();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearAll() async {
    try {
      await _storage.deleteAll();
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

  Future<PlanTier?> getPlanTier() async {
    try {
      final value = await _storage.read(key: _keyPlanTier);
      return _mapToPlanTier(value);
    } catch (e) {
      return null;
    }
  }

  Future<bool> savePlanTier(PlanTier tier) async {
    try {
      await _storage.write(key: _keyPlanTier, value: _planTierToString(tier));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearPlanTier() async {
    try {
      await _storage.delete(key: _keyPlanTier);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> hasActiveSubscription() async {
    try {
      final value = await _storage.read(key: _keyHasActiveSubscription);
      if (value == null) return false;
      return value.toLowerCase() == 'true';
    } catch (e) {
      return false;
    }
  }

  Future<bool> setActiveSubscription(bool isActive) async {
    try {
      await _storage.write(
        key: _keyHasActiveSubscription,
        value: isActive ? 'true' : 'false',
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getParentName() async {
    try {
      return await _storage.read(key: _keyParentName);
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveParentName(String name) async {
    try {
      await _storage.write(key: _keyParentName, value: name);
      return true;
    } catch (e) {
      return false;
    }
  }

  PlanTier? _mapToPlanTier(String? value) {
    if (value == null) return null;
    switch (value.toLowerCase()) {
      case 'free':
        return PlanTier.free;
      case 'premium':
        return PlanTier.premium;
      case 'family_plus':
      case 'familyplus':
      case 'family+':
      case 'family':
        return PlanTier.familyPlus;
      default:
        return null;
    }
  }

  String _planTierToString(PlanTier tier) {
    switch (tier) {
      case PlanTier.free:
        return 'free';
      case PlanTier.premium:
        return 'premium';
      case PlanTier.familyPlus:
        return 'family_plus';
    }
  }
}
