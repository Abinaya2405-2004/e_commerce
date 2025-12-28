abstract class ProductEvent {}

class FetchProductsEvent extends ProductEvent {}

class SearchProductEvent extends ProductEvent {
  final String query;
  SearchProductEvent(this.query);
}

