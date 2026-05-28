import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/hive_service.dart';
import '../models/produto_model.dart';

abstract class BuscaProdutosEmCacheHiveDatasource {
  Future<void> cacheProducts(
    List<ProdutoModel> products,
  );

  Future<List<ProdutoModel>> getCachedProducts();

  Future<void> clearCache();
}

@LazySingleton(as: BuscaProdutosEmCacheHiveDatasource)
class ProductsLocalDatasourceImpl
    implements BuscaProdutosEmCacheHiveDatasource {
  final HiveService hiveService;

  ProductsLocalDatasourceImpl(
    this.hiveService,
  );

  static const String productsKey = 'produtos_em_cache';

  //SALVAR lista de produtos no HIVE
  @override
  Future<void> cacheProducts(
    List<ProdutoModel> products,
  ) async {
    try {
      final box = hiveService.getProductsBox();

      await box.put(
        productsKey,
        products,
      );
    } catch (_) {
      throw CacheException();
    }
  }

  //BUSCAR lista de produtos no HIVE
  @override
  Future<List<ProdutoModel>> getCachedProducts() async {
    try {
      final box = hiveService.getProductsBox();

      final cachedData = box.get(
        productsKey,
        defaultValue: [],
      );

      if (cachedData == null) {
        return [];
      }

      return cachedData.cast<ProdutoModel>();
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final box = hiveService.getProductsBox();

      await box.delete(productsKey);
    } catch (_) {
      throw CacheException();
    }
  }
}
