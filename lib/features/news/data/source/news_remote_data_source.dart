import 'package:news/core/exeptions/app_ex%D1%81eptions.dart';
import 'package:news/core/services/ApiService/dio_service.dart';
import 'package:news/features/news/data/model/news_model.dart';
import 'package:news/features/news/domain/entitys/category_news.dart';

class NewsRemoteDataSource {
  final DioService dioService;

  NewsRemoteDataSource({required this.dioService});

  Future<List<NewsModel>> getNews() async {
    final response = await dioService.get('/top-headlines', {
      'country': 'us',
      'pageSize': 40,
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = response.data as Map<String, dynamic>;

      if (json['status'] != 'ok') {
        throw AppExceptions(nameError: 'Ошибка API: ${json['status']}');
      }

      final articles = json['articles'] as List<dynamic>;

      return articles
          .map(
            (articleJson) =>
                NewsModel.fromJson(articleJson as Map<String, dynamic>),
          )
          .toList();
    }
    {
      throw AppExceptions(nameError: 'Ошибка сервера');
    }
  }

  Future<List<NewsModel>> searchNews(String name) async {
    final response = await dioService.get('/top-headlines', {
      'country': 'us',
      'q': name,
      'pageSize': 40,
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = response.data as Map<String, dynamic>;

      if (json['status'] != 'ok') {
        throw AppExceptions(nameError: 'Ошибка API: ${json['status']}');
      }

      final articles = json['articles'] as List<dynamic>;

      return articles
          .map(
            (articleJson) =>
                NewsModel.fromJson(articleJson as Map<String, dynamic>),
          )
          .toList();
    }
    {
      throw AppExceptions(nameError: 'Ошибка сервера');
    }
  }

  Future<List<NewsModel>> getNewsByCategoryNews(
      CategoryNews nameCategory) async {
    final response = await dioService.get('/top-headlines', {
      'country': 'us',
      'category': nameCategory.apiName,
      'pageSize': 40,
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = response.data as Map<String, dynamic>;

      if (json['status'] != 'ok') {
        throw AppExceptions(nameError: 'Ошибка API: ${json['status']}');
      }

      final articles = json['articles'] as List<dynamic>;

      return articles
          .map(
            (articleJson) =>
                NewsModel.fromJson(articleJson as Map<String, dynamic>),
          )
          .toList();
    }
    {
      throw AppExceptions(nameError: 'Ошибка сервера');
    }
  }
}
