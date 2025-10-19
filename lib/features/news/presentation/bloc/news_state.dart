import 'package:news/features/news/domain/entitys/category_news.dart';
import 'package:news/features/news/domain/entitys/news.dart';

abstract class NewsState {}

class InitialNewsState extends NewsState {}

class LoadingNewsState extends NewsState {}

class LoadedNewsState extends NewsState {
  final List<News> news;
  final List<News> favoriteNews;
  final CategoryNews? selectedCategory;

  LoadedNewsState({
    required this.news,
    required this.favoriteNews,
    this.selectedCategory,
  });

  LoadedNewsState copyWith(
      {List<News>? news, List<News>? favoritNews, CategoryNews? selectedCategory}) {
    return LoadedNewsState(
      news: news ?? this.news,
      favoriteNews: favoritNews ?? this.favoriteNews,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class ErrorNewsState extends NewsState {
  final String error;

  ErrorNewsState({required this.error});
}
