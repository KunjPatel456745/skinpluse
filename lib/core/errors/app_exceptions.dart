sealed class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException([super.message = "No internet connection. Please check your connection and try again."]);
}

class ServerException extends AppException {
  ServerException([super.message = "Something went wrong on our end. Please try again in a moment."]);
}

class GeminiException extends AppException {
  GeminiException([super.message = "Analysis failed. Please try again."]);
}

class UploadException extends AppException {
  UploadException([super.message = "Could not upload photos. Please try again."]);
}

class AuthException extends AppException {
  AuthException([super.message = "Authentication failed."]);
}

class RateLimitException extends AppException {
  RateLimitException([super.message = "You've reached your daily limit. Try again tomorrow."]);
}

class SessionExpiredException extends AppException {
  SessionExpiredException([super.message = "Your session expired. Please sign in again."]);
}
