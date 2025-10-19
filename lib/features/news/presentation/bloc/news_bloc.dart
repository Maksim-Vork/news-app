import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/exeptions/app_ex%D1%81eptions.dart';
import 'package:news/core/services/di/service_locator.dart';
import 'package:news/features/news/domain/entitys/news.dart';
import 'package:news/features/news/domain/repository/news_repository.dart';
import 'package:news/features/news/domain/usecase/toggle_favorite_news_usecase.dart';
import 'package:news/features/news/presentation/bloc/news_event.dart';
import 'package:news/features/news/presentation/bloc/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepo = locator<NewsRepository>();
  final ToggleFavoriteNewsUsecase toggleFavoriteUsecase =
      locator<ToggleFavoriteNewsUsecase>();
  NewsBloc() : super(InitialNewsState()) {
    on<GetNewsEvent>(_onGetNews);
    on<GetNewsByCategoryEvent>(_onGetByCategory);
    on<SearchNewsEvent>(_onSearch);
    on<ToggleFavoriteNewsEvent>(_onToggle);
  }
  FutureOr<void> _onGetNews(GetNewsEvent event, Emitter<NewsState> emit) async {
    emit(LoadingNewsState());
    try {
      final List<News> news = await newsRepo.getNews();
      final List<News> favoriteNews = await newsRepo.getFavoriteNews();

      emit(LoadedNewsState(news: news, favoriteNews: favoriteNews));
    } on AppExceptions catch (e) {
      emit(ErrorNewsState(error: e.nameError));
    } catch (e) {
      debugPrint('Ошибка получения: $e');
      emit(ErrorNewsState(error: 'Произошла ошибка, мы над этим уже работаем'));
    }
  }

  FutureOr<void> _onGetByCategory(
      GetNewsByCategoryEvent event, Emitter<NewsState> emit) async {
    try {
      final List<News> news = await newsRepo.getNewsByCategory(event.category);

      final currentState = state as LoadedNewsState;

      emit(currentState.copyWith(news: news, selectedCategory: event.category));
    } on AppExceptions catch (e) {
      emit(ErrorNewsState(error: e.toString()));
    } catch (e) {
      debugPrint('Ошибка получения по категории: $e');
      emit(ErrorNewsState(error: 'Произошла ошибка, мы над этим уже работаем'));
    }
  }

  FutureOr<void> _onSearch(
      SearchNewsEvent event, Emitter<NewsState> emit) async {
    try {
      final List<News> news = await newsRepo.searchNews(event.name);

      final currentState = state as LoadedNewsState;
      emit(currentState.copyWith(news: news));
    } on AppExceptions catch (e) {
      emit(ErrorNewsState(error: e.toString()));
    } catch (e) {
      debugPrint('Ошибка поиска: $e');
      emit(ErrorNewsState(error: 'Произошла ошибка, мы над этим уже работаем'));
    }
  }

  FutureOr<void> _onToggle(
      ToggleFavoriteNewsEvent event, Emitter<NewsState> emit) async {
    try {
      final currentState = state as LoadedNewsState;
      final List<News> updatedNews = List<News>.from(currentState.news);

      final int indexInNews =
          updatedNews.indexWhere((e) => e.url == event.news.url);
      if (indexInNews != -1) {
        updatedNews[indexInNews].isFavorite =
            !updatedNews[indexInNews].isFavorite;
      }

      await toggleFavoriteUsecase(event.news);

      final List<News> newFavorites = await newsRepo.getFavoriteNews();

      emit(LoadedNewsState(
        news: updatedNews,
        favoriteNews: newFavorites,
      ));
    } on AppExceptions catch (e) {
      emit(ErrorNewsState(error: e.toString()));
    } catch (e) {
      debugPrint('Ошибка toggle: $e');
      emit(ErrorNewsState(error: 'Произошла ошибка, мы над этим уже работаем'));
    }
  }
}
