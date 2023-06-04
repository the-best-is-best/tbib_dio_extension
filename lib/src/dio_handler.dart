import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioManger {
  /// your dio
  static late Dio dioApi;

  /// use it to custom your options
  /// PrettyDioLogger active when build debug mode only
  static void initWithCustomOption(
      {required BaseOptions baseOptions,

      /// add your custom Interceptor
      Iterable<Interceptor> interceptors = const [],
      bool workWithBadCertificate = false}) {
    dioApi = Dio(
      baseOptions,
    );

    dioApi.interceptors.addAll(interceptors);

    if (kDebugMode || workWithBadCertificate) {
      if (!dioApi.options.baseUrl.contains('https')) {
        HttpOverrides.global = PostHttpOverrides();
      }
      dioApi.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }
  }

  /// use it if will use default settings
  /// PrettyDioLogger active when build debug mode only
  static void init({
    String baseUrl = "",
    Duration timeOut = const Duration(minutes: 2),
    String contentType = 'application/json',

    /// add your custom Interceptor
    Iterable<Interceptor> interceptors = const [],
    bool workWithBadCertificate = false,
  }) {
    dioApi = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
        sendTimeout: timeOut,
        contentType: contentType,
      ),
    );
    dioApi.interceptors.addAll(interceptors);

    if (kDebugMode || workWithBadCertificate) {
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
