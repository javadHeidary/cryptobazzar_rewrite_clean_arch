import 'package:dio/dio.dart';

class DioClinet {
  static Dio? _instance;

  static Dio get instant {
    _instance ??= createDio();
    return _instance!;
  }

  static Dio createDio() {
    return Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 5000),
        receiveTimeout: Duration(seconds: 3000),
      ),
    );
  }
}
