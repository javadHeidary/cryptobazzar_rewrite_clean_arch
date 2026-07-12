import 'package:cryptobazzar_refactor_clean_arch/domain/entities/crypto.dart';

abstract class CoinDatasource {
  Future<List<Crypto>> getCoinList();
  Future<List<Crypto>> getSearchCoinList({required String searchQuery});
}
