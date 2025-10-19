import 'package:get_it/get_it.dart';
import 'package:news/core/services/ApiService/dio_service.dart';
import 'package:news/features/news/data/repository/news_repository_impl.dart';
import 'package:news/features/news/data/source/news_local_data_source.dart';
import 'package:news/features/news/data/source/news_remote_data_source.dart';
import 'package:news/features/news/domain/repository/news_repository.dart';
import 'package:news/features/news/domain/usecase/toggle_favorite_news_usecase.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<DioService>(() => DioService());

  locator.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSource(dioService: locator<DioService>()));
  locator
      .registerLazySingleton<NewsLocalDataSource>(() => NewsLocalDataSource());

  locator.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(
        newsRemoteDataSource: locator<NewsRemoteDataSource>(),
        newsLocalDataSource: locator<NewsLocalDataSource>(),
      ));

  locator.registerLazySingleton<ToggleFavoriteNewsUsecase>(
      () => ToggleFavoriteNewsUsecase(repository: locator<NewsRepository>()));
}
