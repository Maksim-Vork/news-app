import 'package:go_router/go_router.dart';
import 'package:news/features/news/domain/entitys/news.dart';
import 'package:news/features/news/presentation/screens/favorite_news_screen.dart';
import 'package:news/features/news/presentation/screens/news_screen.dart';
import 'package:news/features/news/presentation/screens/news_viewer_screen.dart';
import 'package:news/main_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/news',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/news',
          name: 'news',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: NewsScreen()),
          routes: [
            GoRoute(
              path: 'viewer',
              name: 'news_viewer',
              builder: (context, state) {
                final news = state.extra as News?;
                if (news == null) {
                  return const NewsScreen();
                }
                return NewsViewerScreen(news: news);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/favorites',
          name: 'favorites',
          builder: (context, state) => FavoriteNewsScreen(),
        ),
      ],
    ),
  ],
);
