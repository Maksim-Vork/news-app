import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:news/features/news/domain/entitys/news.dart';
import 'package:news/features/news/presentation/bloc/news_bloc.dart';
import 'package:news/features/news/presentation/bloc/news_event.dart';
import 'package:news/features/news/presentation/bloc/news_state.dart';

class NewsViewerScreen extends StatefulWidget {
  final News news;

  const NewsViewerScreen({super.key, required this.news});

  @override
  State<NewsViewerScreen> createState() => _NewsViewerScreenState();
}

class _NewsViewerScreenState extends State<NewsViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
      News currentNews = widget.news;
      if (state is LoadedNewsState) {
        final int indexInNews =
            state.news.indexWhere((e) => e.url == widget.news.url);
        if (indexInNews != -1) {
          currentNews = state.news[indexInNews];
        } else {
          final int indexInFavorites =
              state.favoriteNews.indexWhere((e) => e.url == widget.news.url);
          if (indexInFavorites != -1) {
            currentNews = state.favoriteNews[indexInFavorites];
          }
        }
      }

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: SvgPicture.asset('assets/icons/arrow_back.svg')),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<NewsBloc>(context).add(
                        ToggleFavoriteNewsEvent(news: widget.news),
                      );
                    },
                    icon: currentNews.isFavorite
                        ? SvgPicture.asset(
                            'assets/icons/favorite.svg',
                            width: 43,
                          )
                        : SvgPicture.asset('assets/icons/un_favorite.svg')),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentNews.title,
                  style: const TextStyle(
                    fontFamily: 'Satoshi',
                    fontSize: 33,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (currentNews.description != null)
                  Text(
                    currentNews.description!,
                    style: const TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: 27,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currentNews.source.name,
                      style: const TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      DateFormat('MM.dd.yyyy').format(currentNews.publishedAt),
                      style: const TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (currentNews.urlToImage != null)
                  Container(
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
                    height: 265,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        currentNews.urlToImage!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                const SizedBox(height: 18),
                if (currentNews.description != null)
                  Text(
                    currentNews.description!,
                    textAlign: TextAlign.start,
                    maxLines: null,
                    style: const TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
