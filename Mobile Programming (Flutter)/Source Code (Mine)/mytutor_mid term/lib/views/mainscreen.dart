import 'package:flutter/material.dart';
import 'package:mytutor/views/coursescreen.dart';
import 'package:mytutor/views/profilescreen.dart';
import 'package:mytutor/views/subscribescreen.dart';
import 'package:mytutor/views/tutorscreen.dart';
import '../models/user.dart';
import 'favouritescreen.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "Profile";

  @override
  void initState() {
    super.initState();
    tabchildren = [
      CourseScreen(user: widget.user),
      TutorScreen(user: widget.user),
      SubscribeScreen(),
      FavouriteScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabchildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books,
              ),
              label: "Course"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.school,
              ),
              label: "Tutor"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.control_point,
              ),
              label: "Subscribe"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark,
              ),
              label: "Favourite"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile")
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        maintitle = "Home";
      }
      if (_currentIndex == 1) {
        maintitle = "Tutor";
      }
      if (_currentIndex == 2) {
        maintitle = "Subscribe";
      }
      if (_currentIndex == 3) {
        maintitle = "Favourite";
      }
       if (_currentIndex == 4) {
        maintitle = "Profile";
      }
    });
  }
}
