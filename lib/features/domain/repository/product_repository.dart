import '../entity/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts();
  Future<List<ProductEntity>> searchProducts(String query);
}
