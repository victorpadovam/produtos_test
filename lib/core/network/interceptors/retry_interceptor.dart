import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RetryInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    return handler.next(err);
  }
}
