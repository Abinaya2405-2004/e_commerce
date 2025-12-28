import 'package:dio/dio.dart';

import '../../../../core/network/api_connection.dart';
import '../../../core/network/api_route.dart';
import '../model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> searchProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiConnection apiConnection;

  ProductRemoteDataSourceImpl(this.apiConnection);

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    final response = await apiConnection.get(
      ApiRoute.searchProduct,
      queryParams: {'q': query},
    );

    return (response.data['products'] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
@override
  Future<List<ProductModel>> getProducts() async {
    try {
      final Response response = await apiConnection.get(ApiRoute.product);
      final productsList = response.data['products'] as List;

      return productsList.map((e) => ProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
