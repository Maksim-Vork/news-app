import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/news/presentation/bloc/news_bloc.dart';
import 'package:news/features/news/presentation/bloc/news_state.dart';
import 'package:news/features/news/presentation/widgets/card_news.dart';

class FavoriteNewsScreen extends StatelessWidget {
  const FavoriteNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 100,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 9),
            BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is LoadedNewsState) {
                  return state.favoriteNews.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.favoriteNews.length,
                          itemBuilder: (context, index) {
                            return CardNewsWidget(
                              isFavorite: true,
                              news: state.favoriteNews[index],
                            );
                          },
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Список пуст',
                              style: textTheme.bodyLarge?.copyWith(
                                color: const Color.fromARGB(114, 0, 0, 0),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                } else if (state is LoadingNewsState ||
                    state is InitialNewsState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ErrorNewsState) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          'Упс, произошла ошибка',
                          style: textTheme.bodyLarge,
                        ),
                        Text(
                          state.error,
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          'Упс, произошла ошибка',
                          style: textTheme.bodyLarge,
                        ),
                        Text(
                          'Перезапустите приложение',
                          style: textTheme.bodyMedium?.copyWith(
                            color: const Color.fromARGB(150, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
