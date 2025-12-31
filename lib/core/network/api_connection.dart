import 'package:dio/dio.dart';
import 'package:e_commerce/core/network/api_route.dart';

class ApiConnection {
  static final ApiConnection _instance = ApiConnection._internal();
  factory ApiConnection() => _instance;

  late Dio dio;

  ApiConnection._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiRoute.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  void setToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearToken() {
    dio.options.headers.remove('Authorization');
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    return await dio.get(path, queryParameters: queryParams);
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    return await dio.post(path, data: data);
  }
}

