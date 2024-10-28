import 'package:flutter/material.dart';
import 'package:study_sheek_food_ios/pages/home/home_page.dart';
import 'package:study_sheek_food_ios/pages/profile/profile_page.dart';
import 'package:study_sheek_food_ios/pages/recipe/recipe_page.dart';
import 'package:study_sheek_food_ios/pages/restaurant/restaurant_page.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  /// 当前页面下标
  int _currentIndex = 0;

  /// 页面列表
  final List<Widget> _pages = [];

  /// 导航项列表
  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      label: '',
      icon: SizedBox(
        height: 80,
        child: Center(
          child: Image.asset('assets/icons/tab/tab_home.png'),
        ),
      ),
      activeIcon: Image.asset('assets/icons/tab/tab_home_select.png'),
    ),
    BottomNavigationBarItem(
      label: '',
      icon: SizedBox(
        height: 60,
        child: Center(
          child: Image.asset('assets/icons/tab/tab_recipe.png'),
        ),
      ),
      activeIcon: Image.asset('assets/icons/tab/tab_recipe_select.png'),
    ),
    BottomNavigationBarItem(
      label: '',
      icon: Image.asset('assets/icons/tab/tab_restaurant.png'),
      activeIcon: Image.asset('assets/icons/tab/tab_restaurant_select.png'),
    ),
    BottomNavigationBarItem(
      label: '',
      icon: Image.asset('assets/icons/tab/tab_profile.png'),
      activeIcon: Image.asset('assets/icons/tab/tab_profile_select.png'),
    )
  ];

  @override
  void initState() {
    super.initState();
    _pages.addAll([HomePage(), RecipePage(), RestaurantPage(), ProfilePage()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff4E4A55),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _items,
      ),
    );
  }
}
