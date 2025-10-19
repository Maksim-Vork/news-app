import 'package:news/features/news/domain/entitys/news.dart';
import 'package:news/features/news/domain/repository/news_repository.dart';

class ToggleFavoriteNewsUsecase {
  final NewsRepository repository;

  ToggleFavoriteNewsUsecase({required this.repository});

  Future<void> call(News news) async {
    if (news.isFavorite) {
      await repository.addFavoriteNews(news);
    } else {
      await repository.deleteFavoriteNews(news.url);
    }
  }
}
