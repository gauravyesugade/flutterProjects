import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:trackdemo2/pages/aboutpage%20.dart';
import 'package:trackdemo2/pages/account.dart';
import 'package:trackdemo2/pages/childpage.dart';
import 'package:trackdemo2/pages/home_screen.dart';
import 'package:trackdemo2/pages/complain.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Logout Function
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> launchCoordinatesOnMap(double latitude, double longitude) async {
    MapsLauncher.launchCoordinates(latitude, longitude);
  }

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const ChildTrackerScreen(),
    const MobileMisplaceScreen(),
    const AccountScreen(),
  ];

  void _navigateToSettingsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AccountScreen()),
    );
  }

  void _navigateToAboutPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutPage()),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'TrackGuard',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(205, 218, 218, 1),
        actions: [
          TextButton(
            onPressed: () {},
            child: IconButton(
              onPressed: logout,
              icon: const Icon(Icons.logout),
              color: const Color.fromRGBO(80, 3, 112, 1),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'settings') {
                _navigateToSettingsPage(context);
              } else if (value == 'about') {
                _navigateToAboutPage(context);
              } else if (value == 'logout') {
                logout();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'settings',
                  child: Text('Settings'),
                ),
                const PopupMenuItem<String>(
                  value: 'about',
                  child: Text('About'),
                ),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(25, 0, 56, 1),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
              color: Color.fromRGBO(80, 3, 112, 1),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.child_care,
              size: 35,
              color: Color.fromRGBO(80, 3, 112, 1),
            ),
            label: 'Child Tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.report_problem,
              size: 35,
              color: Color.fromRGBO(80, 3, 112, 1),
            ),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 35,
              color: Color.fromRGBO(80, 3, 112, 1),
            ),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(80, 3, 112, 1),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle:
            const TextStyle(color: Color.fromRGBO(80, 3, 112, 1)),
        unselectedLabelStyle:
            const TextStyle(color: Color.fromRGBO(80, 3, 112, 1)),
        onTap: _onItemTapped,
      ),
    );
  }
}
