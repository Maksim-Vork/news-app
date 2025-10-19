import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/features/news/presentation/screens/favorite_news_screen.dart';
import 'package:news/features/news/presentation/screens/news_screen.dart';
import 'package:news/features/news/presentation/widgets/custom_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> screens = [
    NewsScreen(),
    FavoriteNewsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> _navBarItems = [
      BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SvgPicture.asset(
            _currentIndex == 0
                ? 'assets/icons/news_activ.svg'
                : 'assets/icons/news.svg',
          ),
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SvgPicture.asset(
            _currentIndex == 1
                ? 'assets/icons/fevrt_activ_news.svg'
                : 'assets/icons/fevrt_news.svg',
          ),
        ),
        label: '',
      ),
    ];

    return Scaffold(
      extendBody: true,
      body: screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: _navBarItems,
      ),
    );
  }
}
