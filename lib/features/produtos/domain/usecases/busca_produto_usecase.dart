import 'package:injectable/injectable.dart';

import '../entities/produto_entity.dart';
import '../repositories/produto_repository.dart';

@lazySingleton
class BuscaProdutoUsecase {
  final ProdutoRepository repository;

  BuscaProdutoUsecase(this.repository);

  Future<List<ProdutoEntity>> call() {
    return repository.getProducts();
  }
}
