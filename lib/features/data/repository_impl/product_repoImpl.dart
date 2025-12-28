import '../../domain/entity/product_entity.dart';
import '../../domain/repository/product_repository.dart';
import '../data_source/product_datasource.dart' show ProductRemoteDataSource;

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductEntity>> getProducts() async {
    return await remoteDataSource.getProducts();
  }
  @override
  Future<List<ProductEntity>> searchProducts(String query) {
    return remoteDataSource.searchProducts(query);
  }
}
