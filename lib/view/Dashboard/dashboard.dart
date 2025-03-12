import 'package:flutter/material.dart';
import 'package:newsapp/view/Dashboard/search_news_screen.dart';
import 'package:newsapp/view/Dashboard/profile_screen.dart';
import 'all_news_screen.dart';
import 'bookmark_screen.dart';
import 'home_screen.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedScreenIndex = 0;

  final List<Widget> _screens = [
    // const TempScreen(),

    const HomeScreen(),
     // TempScreen(),
    AllNewsArticleScreen(), //const AllNewsScreen(),
    SearchNewsScreen(),
    SavedArticlesScreen(),//BookmarkScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue.shade200,
      // appBar: AppBar(
      //   title: Text("Dashboard"),
      // ),


      body: _screens[_selectedScreenIndex], // Display the currently selected screen
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue.shade900,
        currentIndex: _selectedScreenIndex, // Set the currently selected tab
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_outlined),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mark_chat_unread_sharp),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
      ),
    );
  }
}

