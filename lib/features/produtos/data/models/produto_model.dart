import 'package:hive/hive.dart';
import 'package:produtos_test/features/produtos/domain/entities/produto_entity.dart';

part 'produto_model.g.dart';

@HiveType(typeId: 0)
class ProdutoModel extends ProdutoEntity {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double price;

  @HiveField(3)
  String description;

  @HiveField(4)
  String category;

  @HiveField(5)
  String image;

  @HiveField(6)
  double rating;

  @HiveField(7)
  int ratingCount;

  ProdutoModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.ratingCount,
  }) : super(
          id: id,
          title: title,
          price: price,
          description: description,
          category: category,
          image: image,
          rating: rating,
          ratingCount: ratingCount,
        );

  factory ProdutoModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProdutoModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: (json['rating']['rate'] as num).toDouble(),
      ratingCount: json['rating']['count'],
    );
  }

  ProdutoEntity toEntity() {
    return ProdutoEntity(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating,
      ratingCount: ratingCount,
    );
  }
}
