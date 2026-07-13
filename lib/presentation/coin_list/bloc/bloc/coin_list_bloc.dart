import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:cryptoBazzar/domain/entities/crypto.dart';
import 'package:cryptoBazzar/domain/usecase/coin_usecase.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';

class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  final CoinUsecase _coinUsecase;
  List<Crypto> _allCryptos = [];
  CoinListBloc(this._coinUsecase) : super(CoinListInitialState()) {
    on<CoinFetchListEvent>((event, emit) async {
      emit(CoinLoadingState());
      try {
        _allCryptos = await _coinUsecase.getCoinList();
        emit(CoinListSuccessState(cryptos: _allCryptos));
      } on DioException catch (e) {
        emit(CoinListFailedState(message: _translateException(e)));
      } catch (e) {
        developer.log(e.toString());
        emit(
          CoinListFailedState(message: 'خطایی در پردازش اطلاعات رخ داد است'),
        );
      }
    });

    on<CoinFilterListEvent>((event, emit) async {
      try {
        List<Crypto> filterCryptos = await _coinUsecase.getSearchCoinList(
          searchQuery: event.searchQuery,
        );
        emit(CoinListSuccessState(cryptos: filterCryptos));
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
