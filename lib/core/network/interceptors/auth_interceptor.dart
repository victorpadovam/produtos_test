import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../storage/secure_storage_service.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final SecureStorageService secureStorageService;

  AuthInterceptor(this.secureStorageService);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorageService.readToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }
}
