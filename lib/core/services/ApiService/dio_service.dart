import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/core/exeptions/app_ex%D1%81eptions.dart';

class DioService {
  late final Dio _dio;

  DioService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/v2',
        headers: {
          'X-Api-Key': dotenv.env['NEWS_API_KEY'] ?? '',
        },
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
          AppExceptions appException;

          switch (error.type) {
            case DioExceptionType.connectionError:
            case DioExceptionType.unknown:
              appException =
                  AppExceptions(nameError: 'Нет подключения к интернету');
              break;
            case DioExceptionType.badResponse:
              if (error.response?.statusCode == 429) {
                appException = AppExceptions(
                    nameError: 'Достигнут лимит получения данных');
              } else {
                appException = AppExceptions(
                    nameError: 'Ошибка сервера: ${error.response?.statusCode}');
              }
              break;
            case DioExceptionType.cancel:
              appException = AppExceptions(nameError: 'Запрос был отменён');
              break;
            default:
              appException =
                  AppExceptions(nameError: 'Произошла неизвестная ошибка');
          }

          return handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: appException,
              response: error.response,
              type: error.type,
            ),
          );
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
    } on DioException catch (e) {
      if (e.error is AppExceptions) {
        throw e.error!;
      }
      rethrow;
    } catch (e) {
      throw AppExceptions(nameError: 'Произошла неизвестная ошибка');
    }
  }
}
