import 'package:injectable/injectable.dart';
import 'package:produtos_test/features/produtos/data/datasources/busca_produtos_na_api_datasource.dart';
import 'package:produtos_test/features/produtos/data/datasources/busca_produtos_em_cache_hive_datasource.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/produto_entity.dart';
import '../../domain/repositories/produto_repository.dart';

@LazySingleton(as: ProdutoRepository)
class ProdutosRepositoryImpl implements ProdutoRepository {
  final BuscaProdutosNaApiDatasource buscaHiveCahceDatasource;
  final BuscaProdutosEmCacheHiveDatasource buscaAPI;

  ProdutosRepositoryImpl(
    this.buscaHiveCahceDatasource,
    this.buscaAPI,
  );

  @override
  Future<List<ProdutoEntity>> getProducts() async {
    try {
      // Busca API
      final products = await buscaHiveCahceDatasource.getProducts();

      // Salva cache
      await buscaAPI.cacheProducts(
        products,
      );

      return products;
    } on NetworkException {
      //  se tiver um problema na internet ele busca do cache
      final cachedProducts = await buscaAPI.getCachedProducts();

      if (cachedProducts.isNotEmpty) {
        return cachedProducts;
      }

      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ProdutoEntity> getProductById(
    int id,
  ) async {
    try {
      return await buscaHiveCahceDatasource.getProductById(id);
    } catch (_) {
      rethrow;
    }
  }
}
