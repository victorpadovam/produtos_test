import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:produtos_test/app/di/injection.dart';

import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../domain/usecases/busca_detalhes_do_produto_usecase.dart';
import '../bloc/produto_detail_bloc.dart';
import '../bloc/produto_detail_event.dart';
import '../bloc/produto_detail_state.dart';

class DetalhesDoProduto extends StatelessWidget {
  final int productId;

  const DetalhesDoProduto({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailBloc(
        getIt<BuscaDetalhesDoProdutoUsecase>(),
      )..add(
          LoadProductDetail(productId),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Detalhe do Produto',
          ),
        ),
        body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              return const AppLoading();
            }

            if (state is ProductDetailError) {
              return AppErrorWidget(
                message: state.message,
              );
            }

            if (state is ProductDetailLoaded) {
              final product = state.product;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        product.image,
                        height: 250,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      product.category,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'R\$ ${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      product.description,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${product.rating} (${product.ratingCount} avaliações)',
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
