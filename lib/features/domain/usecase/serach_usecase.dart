import '../entity/product_entity.dart';
import '../repository/product_repository.dart' show ProductRepository;

class SearchProductsUseCase {
  final ProductRepository repository;
  SearchProductsUseCase(this.repository);

  Future<List<ProductEntity>> call(String query) {
    return repository.searchProducts(query);
  }
}
