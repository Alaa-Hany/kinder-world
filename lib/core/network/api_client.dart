import 'package:dio/dio.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/core/storage/secure_storage.dart';
import 'package:logger/logger.dart';

class ApiClient {
  final Dio _dio;
  final Dio _refreshDio;
  final SecureStorage _secureStorage;
  final Logger _logger;
  final void Function() _onUnauthorized;

  Future<String?>? _refreshFuture;

  ApiClient({
    Dio? dio,
    Dio? refreshDio,
    required SecureStorage secureStorage,
    Logger? logger,
    void Function()? onUnauthorized,
  })  : _dio = dio ?? Dio(),
        _refreshDio = refreshDio ?? Dio(),
        _secureStorage = secureStorage,
        _logger = logger ?? Logger(),
        _onUnauthorized = onUnauthorized ?? (() {}) {
    _setupDio();
  }

  void _setupDio() {
    final options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.apiTimeout,
      receiveTimeout: AppConstants.apiTimeout,
      sendTimeout: AppConstants.apiTimeout,
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio.options = options;
    _refreshDio.options = options;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (options.extra['skipAuth'] != true) {
            final token = await _secureStorage.getAuthToken();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }

          _logger.d('Request: ${options.method} ${options.uri}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.d(
            'Response: ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.uri}',
          );
          handler.next(response);
        },
        onError: (error, handler) async {
          final statusCode = error.response?.statusCode;
          final requestOptions = error.requestOptions;

          final shouldRefresh = statusCode == 401 &&
              requestOptions.extra['retry'] != true &&
              requestOptions.extra['skipRefresh'] != true;

          if (shouldRefresh) {
            final newToken = await _refreshAccessToken();
            if (newToken != null && newToken.isNotEmpty) {
              requestOptions.headers['Authorization'] = 'Bearer $newToken';
              requestOptions.extra['retry'] = true;

              try {
                final response = await _dio.fetch(requestOptions);
                return handler.resolve(response);
              } on DioException catch (retryError) {
                return handler.next(retryError);
              }
            } else {
              await _secureStorage.clearAuthData();
              _onUnauthorized();
            }
          }

          _logger.e(
            'Error: ${statusCode ?? 'NO_STATUS'} ${requestOptions.method} ${requestOptions.uri} ${error.message}',
          );
          handler.next(error);
        },
      ),
    );

    assert(() {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
      return true;
    }());
  }

  Future<String?> _refreshAccessToken() async {
    if (_refreshFuture != null) {
      return await _refreshFuture!;
    }

    _refreshFuture = _refreshToken();
    try {
      return await _refreshFuture!;
    } finally {
      _refreshFuture = null;
    }
  }

  Future<String?> _refreshToken() async {
    final refreshToken = await _secureStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    try {
      final response = await _refreshDio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
        options: Options(extra: {'skipAuth': true, 'skipRefresh': true}),
      );

      final data = response.data;
      if (data == null) return null;

      final accessToken = data['access_token'] as String?;
      if (accessToken == null || accessToken.isEmpty) return null;

      await _secureStorage.saveAuthToken(accessToken);
      return accessToken;
    } on DioException catch (e) {
      _logger.e('Refresh token failed: ${e.response?.statusCode}');
      return null;
    }
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  void close() {
    _dio.close();
    _refreshDio.close();
  }
}
