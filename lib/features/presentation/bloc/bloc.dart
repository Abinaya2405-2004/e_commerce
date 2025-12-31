import 'package:e_commerce/features/domain/usecase/serach_usecase.dart';
import 'package:e_commerce/features/presentation/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/usecase/product_usecase.dart';

import 'event.dart' show FetchProductsEvent, ProductEvent, SearchProductEvent, FilterByCategoryEvent;

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final SearchProductsUseCase searchProductsUseCase;
  List<ProductEntity> allProducts = [];

  ProductBloc(this.getProductsUseCase, this.searchProductsUseCase)
    : super(ProductInitial()) {
    on<FetchProductsEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await getProductsUseCase();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<SearchProductEvent>((event, emit) async {
      emit(ProductLoading());
      final products = await searchProductsUseCase(event.query);
      emit(ProductLoaded(products));
    });
    on<FilterByCategoryEvent>((event, emit) {
      final filteredProducts = allProducts
          .where((p) => p.category == event.category)
          .toList();

      emit(ProductLoaded(filteredProducts));
    });

  }
}
