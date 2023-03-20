import 'package:dio/dio.dart';
import 'package:tut/data/network/failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  unknown,
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = DataSource.unknown.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioErrorType.cancel:
        return DataSource.cancel.getFailure();
      case DioErrorType.unknown:
        return DataSource.unknown.getFailure();
      default:
        return DataSource.unknown.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unauthorized:
        return Failure(ResponseCode.unauthorized, ResponseMessage.unauthorized);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(
            ResponseCode.connectTimeout, ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.receiveTimeout:
        return Failure(
            ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout);
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.unknown:
        return Failure(ResponseCode.unknown, ResponseMessage.unknown);
      default:
        return Failure(ResponseCode.unknown, ResponseMessage.unknown);
    }
  }
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int unauthorized = 401;
  static const int notFound = 404;
  static const int internalServerError = 500;

  // local status codes
  static const int unknown = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  static const String success = 'success';
  static const String noContent = 'success with no content';
  static const String badRequest = 'bad request, try again later';
  static const String forbidden = 'forbidden request, try again later';
  static const String unauthorized = 'user is unauthorized, try again later';
  static const String notFound = 'url is not found, try again later';
  static const String internalServerError =
      'something went wrong, try again later';

  // local status codes
  static const String unknown = 'something went wrong, try again later';
  static const String connectTimeout = 'timeout error, try again later';
  static const String cancel = 'request was cancelled, try again later';
  static const String receiveTimeout = 'timeout error, try again later';
  static const String sendTimeout = 'timeout error, try again later';
  static const String cacheError = 'cache error, try again later';
  static const String noInternetConnection =
      'please check your internet connection';
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
