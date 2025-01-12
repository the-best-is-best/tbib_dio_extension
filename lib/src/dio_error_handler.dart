// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:tbib_dio_extension/tbib_dio_extension.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
  BAD_CERTIFICATE
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error, {String? messageFromApi}) {
    if (error is DioException) {
      // dio error so its error from response of the API
      failure = _handleError(error, messageFromApi);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioException error, String? errorMessageApi) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return errorMessageApi != null
                ? Failure(ResponseCode.BAD_REQUEST, errorMessageApi,
                    error.response?.data)
                : DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return errorMessageApi != null
                ? Failure(ResponseCode.BAD_REQUEST, errorMessageApi,
                    error.response?.data)
                : DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORISED:
            return errorMessageApi != null
                ? Failure(ResponseCode.BAD_REQUEST, errorMessageApi,
                    error.response?.data)
                : DataSource.UNAUTHORISED.getFailure();
          case ResponseCode.NOT_FOUND:
            return errorMessageApi != null
                ? Failure(ResponseCode.BAD_REQUEST, errorMessageApi,
                    error.response?.data)
                : DataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return errorMessageApi != null
                ? Failure(ResponseCode.BAD_REQUEST, errorMessageApi,
                    error.response?.data)
                : DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return errorMessageApi != null
                ? Failure(ResponseCode.BAD_REQUEST, errorMessageApi,
                    error.response?.data)
                : DataSource.DEFAULT.getFailure();
        }
      case DioExceptionType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioExceptionType.unknown:
        return DataSource.DEFAULT.getFailure();
      case DioExceptionType.badCertificate:
        return DataSource.BAD_CERTIFICATE.getFailure();

      case DioExceptionType.connectionError:
        return DataSource.CONNECT_TIMEOUT.getFailure();
    }
  }
}

class ResponseCode {
  // API status codes
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no content
  static const int BAD_REQUEST = 400; // failure, api rejected the request
  static const int FORBIDDEN = 403; // failure, api rejected the request
  static const int UNAUTHORISED = 401; // failure user is not authorised
  static const int NOT_FOUND =
      404; // failure, api url is not correct and not found
  static const int INTERNAL_SERVER_ERROR =
      500; // failure, crash happened in server side

  // local status code
  static const int DEFAULT = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
  static const int BAD_CERTIFICATE = -8;
}

class ResponseMessage {
  static const String SUCCESS = StringsDioError.SUCCESS; // success with data
  static const String NO_CONTENT =
      StringsDioError.NO_CONTENT; // success with no content
  static const String BAD_REQUEST =
      StringsDioError.Bad_REQUEST; // failure, api rejected our request
  static const String FORBIDDEN =
      StringsDioError.FORBIDDEN_REQUEST; // failure,  api rejected our request
  static const String UNAUTHORISED =
      StringsDioError.UNAUTHORIZED; // failure, user is not authorised
  static const String NOT_FOUND = StringsDioError
      .NO_FOUND; // failure, API url is not correct and not found in api side.
  static const String INTERNAL_SERVER_ERROR = StringsDioError
      .INTERNAL_SERVER_ERROR; // failure, a crash happened in API side.

  // local responses codes
  static const String DEFAULT =
      StringsDioError.DEFAULT_ERROR; // unknown error happened
  static const String CONNECT_TIMEOUT =
      StringsDioError.TIME_OUT; // issue in connectivity
  static const String CANCEL =
      StringsDioError.DEFAULT_ERROR; // API request was cancelled
  static const String RECEIVE_TIMEOUT =
      StringsDioError.TIME_OUT; //  issue in connectivity
  static const String SEND_TIMEOUT =
      StringsDioError.TIME_OUT; //  issue in connectivity
  static const String CACHE_ERROR = StringsDioError
      .DEFAULT_ERROR; //  issue in getting data from local data source (cache)
  static const String NO_INTERNET_CONNECTION =
      StringsDioError.NO_INTERNET; // issue in connectivity
  static const String BAD_CERTIFICATE =
      StringsDioError.BAD_CERTIFICATE; //Server Not Secure
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    BuildContext? c = DioManger.navigationKey?.currentContext;
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(
            ResponseCode.BAD_REQUEST,
            c != null
                ? TBIBDioLocalizations.of(c)?.bad_request ??
                    ResponseMessage.BAD_REQUEST
                : ResponseMessage.BAD_REQUEST,
            null);
      case DataSource.FORBIDDEN:
        return Failure(
            ResponseCode.FORBIDDEN,
            c != null
                ? TBIBDioLocalizations.of(c)?.forbidden_request ??
                    ResponseMessage.FORBIDDEN
                : ResponseMessage.FORBIDDEN,
            null);
      case DataSource.UNAUTHORISED:
        return Failure(
            ResponseCode.UNAUTHORISED,
            c != null
                ? TBIBDioLocalizations.of(c)?.unauthorized ??
                    ResponseMessage.UNAUTHORISED
                : ResponseMessage.UNAUTHORISED,
            null);
      case DataSource.NOT_FOUND:
        return Failure(
            ResponseCode.NOT_FOUND,
            c != null
                ? TBIBDioLocalizations.of(c)?.not_found ??
                    ResponseMessage.NOT_FOUND
                : ResponseMessage.NOT_FOUND,
            null);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(
            ResponseCode.INTERNAL_SERVER_ERROR,
            c != null
                ? TBIBDioLocalizations.of(c)?.internal_server_error ??
                    ResponseMessage.INTERNAL_SERVER_ERROR
                : ResponseMessage.INTERNAL_SERVER_ERROR,
            null);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT,
            c != null
                ? TBIBDioLocalizations.of(c)?.time_Out ??
                    ResponseMessage.CONNECT_TIMEOUT
                : ResponseMessage.CONNECT_TIMEOUT,
            null);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL, null);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(ResponseCode.RECEIVE_TIMEOUT,
            ResponseMessage.RECEIVE_TIMEOUT, null);
      case DataSource.SEND_TIMEOUT:
        return Failure(
            ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT, null);
      case DataSource.CACHE_ERROR:
        return Failure(
            ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR, null);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(
            ResponseCode.NO_INTERNET_CONNECTION,
            c != null
                ? TBIBDioLocalizations.of(c)?.no_internet ??
                    ResponseMessage.NO_INTERNET_CONNECTION
                : ResponseMessage.NO_INTERNET_CONNECTION,
            null);
      case DataSource.DEFAULT:
        return Failure(
            ResponseCode.DEFAULT,
            c != null
                ? TBIBDioLocalizations.of(c)?.default_error ??
                    ResponseMessage.DEFAULT
                : ResponseMessage.DEFAULT,
            null);
      case DataSource.BAD_CERTIFICATE:
        return Failure(
            ResponseCode.BAD_CERTIFICATE,
            c != null
                ? TBIBDioLocalizations.of(c)?.bad_certificate ??
                    ResponseMessage.BAD_CERTIFICATE
                : ResponseMessage.BAD_CERTIFICATE,
            null);
      default:
        return Failure(
            ResponseCode.DEFAULT,
            c != null
                ? TBIBDioLocalizations.of(c)?.default_error ??
                    ResponseMessage.DEFAULT
                : ResponseMessage.DEFAULT,
            null);
    }
  }
}
