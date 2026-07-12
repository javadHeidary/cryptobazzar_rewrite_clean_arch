import 'package:cryptobazzar_refactor_clean_arch/domain/entities/crypto.dart';
import 'package:cryptobazzar_refactor_clean_arch/domain/repositories/coin_repository.dart';

abstract class CoinUsecase {
  Future<List<Crypto>> getCoinList();
}

class CoinListUseCase implements CoinUsecase {
  final CoinRepository _coinRepository;
  CoinListUseCase(this._coinRepository);

  @override
  Future<List<Crypto>> getCoinList() async {
    return await _coinRepository.getCoinList();
  }
}
