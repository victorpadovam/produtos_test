import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:produtos_test/core/error/exceptions.dart';
import 'package:produtos_test/core/network/dio_client.dart';
import 'package:produtos_test/features/produtos/data/datasources/busca_produtos_na_api_datasource.dart';

class MockDio extends Mock implements Dio {}

class MockDioClient extends Mock implements DioClient {}

void main() {
  late ProductsRemoteDatasourceImpl datasource;

  late MockDioClient mockDioClient;

  late MockDio mockDio;

  setUp(() {
    mockDioClient = MockDioClient();

    mockDio = MockDio();

    when(() => mockDioClient.dio).thenReturn(
      mockDio,
    );

    datasource = ProductsRemoteDatasourceImpl(
      mockDioClient,
    );
  });

  test(
    'deve retornar lista de produtos',
    () async {
      when(
        () => mockDio.get('/products'),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(
            path: '/products',
          ),
          statusCode: 200,
          data: [
            {
              'id': 1,
              'title': 'Produto Teste',
              'price': 10.0,
              'description': 'Descrição',
              'category': 'Categoria',
              'image': 'image.png',
              'rating': {
                'rate': 4.5,
                'count': 100,
              },
            },
          ],
        ),
      );

      final result = await datasource.getProducts();

      expect(result.length, 1);

      expect(result.first.title, 'Produto Teste');
    },
  );

  test(
    'deve lançar NetworkException',
    () async {
      when(
        () => mockDio.get('/products'),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(
            path: '/products',
          ),
        ),
      );

      expect(
        () => datasource.getProducts(),
        throwsA(isA<NetworkException>()),
      );
    },
  );
}
