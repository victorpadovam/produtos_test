import 'package:injectable/injectable.dart';

import '../entities/produto_entity.dart';
import '../repositories/produto_repository.dart';

@lazySingleton
class BuscaDetalhesDoProdutoUsecase {
  final ProdutoRepository repository;

  BuscaDetalhesDoProdutoUsecase(
    this.repository,
  );

  Future<ProdutoEntity> call(int id) {
    return repository.getProductById(id);
  }
}
