import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/app_config.dart';
import '../errors/app_exceptions.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.supabaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final session = Supabase.instance.client.auth.currentSession;
          if (session != null) {
            options.headers['Authorization'] = 'Bearer ${session.accessToken}';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          final statusCode = e.response?.statusCode;
          AppException exception;

          if (statusCode == 401) {
            exception = SessionExpiredException();
          } else if (statusCode == 429) {
            exception = RateLimitException();
          } else if (e.type == DioExceptionType.connectionTimeout ||
                     e.type == DioExceptionType.connectionError ||
                     e.type == DioExceptionType.receiveTimeout) {
            exception = NetworkException();
          } else {
            exception = ServerException();
          }

          return handler.reject(
            DioException(
              requestOptions: e.requestOptions,
              response: e.response,
              type: e.type,
              error: exception,
            ),
          );
        },
      ),
    );
  }

  Dio get dio => _dio;
}
