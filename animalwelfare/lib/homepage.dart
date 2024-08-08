import 'package:animalwelfare/Animal_hospital.dart';
import 'package:animalwelfare/homescreen.dart';
import 'package:animalwelfare/profilescreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomeScreen(),
    const AnimalHospital(),
    const ProfileScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        // AnnotatedRegion<SystemUiOverlayStyle>(
        //   value: SystemUiOverlayStyle.dark.copyWith(
        //     // statusBarColor: Colors.white, // Set to your desired color
        //   ),
        // child:
        Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _children.elementAt(_currentIndex),
      ),
      bottomNavigationBar: Stack(
        children: [
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/images/bg-2.png',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          SizedBox(
            height: 65,
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              currentIndex: _currentIndex,
              elevation: 0,
              unselectedItemColor: Colors.grey[600],
              selectedItemColor: Colors.amber[800],
              onTap: onTabTapped,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/002-dog-house.png',
                    width: 22,
                    height: 22,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/002-dog-house.png',
                    width: 28,
                    height: 28,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/003-animal-hospital.png',
                    width: 26,
                    height: 26,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/003-animal-hospital.png',
                    width: 31,
                    height: 31,
                  ),
                  label: 'Animal Hopsital',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/004-user.png',
                    width: 24,
                    height: 24,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/004-user.png',
                    width: 31,
                    height: 31,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
