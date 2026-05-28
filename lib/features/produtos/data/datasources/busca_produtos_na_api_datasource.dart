import 'package:injectable/injectable.dart';
import 'package:produtos_test/core/network/dio_client.dart';

import '../../../../core/error/exceptions.dart';
import '../models/produto_model.dart';

abstract class BuscaProdutosNaApiDatasource {
  Future<List<ProdutoModel>> getProducts();

  Future<ProdutoModel> getProductById(int id);
}

@LazySingleton(as: BuscaProdutosNaApiDatasource)
class ProductsRemoteDatasourceImpl implements BuscaProdutosNaApiDatasource {
  final DioClient dioClient;

  ProductsRemoteDatasourceImpl(this.dioClient);

  @override
  Future<List<ProdutoModel>> getProducts() async {
    try {
      final response = await dioClient.dio.get('/products');

      if (response.statusCode == 200) {
        final List data = response.data;

        return data.map((json) => ProdutoModel.fromJson(json)).toList();
      }

      throw ServerException();
    } catch (_) {
      throw NetworkException();
    }
  }

  @override
  Future<ProdutoModel> getProductById(int id) async {
    try {
      final response = await dioClient.dio.get('/products/$id');

      if (response.statusCode == 200) {
        return ProdutoModel.fromJson(response.data);
      }

      throw ServerException();
    } catch (_) {
      throw NetworkException();
    }
  }
}
