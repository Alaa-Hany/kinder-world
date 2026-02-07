import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:kinder_world/core/models/api/child_models.dart';
import 'package:kinder_world/core/models/child_profile.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/core/network/api_client.dart';
import 'package:kinder_world/core/network/api_exception.dart';
import 'package:logger/logger.dart';

/// Adapter repository that keeps the original API contract while enriching
/// the locally cached child data into `ChildProfile`.
class ChildRepository {
  final Box _childBox;
  final Logger _logger;
  final ApiClient _apiClient;

  ChildRepository({
    required Box childBox,
    required Logger logger,
    required ApiClient apiClient,
  })  : _childBox = childBox,
        _logger = logger,
        _apiClient = apiClient;

  Future<Child?> createChild({
    required String name,
    required List<String> picturePassword,
  }) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/children',
        data: {
          'name': name,
          'picture_password': picturePassword,
        },
      );

      final data = response.data;
      if (data == null) return null;

      final child = ChildResponse.fromJson(data).child;
      await _cacheChildProfile(_buildChildProfile(child));
      return child;
    } on DioException catch (e) {
      final message = _extractErrorMessage(
        e,
        fallback: 'Failed to create child profile',
      );
      throw ApiException(message);
    } catch (e) {
      _logger.e('Error creating child profile: $e');
      throw ApiException('Failed to create child profile');
    }
  }

  Future<ChildLoginResponse?> childLogin({
    required String childId,
    required List<String> picturePassword,
  }) async {
    try {
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
      if (data == null) return null;

      return ChildLoginResponse.fromJson(data);
    } on DioException catch (e) {
      final message = _extractErrorMessage(
        e,
        fallback: 'Invalid picture password',
      );
      throw ApiException(message);
    } catch (e) {
      _logger.e('Error logging in child: $e');
      throw ApiException('Login failed. Please try again.');
    }
  }

  Future<ChildProfile?> getChildProfile(String childId) async {
    final cached = _parseChildProfile(_childBox.get(childId));
    if (cached != null) {
      return cached;
    }

    await _refreshChildCache();

    final refreshed = _parseChildProfile(_childBox.get(childId));
    if (refreshed != null) {
      return refreshed;
    }

    final child = await getChild(childId);
    if (child == null) return null;

    final profile = _buildChildProfile(child);
    await _cacheChildProfile(profile);
    return profile;
  }

  Future<List<ChildProfile>> getChildProfilesForParent(String parentId) async {
    final cached = _getChildProfilesFromCache(parentId);
    if (cached.isNotEmpty) return cached;

    final children = await getChildrenForParent(parentId);
    final profiles = children.map(_buildChildProfile).toList();

    for (final profile in profiles) {
      await _cacheChildProfile(profile);
    }

    return profiles;
  }

  Future<List<ChildProfile>> getAllChildProfiles() async {
    return _getChildProfilesFromCache(null);
  }

  Future<void> _cacheChildProfile(ChildProfile profile) async {
    try {
      await _childBox.put(profile.id, profile.toJson());
    } catch (e) {
      _logger.e('Error caching child profile: ${profile.id}, $e');
    }
  }

  Future<void> _refreshChildCache() async {
    await getChildrenForParent('');
  }

  Future<Child?> getChild(String childId) async {
    try {
      final data = _childBox.get(childId);
      if (data == null) {
        _logger.w('Child not found: $childId');
        return null;
      }

      final child = _parseChild(data);
      if (child == null) {
        _logger.w('Child record invalid: $childId');
      }
      return child;
    } catch (e) {
      _logger.e('Error getting child: $childId, $e');
      return null;
    }
  }

  Future<List<Child>> getChildrenForParent(String parentId) async {
    try {
      final response = await _apiClient.get<Map<String, dynamic>>('/children');
      final data = response.data;
      if (data == null) return [];

      final children = ChildrenResponse.fromJson(data).children;
      for (final child in children) {
        await _cacheChildProfile(_buildChildProfile(child));
      }

      _logger.d('Fetched ${children.length} children from API');
      return children;
    } on DioException catch (e) {
      final message = _extractErrorMessage(
        e,
        fallback: 'Failed to load children',
      );
      _logger.e('Error fetching children: $message');
      return _getChildrenFromCache(parentId);
    } catch (e) {
      _logger.e('Error getting children for parent: $parentId, $e');
      return _getChildrenFromCache(parentId);
    }
  }

  Future<List<Child>> getAllChildren() async {
    return _getChildrenFromCache(null);
  }

  List<ChildProfile> _getChildProfilesFromCache(String? parentId) {
    try {
      final profiles = <ChildProfile>[];

      for (var key in _childBox.keys) {
        final data = _childBox.get(key);
        if (data == null) continue;
        try {
          final profile = _parseChildProfile(data);
          if (profile == null) continue;
          if (parentId == null || profile.parentId == parentId) {
            profiles.add(profile);
          }
        } catch (e) {
          _logger.e('Error parsing child profile: $key, $e');
        }
      }

      _logger.d('Loaded ${profiles.length} child profiles from cache');
      return profiles;
    } catch (e) {
      _logger.e('Error reading child profiles from cache: $e');
      return [];
    }
  }

  List<Child> _getChildrenFromCache(String? parentId) {
    return _getChildProfilesFromCache(parentId)
        .map(_profileToChild)
        .toList(growable: false);
  }

  Child? _parseChild(dynamic data) {
    final json = _normalizeJson(data);
    if (json.containsKey('xp')) {
      try {
        final profile = ChildProfile.fromJson(json);
        return _profileToChild(profile);
      } catch (_) {
        // fall back to standard parsing
      }
    }

    if (!json.containsKey('parent_id') && json.containsKey('parentId')) {
      json['parent_id'] = json['parentId'];
    }
    if (!json.containsKey('created_at') && json.containsKey('createdAt')) {
      json['created_at'] = json['createdAt'];
    }
    if (json['created_at'] is DateTime) {
      json['created_at'] = (json['created_at'] as DateTime).toIso8601String();
    }

    if (!json.containsKey('id') ||
        !json.containsKey('name') ||
        !json.containsKey('parent_id') ||
        !json.containsKey('created_at')) {
      return null;
    }

    return Child.fromJson(json);
  }

  ChildProfile? _parseChildProfile(dynamic data) {
    try {
      final json = _normalizeJson(data);
      return ChildProfile.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> _normalizeJson(dynamic data) {
    return data is String
        ? jsonDecode(data) as Map<String, dynamic>
        : Map<String, dynamic>.from(data);
  }

  ChildProfile _buildChildProfile(Child child) {
    final now = DateTime.now();
    return ChildProfile(
      id: child.id,
      name: child.name,
      age: 6,
      avatar: 'avatar_1',
      interests: const [],
      level: 1,
      xp: 0,
      streak: 0,
      favorites: const [],
      parentId: child.parentId,
      parentEmail: null,
      picturePassword: const [],
      createdAt: child.createdAt,
      updatedAt: now,
      lastSession: null,
      totalTimeSpent: 0,
      activitiesCompleted: 0,
      currentMood: ChildMoods.happy,
      learningStyle: LearningStyles.visual,
      specialNeeds: const [],
      accessibilityNeeds: const [],
      avatarPath: AppConstants.defaultChildAvatar,
    );
  }

  Child _profileToChild(ChildProfile profile) {
    return Child(
      id: profile.id,
      parentId: profile.parentId,
      name: profile.name,
      createdAt: profile.createdAt,
    );
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
