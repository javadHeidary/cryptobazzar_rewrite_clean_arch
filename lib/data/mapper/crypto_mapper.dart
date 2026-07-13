import 'package:cryptoBazzar/data/dtos/crypto_dto.dart';
import 'package:cryptoBazzar/domain/entities/crypto.dart';

class CryptoMapper {
  static Crypto toDomain(CryptoDto dtoObject) {
    return Crypto(
      dtoObject.id,
      dtoObject.name,
      dtoObject.symbol,
      double.parse(dtoObject.changePercent24hr),
      double.parse(dtoObject.priceUsd),
      double.parse(dtoObject.marketCapUsd),
      int.parse(dtoObject.rank),
    );
  }

  static List<Crypto> toDomainList(List<CryptoDto> dtos) =>
      dtos.map((toElement) => toDomain(toElement)).toList();
}
