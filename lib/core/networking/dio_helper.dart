import 'package:dio/dio.dart';

class DioHelper {
  static late Dio _dio;

  /// Initialize Dio
  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://www.themealdb.com/api/json/v1/1/',
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        responseType: ResponseType.json,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  /// GET request
  static Future<Response> get({
    required String endpoint,
  }) async {
    return await _dio.get(endpoint);
  }

  /// GET request with query parameters
  static Future<Response> getQuery({
    required String endpoint,
    required Map<String, dynamic> query,
  }) async {
    return await _dio.get(
      endpoint,
      queryParameters: query,
    );
  }

  /// POST request
  static Future<Response> post({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.post(
      endpoint,
      data: data,
      queryParameters: query,
    );
  }
}