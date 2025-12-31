import '../../domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
    required super.description,
    required super.category,
    required super.thumbnail,
    required super.discountPercentage,

  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      image: (json['images'] as List).isNotEmpty
          ? json['images'][0]
          : '',
      description: json['description'],
      category: json['category'],
        thumbnail: json['thumbnail'] as String,
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
    );

  }
}
