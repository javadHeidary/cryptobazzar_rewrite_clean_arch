part of 'coin_list_bloc.dart';

@immutable
sealed class CoinListEvent {}

class CoinFetchListEvent extends CoinListEvent {}

class CoinFilterListEvent extends CoinListEvent {
  final String searchQuery;
  CoinFilterListEvent({required this.searchQuery});
}
