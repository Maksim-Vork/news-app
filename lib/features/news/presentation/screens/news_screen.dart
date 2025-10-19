import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/features/news/domain/entitys/category_news.dart';
import 'package:news/features/news/presentation/bloc/news_bloc.dart';
import 'package:news/features/news/presentation/bloc/news_event.dart';
import 'package:news/features/news/presentation/bloc/news_state.dart';
import 'package:news/features/news/presentation/widgets/card_news.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is LoadedNewsState) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  toolbarHeight: 100,
                  expandedHeight: 140,
                  surfaceTintColor: Colors.transparent,
                  pinned: true,
                  floating: false,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      onSubmitted: (String string) =>
                          BlocProvider.of<NewsBloc>(context).add(
                        SearchNewsEvent(name: searchController.text),
                      ),
                      controller: searchController,
                      style: const TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: SvgPicture.asset(
                          'assets/icons/search.svg',
                          width: 20,
                          fit: BoxFit.scaleDown,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 19.0, vertical: 1),
                          child: Row(
                            children: [
                              for (final category in CategoryNews.all)
                                Padding(
                                  padding: const EdgeInsets.only(right: 7),
                                  child: SizedBox(
                                    height: 44,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            state.selectedCategory == category
                                                ? const Color(0xFF2F78FF)
                                                : const Color(0xFFC1C1C1),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<NewsBloc>(context).add(
                                          GetNewsByCategoryEvent(
                                              category: category),
                                        );
                                      },
                                      child: Text(
                                        category.uiName,
                                        style: const TextStyle(
                                          fontFamily: 'Satoshi',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 14),
                ),
                state.news.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: state.news.length, (context, index) {
                        final news = state.news[index];
                        return CardNewsWidget(
                          news: news,
                          isFavorite: false,
                        );
                      }))
                    : const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Text(
                              'Список пуст',
                              style: TextStyle(
                                fontFamily: 'Satoshi',
                                color: Color.fromARGB(114, 0, 0, 0),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            );
          } else if (state is LoadingNewsState || state is InitialNewsState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorNewsState) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(
                  fontFamily: 'Satoshi',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
