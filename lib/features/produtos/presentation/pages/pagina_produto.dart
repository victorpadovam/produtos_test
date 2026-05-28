import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:produtos_test/app/router/app_router.dart';
import 'package:produtos_test/core/storage/secure_storage_service.dart';
import 'package:produtos_test/features/produtos/presentation/widgets/card_produto.dart';

import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../domain/usecases/busca_produto_usecase.dart';
import '../bloc/produto_bloc.dart';
import '../bloc/produto_event.dart';
import '../bloc/produto_state.dart';
import '../../../../app/di/injection.dart';

class PaginaProduto extends StatelessWidget {
  const PaginaProduto({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsBloc(
        getIt<BuscaProdutoUsecase>(),
      )..add(
          LoadProducts(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Produtos'),
          actions: [
            IconButton(
              onPressed: () async {
                final secureStorage = SecureStorageService();

                await secureStorage.deleteToken();

                AppRouter.router.go('/login');
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const AppLoading();
            }

            if (state is ProductsError) {
              return AppErrorWidget(
                message: 'Erro ao retornar produtos',
              );
            }

            if (state is ProductsEmpty) {
              return const EmptyStateWidget(
                message: 'Nenhum produto encontrado',
              );
            }

            if (state is ProductsLoaded) {
              print(state);
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];

                  return CardProduto(
                    product: product,
                    onTap: () {
                      AppRouter.router.push(
                        '/produtos/${product.id}',
                      );
                    },
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
