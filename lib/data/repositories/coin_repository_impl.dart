import 'package:cryptoBazzar/data/datasources/coin_datasource.dart';
import 'package:cryptoBazzar/domain/entities/crypto.dart';
import 'package:cryptoBazzar/domain/repositories/coin_repository.dart';

class CoinRepositoryImpl implements CoinRepository {
  final CoinDatasource _coinDatasource;
  CoinRepositoryImpl(this._coinDatasource);
  @override
  Future<List<Crypto>> getCoinList() {
    return _coinDatasource.getCoinList();
  }

  @override
  Future<List<Crypto>> getSearchCoinList({required String searchQuery}) {
    return _coinDatasource.getSearchCoinList(searchQuery: searchQuery);
  }
}
