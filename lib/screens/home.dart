import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testproject/screens/homescreen/dashboard.dart';
import 'package:testproject/screens/homescreen/media_library.dart';
import 'package:testproject/screens/homescreen/more.dart';
import 'package:testproject/screens/homescreen/watch.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(),
    const Watch(),
    const MediaLibrary(),
    const More(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/dash.svg',
                  width: 24,
                  height: 24,
                  color: _selectedIndex == 0
                      ? Colors.white
                      : Colors.grey, // Customize the color of the icon
                ),
                label: 'Dashboard',
                backgroundColor: const Color(0xff2E2739),
              ),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/library.svg',
                    width: 24,
                    height: 24,
                    color: _selectedIndex == 1
                        ? Colors.white
                        : Colors.grey, // Customize the color of the icon
                  ),
                  label: 'Watch',
                  backgroundColor: const Color(0xff2E2739)),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/watch.svg',
                    width: 24,
                    height: 24,
                    color: _selectedIndex == 2
                        ? Colors.white
                        : Colors.grey, // Customize the color of the icon
                  ),
                  label: 'Media Library',
                  backgroundColor: const Color(0xff2E2739)),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/more.svg',
                    width: 24,
                    height: 24,
                    color: _selectedIndex == 3
                        ? Colors.white
                        : Colors.grey, // Customize the color of the icon
                  ),
                  label: 'More',
                  backgroundColor: const Color(0xff2E2739))
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white, // Change selected item color here
            unselectedItemColor: Colors.grey,
            iconSize: 30,
            onTap: _onItemTapped,
            elevation: 5,
          ),
        ));
  }
}
