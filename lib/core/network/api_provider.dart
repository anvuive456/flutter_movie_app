import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

@singleton
class ApiProvider {
  late Dio _dio;

  @PostConstruct()
  init() {
    _dio = Dio(BaseOptions(
        headers: {
          Headers.acceptHeader: 'application/json',
          Headers.contentTypeHeader: 'application/json'
        },
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5)));
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) async {
    final res = await _dio.get(path, queryParameters: query);
    if (res.data == null) {
      return Future.error(DioException(requestOptions: res.requestOptions));
    }

    return res.data!;
  }
}
