import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/views/widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0; // Initialize the current selected page index to 0

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx) {
          setState(() {
            pageIdx =
                idx; // Update the selected page index when a tab is tapped
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: pageIdx, // Set the current selected index
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.compass, size: 30),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: CustomIcon(), // Custom icon widget
            label: '', // No label for this tab
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.circleInfo, size: 30),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user, size: 30),
            label: 'Profile',
          ),
        ],
      ),
      body: pages[
          pageIdx], // Display the corresponding page based on the selected index
    );
  }
}
