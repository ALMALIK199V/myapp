// marketplace_event.dart
part of 'marketplace_bloc.dart';

abstract class MarketplaceEvent {}

class LoadProductsEvent extends MarketplaceEvent {}
class LoadCategoriesEvent extends MarketplaceEvent {}
class SearchProductsEvent extends MarketplaceEvent {
  final String query;
  SearchProductsEvent(this.query);
}
class FilterProductsEvent extends MarketplaceEvent {
  final String category;
  FilterProductsEvent(this.category);
}