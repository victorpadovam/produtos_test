import 'package:injectable/injectable.dart';

import '../../../../core/storage/secure_storage_service.dart';

abstract class AuthLocalDatasource {
  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> deleteToken();
}

@LazySingleton(as: AuthLocalDatasource)
class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SecureStorageService secureStorageService;

  AuthLocalDatasourceImpl(
    this.secureStorageService,
  );

  @override
  Future<void> saveToken(String token) async {
    await secureStorageService.saveToken(token);
  }

  @override
  Future<String?> getToken() async {
    return secureStorageService.readToken();
  }

  @override
  Future<void> deleteToken() async {
    await secureStorageService.deleteToken();
  }
}
