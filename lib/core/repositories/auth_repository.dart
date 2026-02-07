import 'package:dio/dio.dart';
import 'package:kinder_world/core/models/api/auth_models.dart';
import 'package:kinder_world/core/models/api/child_models.dart';
import 'package:kinder_world/core/models/user.dart';
import 'package:kinder_world/core/network/api_client.dart';
import 'package:kinder_world/core/network/api_exception.dart';
import 'package:kinder_world/core/storage/secure_storage.dart';
import 'package:logger/logger.dart';

/// Repository for authentication operations
class AuthRepository {
  final ApiClient _apiClient;
  final SecureStorage _secureStorage;
  final Logger _logger;

  AuthRepository({
    required ApiClient apiClient,
    required SecureStorage secureStorage,
    required Logger logger,
  })  : _apiClient = apiClient,
        _secureStorage = secureStorage,
        _logger = logger;

  // ==================== AUTHENTICATION STATE ====================

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    try {
      return await _secureStorage.isAuthenticated();
    } catch (e) {
      _logger.e('Error checking authentication: $e');
      return false;
    }
  }

  /// Get current user from storage/API
  Future<User?> getCurrentUser() async {
    try {
      final token = await _secureStorage.getAuthToken();
      if (token == null || token.isEmpty) return null;

      final role = await _secureStorage.getUserRole();
      if (role == UserRoles.child) {
        return null;
      }

      final response = await _apiClient.get<Map<String, dynamic>>('/auth/me');
      final data = response.data;
      if (data == null) return null;

      return MeResponse.fromJson(data).user;
    } on DioException catch (e) {
      _logger.e('Error getting current user: $e');
      if (e.response?.statusCode == 401) {
        await _secureStorage.clearAuthData();
      }
      return null;
    } catch (e) {
      _logger.e('Error getting current user: $e');
      return null;
    }
  }

  /// Get user role
  Future<String?> getUserRole() async {
    try {
      return await _secureStorage.getUserRole();
    } catch (e) {
      _logger.e('Error getting user role: $e');
      return null;
    }
  }

  // ==================== PARENT AUTHENTICATION ====================

  /// Login parent with email and password
  Future<User?> loginParent({
    required String email,
    required String password,
  }) async {
    try {
      _logger.d('Attempting parent login for: $email');

      final response = await _apiClient.post<Map<String, dynamic>>(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(extra: {'skipAuth': true, 'skipRefresh': true}),
      );

      final data = response.data;
      if (data == null) return null;

      final auth = AuthResponse.fromJson(data);
      await _persistAuth(auth);

      _logger.d('Parent login successful: ${auth.user.id}');
      return auth.user;
    } on DioException catch (e) {
      final message = _extractErrorMessage(
        e,
        fallback: 'Invalid email or password',
      );
      throw ApiException(message);
    } catch (e) {
      _logger.e('Parent login error: $e');
      throw ApiException('Login failed. Please try again.');
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

      final response = await _apiClient.post<Map<String, dynamic>>(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },
        options: Options(extra: {'skipAuth': true, 'skipRefresh': true}),
      );

      final data = response.data;
      if (data == null) return null;

      final auth = AuthResponse.fromJson(data);
      await _persistAuth(auth);

      _logger.d('Parent registration successful: ${auth.user.id}');
      return auth.user;
    } on DioException catch (e) {
      final message = _extractErrorMessage(
        e,
        fallback: 'Registration failed. Please try again.',
      );
      throw ApiException(message);
    } catch (e) {
      _logger.e('Parent registration error: $e');
      throw ApiException('Registration failed. Please try again.');
    }
  }

  // ==================== CHILD AUTHENTICATION ====================

  /// Login child with picture password
  Future<bool> loginChild({
    required String childId,
    required List<String> picturePassword,
  }) async {
    try {
      _logger.d('Attempting child login for: $childId');

      final idValue = int.tryParse(childId) ?? childId;
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/auth/child/login',
        data: {
          'child_id': idValue,
          'picture_password': picturePassword,
        },
        options: Options(extra: {'skipAuth': true, 'skipRefresh': true}),
      );

      final data = response.data;
      if (data == null) return false;
      final login = ChildLoginResponse.fromJson(data);
      if (!login.success) {
        throw ApiException('Invalid picture password');
      }

      await _secureStorage.saveAuthToken('child_session_${login.childId}');
      await _secureStorage.deleteRefreshToken();
      await _secureStorage.saveUserId(login.childId);
      await _secureStorage.saveUserRole(UserRoles.child);
      await _secureStorage.saveChildSession(login.childId);

      _logger.d('Child login successful: ${login.childId}');
      return true;
    } on DioException catch (e) {
      final message = _extractErrorMessage(
        e,
        fallback: 'Invalid picture password',
      );
      throw ApiException(message);
    } catch (e) {
      _logger.e('Child login error: $e');
      if (e is ApiException) rethrow;
      throw ApiException('Login failed. Please try again.');
    }
  }

  // ==================== LOGOUT ====================

  /// Logout current user
  Future<bool> logout() async {
    try {
      _logger.d('Logging out user');
      await _secureStorage.clearAuthData();
      _logger.d('Logout successful');
      return true;
    } catch (e) {
      _logger.e('Logout error: $e');
      return false;
    }
  }

  // ==================== PARENT PIN ====================

  /// Set parent PIN
  Future<bool> setParentPin(String pin) async {
    try {
      if (pin.length != 4) {
        _logger.w('Invalid PIN length');
        return false;
      }

      return await _secureStorage.saveParentPin(pin);
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
        _logger.w('No PIN found');
        return false;
      }

      final isValid = storedPin == enteredPin;
      _logger.d('PIN verification: $isValid');
      return isValid;
    } catch (e) {
      _logger.e('Error verifying PIN: $e');
      return false;
    }
  }

  /// Check if PIN is required
  Future<bool> isPinRequired() async {
    try {
      return await _secureStorage.hasParentPin();
    } catch (e) {
      _logger.e('Error checking PIN requirement: $e');
      return false;
    }
  }

  // ==================== CHILD SESSION ====================

  /// Save child session
  Future<bool> saveChildSession(String childId) async {
    try {
      return await _secureStorage.saveChildSession(childId);
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
      return await _secureStorage.clearChildSession();
    } catch (e) {
      _logger.e('Error clearing child session: $e');
      return false;
    }
  }

  // ==================== TOKEN MANAGEMENT ====================

  /// Refresh authentication token
  Future<String?> refreshToken() async {
    try {
      final currentRefresh = await _secureStorage.getRefreshToken();
      if (currentRefresh == null || currentRefresh.isEmpty) return null;

      final response = await _apiClient.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refresh_token': currentRefresh},
        options: Options(extra: {'skipAuth': true, 'skipRefresh': true}),
      );

      final data = response.data;
      if (data == null) return null;

      final refresh = RefreshResponse.fromJson(data);
      await _secureStorage.saveAuthToken(refresh.accessToken);

      return refresh.accessToken;
    } on DioException catch (e) {
      _logger.e('Error refreshing token: $e');
      return null;
    } catch (e) {
      _logger.e('Error refreshing token: $e');
      return null;
    }
  }

  /// Validate authentication token
  Future<bool> validateToken() async {
    try {
      final token = await _secureStorage.getAuthToken();
      if (token == null || token.isEmpty) return false;

      final role = await _secureStorage.getUserRole();
      if (role == UserRoles.child) return true;

      final response = await _apiClient.get<Map<String, dynamic>>('/auth/me');
      return response.statusCode == 200;
    } catch (e) {
      _logger.e('Error validating token: $e');
      return false;
    }
  }

  Future<void> _persistAuth(AuthResponse auth) async {
    await _secureStorage.saveAuthToken(auth.accessToken);
    await _secureStorage.saveRefreshToken(auth.refreshToken);
    await _secureStorage.saveUserId(auth.user.id);
    await _secureStorage.saveUserRole(auth.user.role);
  }

  String _extractErrorMessage(
    DioException e, {
    required String fallback,
  }) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      final detail = data['detail'];
      if (detail is String && detail.isNotEmpty) {
        return detail;
      }
    } else if (data is String && data.isNotEmpty) {
      return data;
    }
    return fallback;
  }
}
