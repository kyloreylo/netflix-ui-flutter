import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix_responsive_ui/cubits/appbar/app_bar_cubit.dart';
import 'package:flutter_netflix_responsive_ui/screens/home_screen.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(key: PageStorageKey("homeScreen")),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  final Map<String, IconData> _icons = const {
    "Home": Icons.home,
    "Search": Icons.search,
    "Coming Soon": Icons.queue_play_next,
    "Dowlands": Icons.file_download,
    "More": Icons.menu
  };
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AppBarCubit>(
          create: (_) => AppBarCubit(), child: _screens[_currentIndex]),
      bottomNavigationBar: !Responsive.isDesktop(context)
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              items: _icons
                  .map(
                    (title, icon) => MapEntry(
                      title,
                      BottomNavigationBarItem(
                        icon: Icon(
                          icon,
                          size: 30,
                        ),
                        title: Text(title),
                      ),
                    ),
                  )
                  .values
                  .toList(),
              currentIndex: _currentIndex,
              selectedItemColor: Colors.white,
              selectedFontSize: 11,
              unselectedItemColor: Colors.grey,
              unselectedFontSize: 11,
              onTap: (index) => setState(() => _currentIndex = index),
            )
          : null,
    );
  }
}
