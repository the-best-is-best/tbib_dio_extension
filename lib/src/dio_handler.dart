import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:requests_inspector/requests_inspector.dart';

class DioManger {
  /// your dio
  static late Dio dioApi;
  static GlobalKey<NavigatorState>? navigationKey;

  /// use it if will use default settings
  /// PrettyDioLogger active when build debug mode only
  static void init({
    GlobalKey<NavigatorState>? navKey,
    String baseUrl = "",
    Duration timeOut = const Duration(minutes: 2),
    String contentType = 'application/json',

    /// add your custom Interceptor
    Iterable<Interceptor> interceptors = const [],
    bool workWithBadCertificate = false,
  }) {
    navigationKey = navKey;
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

  /// use it to custom your options
  /// PrettyDioLogger active when build debug mode only
  static void initWithCustomOption(
      {required BaseOptions baseOptions,
      GlobalKey<NavigatorState>? navKey,

      /// add your custom Interceptor
      Iterable<Interceptor> interceptors = const [],
      bool workWithBadCertificate = false}) {
    navigationKey = navKey;
    dioApi = Dio(
      baseOptions,
    );

    dioApi.interceptors.addAll(interceptors);

    if (kDebugMode || workWithBadCertificate) {
      if (!dioApi.options.baseUrl.contains('https')) {
        HttpOverrides.global = PostHttpOverrides();
      }
      dioApi.interceptors.addAll([
        PrettyDioLogger(
            requestHeader: true, requestBody: true, responseHeader: true),
        //   RequestsInspectorInterceptor()
      ]);
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
