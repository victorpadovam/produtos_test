import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:produtos_test/features/produtos/domain/usecases/busca_produto_usecase.dart';

import 'produto_event.dart';
import 'produto_state.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final BuscaProdutoUsecase buscaProdutoUsecase;

  ProductsBloc(
    this.buscaProdutoUsecase,
  ) : super(ProductsInitial()) {
    on<LoadProducts>(_onLoadProducts);

    on<RetryLoadProducts>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
    ProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());

    try {
      final products = await buscaProdutoUsecase();

      if (products.isEmpty) {
        emit(ProductsEmpty());

        return;
      }

      emit(
        ProductsLoaded(products),
      );
    } catch (_) {
      emit(
        ProductsError(
          'Erro ao carregar produtos',
        ),
      );
    }
  }
}
