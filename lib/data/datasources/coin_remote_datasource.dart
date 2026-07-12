import 'dart:developer' as developer;

import 'package:cryptobazzar_refactor_clean_arch/data/datasources/coin_datasource.dart';
import 'package:cryptobazzar_refactor_clean_arch/domain/entities/crypto.dart';
import 'package:dio/dio.dart';

class CoinRemoteDatasource implements CoinDatasource {
  final Dio dioClient;
  CoinRemoteDatasource(this.dioClient);

  @override
  Future<List<Crypto>> getCoinList() async {
    List<Crypto> allCryptos = [];
    try {
      final response = await dioClient.get(
        'https://rest.coincap.io/v3/assets?apiKey=658ec474b1f482e18ab745c9b26c4cb4a9a4f31486679c749c0e65b8d9b1ab25',
      );
      allCryptos = response.data['data']
          .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
          .toList();

      return allCryptos;
    } on DioException catch (e) {
      developer.log(e.toString());
      return [];
    } catch (e) {
      developer.log(e.toString());
      return [];
    }
  }
}
