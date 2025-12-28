import 'package:dio/dio.dart';
import '../error/api_exception.dart';

class ApiHandler {
  static dynamic handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;

      case 400:
        throw ApiException(
          'Bad request',
          statusCode: 400,
        );

      case 401:
        throw ApiException(
          'Unauthorized – Token invalid or expired',
          statusCode: 401,
        );

      case 403:
        throw ApiException(
          'Forbidden – Access denied',
          statusCode: 403,
        );

      case 404:
        throw ApiException(
          'Not found',
          statusCode: 404,
        );

      case 500:
        throw ApiException(
          'Internal server error',
          statusCode: 500,
        );

      default:
        throw ApiException(
          'Something went wrong',
          statusCode: response.statusCode,
        );
    }
  }

  static ApiException handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ApiException('Connection timeout');
    }

    if (e.response != null) {
      return ApiException(
        e.response?.data['message'] ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    }

    return ApiException('No internet connection');
  }
}
