import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Screens/Login/LoginScreen.dart';
import 'package:todo_app/Screens/Registeration/RegisterScreen.dart';
import 'package:todo_app/Screens/homeScreen/HomeScreen.dart';
import 'package:todo_app/Screens/settingScreen/SettingScreen.dart';

import '../BottomSheet.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "home";

  HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 32,
        child: FloatingActionButton(
          onPressed: () {

            showADdTaskBottomSheet();

          },
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      body: pages[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/Icon awesome-list.png"),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/Icon feather-settings.png"),
              ),
              label: "Settings",
            )
          ],
        ),
      ),
    );
  }

  void showADdTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
      ),
      builder: (context) => BottomSheetWidget(),
    );
  }
}