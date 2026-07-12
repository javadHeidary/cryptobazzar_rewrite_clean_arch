import 'package:cryptobazzar_refactor_clean_arch/core/network/dio_clinet.dart';
import 'package:cryptobazzar_refactor_clean_arch/data/datasources/coin_datasource.dart';
import 'package:cryptobazzar_refactor_clean_arch/data/datasources/coin_remote_datasource.dart';
import 'package:cryptobazzar_refactor_clean_arch/data/repositories/coin_repository_impl.dart';
import 'package:cryptobazzar_refactor_clean_arch/domain/repositories/coin_repository.dart';
import 'package:cryptobazzar_refactor_clean_arch/domain/usecase/coin_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt di = GetIt.instance;

Future<void> setUpLocator() async {
  await _initServices();
  await _initDataSources();
  await _initRepositories();
  await _initUseCases();
}

// services

Future<void> _initServices() async {
  if (!di.isRegistered<Dio>()) {
    di.registerSingleton<Dio>(DioClinet.instant);
  }
}

// Data Sources

Future<void> _initDataSources() async {
  if (!di.isRegistered<CoinDatasource>()) {
    di.registerSingleton<CoinDatasource>(CoinRemoteDatasource(di.get<Dio>()));
  }
}

// Repositories

Future<void> _initRepositories() async {
  if (!di.isRegistered<CoinRepository>()) {
    di.registerSingleton<CoinRepository>(
      CoinRepositoryImpl(di.get<CoinDatasource>()),
    );
  }
}

// Usecase

Future<void> _initUseCases() async {
  if (!di.isRegistered<CoinUsecase>()) {
    di.registerSingleton<CoinUsecase>(
      CoinListUseCase(di.get<CoinRepository>()),
    );
  }
}
