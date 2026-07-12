import 'package:cryptobazzar_refactor_clean_arch/domain/entities/crypto.dart';

abstract class CoinRepository {
  Future<List<Crypto>> getCoinList();
}
