import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:study_sheek_food_ios/common/tab_indicator_widgets.dart';

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff595761),
            title: const TabBar(
              labelColor: Color(0xffe5c27a),
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelColor: Color.fromARGB(255, 197, 192, 192),
              // indicatorPadding:
              //     EdgeInsets.only(bottom: 5, left: -10, right: -10),
              indicator: CustomUnderlineTabIndicator(
                width: -1,
                borderSide: BorderSide(width: 4, color: Color(0xffe5c27a)),
                insets: EdgeInsets.only(bottom: 5, left: -10, right: -10),
              ),
              dividerHeight: 0,
              tabs: [
                Tab(child: Text('Basics')),
                Tab(child: Text('Fast Dishes')),
              ],
            ),
          ),
          body: Container(
            color: const Color(0xff6A6872),
            child: Column(
              children: [
                // 顶部导航栏
                Container()
                // 内容主体
              ],
            ),
          )),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
