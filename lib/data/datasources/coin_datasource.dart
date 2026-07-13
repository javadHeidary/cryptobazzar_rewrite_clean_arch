import 'package:cryptoBazzar/domain/entities/crypto.dart';

abstract class CoinDatasource {
  Future<List<Crypto>> getCoinList();
  Future<List<Crypto>> getSearchCoinList({required String searchQuery});
}
