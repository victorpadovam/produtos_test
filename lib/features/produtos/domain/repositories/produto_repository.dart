import '../entities/produto_entity.dart';

abstract class ProdutoRepository {
  Future<List<ProdutoEntity>> getProducts();

  Future<ProdutoEntity> getProductById(
    int id,
  );
}
