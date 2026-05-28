import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../app/flavors/flavor_config.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

@lazySingleton
class DioClient {
  late final Dio dio;

  DioClient(
    AuthInterceptor authInterceptor,
    LoggingInterceptor loggingInterceptor,
    RetryInterceptor retryInterceptor,
  ) {
    dio = Dio(
      BaseOptions(
        baseUrl: FlavorConfig.instance.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.addAll([
      authInterceptor,
      loggingInterceptor,
      retryInterceptor,
    ]);
  }
}
