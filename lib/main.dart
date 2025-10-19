import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news/core/services/di/service_locator.dart';
import 'package:news/features/news/data/model/news_model.dart';
import 'package:news/features/news/data/model/source_model.dart';
import 'package:news/features/news/presentation/bloc/news_bloc.dart';
import 'package:news/features/news/presentation/bloc/news_event.dart';
import 'package:news/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();
  Hive.registerAdapter(SourceModelAdapter());
  Hive.registerAdapter(NewsModelAdapter());
  await Hive.openBox<NewsModel>('favorit_news');

  await setupLocator();

  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc()..add(GetNewsEvent()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Satoshi',
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
                fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black),
            headlineMedium: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black),
            bodyLarge: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
            bodyMedium: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
            bodySmall: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}
