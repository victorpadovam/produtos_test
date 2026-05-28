abstract class ProductDetailEvent {}

class LoadProductDetail extends ProductDetailEvent {
  final int id;

  LoadProductDetail(this.id);
}
