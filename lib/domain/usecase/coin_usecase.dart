import 'package:cryptoBazzar/domain/entities/crypto.dart';
import 'package:cryptoBazzar/domain/repositories/coin_repository.dart';

abstract class CoinUsecase {
  Future<List<Crypto>> getCoinList();
  Future<List<Crypto>> getSearchCoinList({required String searchQuery});
}

class CoinListUseCase implements CoinUsecase {
  final CoinRepository _coinRepository;
  CoinListUseCase(this._coinRepository);

  @override
  Future<List<Crypto>> getCoinList() async {
    return await _coinRepository.getCoinList();
  }

  @override
  Future<List<Crypto>> getSearchCoinList({required String searchQuery}) async {
    return await _coinRepository.getSearchCoinList(searchQuery: searchQuery);
  }
}
