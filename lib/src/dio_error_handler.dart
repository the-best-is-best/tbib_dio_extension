// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:tbib_dio_extension/src/failure.dart';
import 'package:tbib_dio_extension/src/res/errors_dio_strings.dart';

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
    if (error is DioError) {
      // dio error so its error from response of the API
      failure = _handleError(error, messageFromApi);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioError error, String? errorMessageApi) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();
      case DioErrorType.badResponse:
        switch (error.response?.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return errorMessageApi != null
                ? Failure(ResponseCode.BAD_REQUEST,
                    error.response!.data['errorMessage'])
                : DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORISED:
            return DataSource.UNAUTHORISED.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }
      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioErrorType.unknown:
        return DataSource.DEFAULT.getFailure();
      case DioErrorType.badCertificate:
        return DataSource.BAD_CERTIFICATE.getFailure();

      case DioErrorType.connectionError:
        return DataSource.CONNECT_TIMEOUT.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORISED:
        return Failure(ResponseCode.UNAUTHORISED, ResponseMessage.UNAUTHORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
      case DataSource.BAD_CERTIFICATE:
        return Failure(
            ResponseCode.BAD_CERTIFICATE, ResponseMessage.BAD_CERTIFICATE);
      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
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
  // API status codes
  // API response codes

  static String SUCCESS = StringsDioError.SUCCESS; // success with data
  static String NO_CONTENT =
      StringsDioError.NO_CONTENT; // success with no content
  static String BAD_REQUEST =
      StringsDioError.Bad_REQUEST; // failure, api rejected our request
  static String FORBIDDEN =
      StringsDioError.FORBIDDEN_REQUEST; // failure,  api rejected our request
  static String UNAUTHORISED =
      StringsDioError.UNAUTHORIZED; // failure, user is not authorised
  static String NOT_FOUND = StringsDioError
      .NO_FOUND; // failure, API url is not correct and not found in api side.
  static String INTERNAL_SERVER_ERROR = StringsDioError
      .INTERNAL_SERVER_ERROR; // failure, a crash happened in API side.

  // local responses codes
  static String DEFAULT =
      StringsDioError.DEFAULT_ERROR; // unknown error happened
  static String CONNECT_TIMEOUT =
      StringsDioError.TIME_OUT; // issue in connectivity
  static String CANCEL =
      StringsDioError.DEFAULT_ERROR; // API request was cancelled
  static String RECEIVE_TIMEOUT =
      StringsDioError.TIME_OUT; //  issue in connectivity
  static String SEND_TIMEOUT =
      StringsDioError.TIME_OUT; //  issue in connectivity
  static String CACHE_ERROR = StringsDioError
      .DEFAULT_ERROR; //  issue in getting data from local data source (cache)
  static String NO_INTERNET_CONNECTION =
      StringsDioError.NO_INTERNET; // issue in connectivity
  static String BAD_CERTIFICATE =
      StringsDioError.BAD_CERTIFICATE; //Server Not Secure
}

class MyErrorHandler extends ErrorHandler {
  final dynamic error;
  final String? messageErrorApi;

  MyErrorHandler(this.error, {this.messageErrorApi})
      : super.handle(error, messageFromApi: messageErrorApi);
}
