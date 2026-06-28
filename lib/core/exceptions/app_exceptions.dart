class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  AppException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => message;
}

class AuthenticationException extends AppException {
  AuthenticationException({required String message, String? code})
      : super(message: message, code: code);
}

class FirebaseException extends AppException {
  FirebaseException({required String message, String? code})
      : super(message: message, code: code);
}

class NetworkException extends AppException {
  NetworkException({required String message})
      : super(message: message);
}

class ValidationException extends AppException {
  ValidationException({required String message})
      : super(message: message);
}
