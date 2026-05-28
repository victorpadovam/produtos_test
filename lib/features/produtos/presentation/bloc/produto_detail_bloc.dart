import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:produtos_test/features/produtos/domain/usecases/busca_detalhes_do_produto_usecase.dart';

import 'produto_detail_event.dart';
import 'produto_detail_state.dart';

@injectable
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final BuscaDetalhesDoProdutoUsecase buscaDetalhesDoProdutoUsecase;

  ProductDetailBloc(
    this.buscaDetalhesDoProdutoUsecase,
  ) : super(ProductDetailInitial()) {
    on<LoadProductDetail>(
      _onLoadProductDetail,
    );
  }

  Future<void> _onLoadProductDetail(
    LoadProductDetail event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoading());

    try {
      final product = await buscaDetalhesDoProdutoUsecase(
        event.id,
      );

      emit(
        ProductDetailLoaded(product),
      );
    } catch (_) {
      emit(
        ProductDetailError(
          'Erro ao carregar produto',
        ),
      );
    }
  }
}
