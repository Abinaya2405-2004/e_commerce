abstract class ProductEvent {}

class FetchProductsEvent extends ProductEvent {}

class SearchProductEvent extends ProductEvent {
  final String query;
  SearchProductEvent(this.query);
}

class FilterByCategoryEvent extends ProductEvent {
  final String category;
  FilterByCategoryEvent(this.category);
}
