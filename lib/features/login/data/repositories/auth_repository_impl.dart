import 'package:injectable/injectable.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource localDatasource;

  AuthRepositoryImpl(this.localDatasource);

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    String tokenDaRequest = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXV';
    await localDatasource.saveToken(
      tokenDaRequest,
    );
  }

  @override
  Future<void> logout() async {
    await localDatasource.deleteToken();
  }

  @override
  Future<bool> isLogged() async {
    final token = await localDatasource.getToken();

    return token != null;
  }
}
