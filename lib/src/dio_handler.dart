import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioManger {
  static late Dio dioApi;

  static void init(
      {required String baseUrl,
      Duration timeOut = const Duration(microseconds: 6),
      String contentType = "application/json",
      String accept = "application/json"}) {
    dioApi = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        // validateStatus: (v) => v! < 500,
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
        headers: {'CONTENT-TYPE': contentType, 'ACCEPT': accept},
      ),
    );
    if (!kReleaseMode) {
      if (!dioApi.options.baseUrl.contains('https')) {
        HttpOverrides.global = PostHttpOverrides();
      }
      dioApi.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }
  }
}

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
