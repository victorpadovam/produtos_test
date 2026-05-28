import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';

@lazySingleton
class CheckAuthUseCase {
  final AuthRepository repository;

  CheckAuthUseCase(this.repository);

  Future<bool> call() {
    return repository.isLogged();
  }
}
