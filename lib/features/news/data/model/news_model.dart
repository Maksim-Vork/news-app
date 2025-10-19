import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:news/features/news/domain/entitys/news.dart';
import 'source_model.dart';

part 'news_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class NewsModel {
  @HiveField(0)
  final SourceModel source;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final String url;
  @HiveField(4)
  final String? urlToImage;
  @HiveField(5)
  final DateTime publishedAt;

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  NewsModel({
    required this.source,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);

  static NewsModel toModel(News news) {
    return NewsModel(
      source: SourceModel.toModel(news.source),
      title: news.title,
      description: news.description,
      url: news.url,
      urlToImage: news.urlToImage,
      publishedAt: news.publishedAt,
    );
  }

  News toEntity({bool isFavorite = false}) {
    return News(
      source: source.toEntity(),
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      isFavorite: isFavorite,
    );
  }
}
