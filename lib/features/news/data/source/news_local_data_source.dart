import 'package:hive/hive.dart';
import 'package:news/features/news/data/model/news_model.dart';

class NewsLocalDataSource {
  final String favoritBox = 'favorit_news';

  Future<Box<NewsModel>> getFavoriteBox() async {
    return await Hive.openBox<NewsModel>(favoritBox);
  }

  Future<List<NewsModel>> getFavoritNews() async {
    final boxNews = await getFavoriteBox();
    final List<NewsModel> news = boxNews.values.toList();
   
    return news;
  }

  Future<void> addFavoriteNews(NewsModel news) async {
    final boxNews = await getFavoriteBox();
    await boxNews.put(news.url, news);
 
  }

  Future<void> deleteFavoriteNews(String url) async {
    final boxNews = await getFavoriteBox();

    await boxNews.delete(url);
   
  }

  Future<Set<String>> getUrlsFavoritNews() async {
    final boxNews = await getFavoriteBox();
    return boxNews.keys.cast<String>().toSet();
  }
}
