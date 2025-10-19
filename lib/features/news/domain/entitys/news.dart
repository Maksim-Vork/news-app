import 'package:news/features/news/domain/entitys/source.dart';

class News {
  final Source source;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  bool isFavorite;

  News({
    required this.source,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.isFavorite,
  });

  News copyWith({
    Source? source,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    bool? isFavorite,
  }) {
    return News(
      source: source ?? this.source,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
