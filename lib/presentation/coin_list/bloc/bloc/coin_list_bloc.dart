import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:cryptobazzar_refactor_clean_arch/domain/entities/crypto.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';

class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  CoinListBloc() : super(CoinListInitialState()) {
    on<CoinFetchListEvent>((event, emit) async {
      emit(CoinLoadingState());
      try {
        final response = await Dio().get(
          'https://rest.coincap.io/v3/assets?apiKey=658ec474b1f482e18ab745c9b26c4cb4a9a4f31486679c749c0e65b8d9b1ab25',
        );
        List<Crypto> cryptoList = response.data['data']
            .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
            .toList();
        emit(CoinListSuccessState(cryptos: cryptoList));
      } on DioException catch (e) {
        emit(CoinListFailedState(message: _translateException(e)));
      } catch (e) {
        developer.log(e.toString());
        CoinListFailedState(message: 'خطایی در پردازش اطلاعات رخ داد است');
      }
    });

    on<CoinFilterListEvent>((event, emit) async {
      emit(CoinLoadingState());
      try {
        final response = await Dio().get(
          'https://rest.coincap.io/v3/assets?apiKey=658ec474b1f482e18ab745c9b26c4cb4a9a4f31486679c749c0e65b8d9b1ab25',
        );
        List<Crypto> cryptoList = response.data['data']
            .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
            .where(
              (crypto) => crypto.name.toLowerCase().contains(
                event.searchQuery.toLowerCase(),
              ),
            )
            .toList();
        emit(CoinListSuccessState(cryptos: cryptoList));
      } on DioException catch (e) {
        final message = _translateException(e);
        emit(CoinListFailedState(message: message));
      } catch (e) {
        developer.log(e.toString());
        emit(
          CoinListFailedState(message: 'خطایی در پردازش اطلاعات رخ داد است'),
        );
      }
    });
  }

  String _translateException(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout => 'زمان اتصال به سرور به پایان رسید',

      DioExceptionType.sendTimeout => 'ارسال اطلاعات بیش از حد طول کشید',

      DioExceptionType.receiveTimeout => 'دریافت اطلاعات بیش از حد طول کشید',

      DioExceptionType.connectionError => 'اتصال اینترنت خود را بررسی کنید',

      DioExceptionType.badResponse => 'خطایی از سمت سرور رخ داده است',

      DioExceptionType.cancel => 'درخواست لغو شد',

      _ => 'خطای ناشناخته‌ای رخ داده است',
    };
  }
}
