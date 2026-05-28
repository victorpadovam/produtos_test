import 'package:produtos_test/features/produtos/domain/entities/produto_entity.dart';

import 'package:equatable/equatable.dart';

abstract class ProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProdutoEntity> products;

  ProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductsEmpty extends ProductsState {}

class ProductsError extends ProductsState {
  final String message;

  ProductsError(this.message);

  @override
  List<Object?> get props => [message];
}
