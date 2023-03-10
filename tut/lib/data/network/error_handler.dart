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
  static const String internalServerError = 'something went wrong, try again later';

  // local status codes
  static const String unknown = 'something went wrong, try again later';
  static const String connectTimeout = 'timeout error, try again later';
  static const String cancel = 'request was cancelled, try again later';
  static const String receiveTimeout = 'timeout error, try again later';
  static const String sendTimeout = 'timeout error, try again later';
  static const String cacheError = 'cache error, try again later';
  static const String noInternetConnection = 'please check your internet connection';
}
