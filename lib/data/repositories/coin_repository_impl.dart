import 'package:cryptobazzar_refactor_clean_arch/data/datasources/coin_datasource.dart';
import 'package:cryptobazzar_refactor_clean_arch/domain/entities/crypto.dart';
import 'package:cryptobazzar_refactor_clean_arch/domain/repositories/coin_repository.dart';

class CoinRepositoryImpl implements CoinRepository {
  final CoinDatasource _coinDatasource;
  CoinRepositoryImpl(this._coinDatasource);
  @override
  Future<List<Crypto>> getCoinList() {
    return _coinDatasource.getCoinList();
  }
}
