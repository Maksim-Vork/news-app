import 'package:news/features/news/domain/entitys/category_news.dart';
import 'package:news/features/news/domain/entitys/news.dart';

abstract class NewsRepository {
  Future<List<News>> getNews();
  Future<List<News>> searchNews(String name);
  Future<List<News>> getNewsByCategory(CategoryNews nameCategory);
  Future<List<News>> getFavoriteNews();
  Future<void> deleteFavoriteNews(String url);
  Future<void> addFavoriteNews(News news);
}
