class CryptoDto {
  String id;
  String name;
  String symbol;
  String changePercent24hr;
  String priceUsd;
  String marketCapUsd;
  String rank;

  CryptoDto(
    this.id,
    this.name,
    this.symbol,
    this.changePercent24hr,
    this.priceUsd,
    this.marketCapUsd,
    this.rank,
  );

  factory CryptoDto.fromMapJson(Map<String, dynamic> jsonMapObject) {
    return CryptoDto(
      jsonMapObject['id'],
      jsonMapObject['name'],
      jsonMapObject['symbol'],
      jsonMapObject['changePercent24Hr'],
      jsonMapObject['priceUsd'],
      jsonMapObject['marketCapUsd'],
      jsonMapObject['rank'],
    );
  }
}
