
import '../entity/product_entity.dart';

import '../repository/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;
  

  GetProductsUseCase(this.repository);

  Future<List<ProductEntity>> call() {
    return repository.getProducts();

  }
}
