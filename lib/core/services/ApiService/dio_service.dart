import 'package:dio/dio.dart';
import 'package:news/core/exeptions/app_ex%D1%81eptions.dart';

class DioService {
  late final Dio _dio;

  DioService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/v2',
        headers: {
          'X-Api-Key': '2233bb9a8bd84fffb10a693037612c58',
        }, //переместить и защитить и прописать gitgnore
      ),
    );

    _dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
      InterceptorsWrapper(
        onError: (DioException error, handler) {
          if (error.type == DioExceptionType.connectionError) {
            throw AppExceptions(nameError: 'Нет подключения к интернету');
          }
          if (error.response?.statusCode == 429) {
            throw AppExceptions(nameError: 'Достигнут лимит получения данных');
          }

          return handler.next(error);
        },
      ),
    ]);
  }

  Future<Response> get(
    String endpoint,
    Map<String, dynamic> queryParams,
  ) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
