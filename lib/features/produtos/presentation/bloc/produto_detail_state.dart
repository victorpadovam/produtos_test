import 'package:produtos_test/features/produtos/domain/entities/produto_entity.dart';

import 'package:equatable/equatable.dart';

abstract class ProductDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final ProdutoEntity product;

  ProductDetailLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductDetailError extends ProductDetailState {
  final String message;

  ProductDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
