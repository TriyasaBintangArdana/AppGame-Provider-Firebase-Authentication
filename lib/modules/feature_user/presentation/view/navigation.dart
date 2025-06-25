import 'package:app_games/core/widgets/color.dart';
import 'package:app_games/modules/feature_user/presentation/view/favorite/favorite_screen.dart';
import 'package:app_games/modules/feature_user/presentation/view/home/home_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {

  int selectedIndex = 0;
  final List<Widget> _pages = [
    HomeScreen.create(),
    FavoriteScreen()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBlack,
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        currentIndex: selectedIndex,
        selectedItemColor: white,
        showUnselectedLabels: true,
        unselectedItemColor: blueSea,
        showSelectedLabels: true,
        backgroundColor: greyBlack,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}