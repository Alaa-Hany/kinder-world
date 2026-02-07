import 'package:kinder_world/core/models/user.dart';

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final User user;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String? ?? 'bearer',
      user: _parseUser(json['user'] as Map<String, dynamic>),
    );
  }
}

class RefreshResponse {
  final String accessToken;
  final String tokenType;

  RefreshResponse({
    required this.accessToken,
    required this.tokenType,
  });

  factory RefreshResponse.fromJson(Map<String, dynamic> json) {
    return RefreshResponse(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String? ?? 'bearer',
    );
  }
}

class MeResponse {
  final User user;

  MeResponse({required this.user});

  factory MeResponse.fromJson(Map<String, dynamic> json) {
    return MeResponse(
      user: _parseUser(json['user'] as Map<String, dynamic>),
    );
  }
}

User _parseUser(Map<String, dynamic> json) {
  final data = Map<String, dynamic>.from(json);
  final id = data['id'];
  if (id != null) {
    data['id'] = id.toString();
  }
  return User.fromJson(data);
}
