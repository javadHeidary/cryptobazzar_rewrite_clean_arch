part of 'coin_list_bloc.dart';

@immutable
sealed class CoinListState {}

final class CoinListInitialState extends CoinListState {}

final class CoinLoadingState extends CoinListState {}

final class CoinListSuccessState extends CoinListState {
  final List<Crypto> cryptos;
  CoinListSuccessState({required this.cryptos});
}

final class CoinListFailedState extends CoinListState {
  final String message;
  CoinListFailedState({required this.message});
}
