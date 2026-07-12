import 'dart:developer' as developer;

import 'package:cryptobazzar_refactor_clean_arch/data/datasources/coin_datasource.dart';
import 'package:cryptobazzar_refactor_clean_arch/data/dtos/crypto_dto.dart';
import 'package:cryptobazzar_refactor_clean_arch/data/mapper/crypto_mapper.dart';
import 'package:cryptobazzar_refactor_clean_arch/domain/entities/crypto.dart';
import 'package:dio/dio.dart';

class CoinRemoteDatasource implements CoinDatasource {
  final Dio dioClient;
  List<Crypto> _allCryptoList = [];
  CoinRemoteDatasource(this.dioClient);

  @override
  Future<List<Crypto>> getCoinList() async {
    try {
      final response = await dioClient.get(
        'https://rest.coincap.io/v3/assets?apiKey=2171c853bbbced0fbd43fc0fea73c318f6d83f6683633ceac2a14b0bd56061d0',
      );
      final allCryptosDto = response.data['data']
          .map<CryptoDto>(
            (jsonMapObject) => CryptoDto.fromMapJson(jsonMapObject),
          )
          .toList();

      return _allCryptoList = CryptoMapper.toDomainList(allCryptosDto);
    } catch (e) {
      developer.log(e.toString());
      throw Exception();
    }
  }

  @override
  Future<List<Crypto>> getSearchCoinList({required String searchQuery}) async {
    try {
      return _allCryptoList
          .where(
            (crypto) =>
                crypto.name.toLowerCase().contains(searchQuery.toLowerCase()),
          )
          .toList();
    } catch (e) {
      developer.log(e.toString());
      throw Exception();
    }
  }
}
