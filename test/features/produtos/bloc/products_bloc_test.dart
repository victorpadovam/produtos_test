import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:produtos_test/features/produtos/domain/entities/produto_entity.dart';
import 'package:produtos_test/features/produtos/domain/usecases/busca_produto_usecase.dart';
import 'package:produtos_test/features/produtos/presentation/bloc/produto_bloc.dart';
import 'package:produtos_test/features/produtos/presentation/bloc/produto_event.dart';
import 'package:produtos_test/features/produtos/presentation/bloc/produto_state.dart';

class MockGetProductsUseCase extends Mock implements BuscaProdutoUsecase {}

void main() {
  late ProductsBloc bloc;

  late MockGetProductsUseCase mockGetProductsUseCase;

  setUp(() {
    mockGetProductsUseCase = MockGetProductsUseCase();

    bloc = ProductsBloc(
      mockGetProductsUseCase,
    );
  });

  final products = [
    ProdutoEntity(
      id: 1,
      title: 'Produto Teste',
      price: 10.0,
      description: 'Descrição',
      category: 'Categoria',
      image: 'image.png',
      rating: 4.5,
      ratingCount: 100,
    ),
  ];

  blocTest<ProductsBloc, ProductsState>(
    'deve emitir "carregando"',
    build: () {
      when(
        () => mockGetProductsUseCase(),
      ).thenAnswer(
        (_) async => products,
      );

      return bloc;
    },
    act: (bloc) => bloc.add(
      LoadProducts(),
    ),
    expect: () => [
      ProductsLoading(),
      ProductsLoaded(products),
    ],
  );

  blocTest<ProductsBloc, ProductsState>(
    'Deve emitir um aviso de carregamento e um erro em caso de falha.',
    build: () {
      when(
        () => mockGetProductsUseCase(),
      ).thenThrow(
        Exception(),
      );

      return bloc;
    },
    act: (bloc) => bloc.add(
      LoadProducts(),
    ),
    expect: () => [
      ProductsLoading(),
      isA<ProductsError>(),
    ],
  );
}
