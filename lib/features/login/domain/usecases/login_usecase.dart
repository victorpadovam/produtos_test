import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';

@lazySingleton
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<void> call({
    required String email,
    required String password,
  }) {
    return repository.login(
      email: email,
      password: password,
    );
  }
}
