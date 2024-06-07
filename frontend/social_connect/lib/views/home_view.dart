import 'package:flutter/material.dart';
import 'news_feed_view.dart';
import 'friends_suggestions_view.dart';
import 'notifications_view.dart';
import 'profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    NewsFeedView(),
    FriendsSuggestionsView(),
    NotificationsView(),
    ProfileView(),
  ];

  final List<Color> _iconColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
  ];

  final Color _bottomNavBarColor = Colors.white; // Màu nền của thanh tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: _iconColors[_currentIndex],
        unselectedItemColor: Colors.grey,
        backgroundColor: _bottomNavBarColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? _iconColors[0] : Colors.grey,
            ),
            label: 'Home',
            backgroundColor: _bottomNavBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              color: _currentIndex == 1 ? _iconColors[1] : Colors.grey,
            ),
            label: 'Friends',
            backgroundColor: _bottomNavBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: _currentIndex == 2 ? _iconColors[2] : Colors.grey,
            ),
            label: 'Notifications',
            backgroundColor: _bottomNavBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 3 ? _iconColors[3] : Colors.grey,
            ),
            label: 'Profile',
            backgroundColor: _bottomNavBarColor,
          ),
        ],
      ),
    );
  }
}
