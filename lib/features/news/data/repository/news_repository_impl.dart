import 'package:news/features/news/data/model/news_model.dart';
import 'package:news/features/news/data/source/news_local_data_source.dart';
import 'package:news/features/news/data/source/news_remote_data_source.dart';
import 'package:news/features/news/domain/entitys/category_news.dart';
import 'package:news/features/news/domain/entitys/news.dart';
import 'package:news/features/news/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource newsRemoteDataSource;
  final NewsLocalDataSource newsLocalDataSource;

  NewsRepositoryImpl({
    required this.newsRemoteDataSource,
    required this.newsLocalDataSource,
  });
  @override
  Future<List<News>> getFavoriteNews() async {
    final List<NewsModel> news = await newsLocalDataSource.getFavoritNews();
    return news.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<News>> getNews() async {
    final List<NewsModel> news = await newsRemoteDataSource.getNews();
    final Set<String> urlFavoritNews =
        await newsLocalDataSource.getUrlsFavoritNews();
    return news
        .map((e) => e.toEntity(isFavorite: urlFavoritNews.contains(e.url)))
        .toList();
  }

  @override
  Future<List<News>> searchNews(String name) async {
    final List<NewsModel> news = await newsRemoteDataSource.searchNews(name);
    return news.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<News>> getNewsByCategory(CategoryNews nameCategory) async {
    final List<NewsModel> news =
        await newsRemoteDataSource.getNewsByCategoryNews(nameCategory);
    return news.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> addFavoriteNews(News news) async {
    final NewsModel newsModel = NewsModel.toModel(news);
    await newsLocalDataSource.addFavoriteNews(newsModel);
  }

  @override
  Future<void> deleteFavoriteNews(String url) async {
    await newsLocalDataSource.deleteFavoriteNews(url);
  }
}
