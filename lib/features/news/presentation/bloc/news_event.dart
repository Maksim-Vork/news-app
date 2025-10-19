import 'package:news/features/news/domain/entitys/category_news.dart';
import 'package:news/features/news/domain/entitys/news.dart';

abstract class NewsEvent {}

class GetNewsEvent extends NewsEvent {}

class GetNewsByCategoryEvent extends NewsEvent {
  final CategoryNews category;

  GetNewsByCategoryEvent({required this.category});
}

class SearchNewsEvent extends NewsEvent {
  final String name;

  SearchNewsEvent({required this.name});
}

class ToggleFavoriteNewsEvent extends NewsEvent {
  final News news;

  ToggleFavoriteNewsEvent({required this.news});
}
