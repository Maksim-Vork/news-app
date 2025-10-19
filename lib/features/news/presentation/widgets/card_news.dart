import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:news/features/news/domain/entitys/news.dart';
import 'package:news/features/news/presentation/bloc/news_bloc.dart';
import 'package:news/features/news/presentation/bloc/news_event.dart';
import 'package:news/features/news/presentation/screens/news_viewer_screen.dart';

class CardNewsWidget extends StatefulWidget {
  final News news;
  final bool isFavorite;

  const CardNewsWidget({
    super.key,
    required this.isFavorite,
    required this.news,
  });

  @override
  State<CardNewsWidget> createState() => _CardNewsWidgetState();
}

class _CardNewsWidgetState extends State<CardNewsWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsViewerScreen(news: widget.news),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: const Color(0xFFCECECE),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0x26000000),
                offset: const Offset(0, 3),
                blurRadius: 8.0,
                spreadRadius: 0,
              ),
            ],
          ),
          height: 112,
          width: double.infinity,
          child: widget.news.urlToImage != null
              ? Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      child: Image.network(
                        widget.news.urlToImage!,
                        height: 112,
                        width: 123,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 112,
                            width: 123,
                            color: const Color.fromARGB(32, 0, 0, 0),
                            child: const Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.grey,
                              size: 45,
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: _buildContentColumn(context, textTheme),
                    ),
                  ],
                )
              : _buildContentColumn(context, textTheme),
        ),
      ),
    );
  }

  Widget _buildContentColumn(BuildContext context, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.news.title,
                      style: textTheme.headlineMedium?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.news.description != null)
                      Text(
                        widget.news.description!,
                        style: textTheme.bodyLarge?.copyWith(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.85),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              if (widget.isFavorite)
                IconButton(
                  onPressed: () {
                    BlocProvider.of<NewsBloc>(context)
                        .add(ToggleFavoriteNewsEvent(news: widget.news));
                  },
                  icon: SvgPicture.asset('assets/icons/favorite.svg'),
                ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                DateFormat('MM.dd.yyyy').format(widget.news.publishedAt),
                style: textTheme.bodySmall?.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
