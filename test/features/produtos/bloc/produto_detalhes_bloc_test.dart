import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:produtos_test/features/produtos/domain/entities/produto_entity.dart';
import 'package:produtos_test/features/produtos/domain/usecases/busca_detalhes_do_produto_usecase.dart';
import 'package:produtos_test/features/produtos/presentation/bloc/produto_detail_bloc.dart';
import 'package:produtos_test/features/produtos/presentation/bloc/produto_detail_event.dart';
import 'package:produtos_test/features/produtos/presentation/bloc/produto_detail_state.dart';

class MockGetProductDetailUseCase extends Mock
    implements BuscaDetalhesDoProdutoUsecase {}

void main() {
  late ProductDetailBloc bloc;
  late MockGetProductDetailUseCase mockGetProductDetailUseCase;

  setUp(() {
    mockGetProductDetailUseCase = MockGetProductDetailUseCase();

    bloc = ProductDetailBloc(
      mockGetProductDetailUseCase,
    );
  });

  final product = ProdutoEntity(
    id: 1,
    title: 'Produto Teste',
    price: 10,
    description: 'Descrição',
    category: 'Categoria',
    image: 'image.png',
    rating: 4.5,
    ratingCount: 100,
  );

  blocTest<ProductDetailBloc, ProductDetailState>(
    'deve emitir carregando',
    build: () {
      when(
        () => mockGetProductDetailUseCase(
          any(),
        ),
      ).thenAnswer(
        (_) async => product,
      );

      return bloc;
    },
    act: (bloc) => bloc.add(
      LoadProductDetail(1),
    ),
    expect: () => [
      ProductDetailLoading(),
      ProductDetailLoaded(product),
    ],
  );

  blocTest<ProductDetailBloc, ProductDetailState>(
    'Deve emitir um aviso de carregamento e um erro em caso de falha.',
    build: () {
      when(
        () => mockGetProductDetailUseCase(
          any(),
        ),
      ).thenThrow(
        Exception(),
      );

      return bloc;
    },
    act: (bloc) => bloc.add(
      LoadProductDetail(1),
    ),
    expect: () => [
      ProductDetailLoading(),
      isA<ProductDetailError>(),
    ],
  );
}
