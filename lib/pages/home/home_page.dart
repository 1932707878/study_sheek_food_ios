import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:study_sheek_food_ios/pages/home/home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 界面数据
  var data = HomeViewModel.initData();

  /// 搜索值
  var searchValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff6A6872),
        child: SafeArea(
          child: Column(
            children: [
              // 搜索框
              _searchContainer(),
              // 页面主体
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 320,
                      margin:
                          const EdgeInsets.only(top: 20, bottom: 20, left: 20),
                      color: const Color(0xff2D2C33),
                      child: Column(
                        children: [
                          // 内部主体
                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(left: 32),
                              child: Column(
                                children: [
                                  // 标题
                                  _titleContainer(data.title),
                                  // 简介
                                  _introContainer(data.intro),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: _getMainView(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 520,
                        margin: const EdgeInsets.only(left: 16, bottom: 20),
                        color: const Color(0xffF2F2F9).withOpacity(0.2),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// ### 主体
  ///
  /// 包括标签、卡路里、图片、价格
  Stack _getMainView() {
    return Stack(
      children: [
        // 三角背景
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: TriangleClipper(),
            child: SizedBox(
              height: 280,
              width: double.infinity,
              child: Image.asset(
                'assets/icons/home/home_bg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _getBottomPrice(data.order, data.cook),
        ),
        Positioned(
          top: 40,
          bottom: 100,
          left: 100,
          right: 0,
          child: SizedBox(
            child: OverflowBox(
              alignment: Alignment.topLeft,
              maxHeight: 300,
              maxWidth: 300,
              child: Image.asset(
                'assets/icons/home/home_chicken.png',
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ),
        Positioned(
            top: 0,
            left: 32,
            right: 0,
            child: Column(
              children: [
                // 标签
                Container(
                    margin: const EdgeInsets.only(top: 32, right: 48),
                    width: double.infinity,
                    child: Row(
                      children: showTags(data.tags),
                    )),
                // 卡路里
                _calorieContainer(data.kCalorie),
              ],
            )),
      ],
    );
  }

  /// 底部价格
  ///
  /// - order order价
  /// - order cook价
  SizedBox _getBottomPrice(double order, double cook) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff5A5A5F),
                    Color.fromARGB(255, 94, 99, 105)
                  ]),
            ),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Row(
                children: [
                  const Expanded(
                      child: Center(
                          child: Text(
                    'Order',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffE5C27A),
                    ),
                  ))),
                  Expanded(
                      child: Center(
                          child: Text(
                    '$order \$',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff9F9FAF),
                    ),
                  ))),
                ],
              ),
            ),
          )),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff4F555B), Color(0xff4C5256)])),
            child: Row(
              children: [
                const Expanded(
                    child: Center(
                        child: Text(
                  'Cook',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffE5C27A),
                  ),
                ))),
                Expanded(
                    child: Center(
                        child: Text(
                  '$cook \$',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff9F9FAF),
                  ),
                ))),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Container _calorieContainer(int kCalorie) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 16, left: 5),
      child: Text(
        '$kCalorie kcal',
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xff9F9FAF),
        ),
      ),
    );
  }

  /// 标签组
  List<Widget> showTags(List<String> tags) {
    List<Widget> tagsWidget = [];
    var first = true;
    for (var item in tags) {
      if (first) {
        // 第一次
        first = false;
      } else {
        tagsWidget.add(const SizedBox(width: 8));
      }
      tagsWidget.add(getTagItem(item));
    }
    return tagsWidget;
  }

  /// 单个标签
  SizedBox getTagItem(String label) {
    return SizedBox(
      height: 24,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: const Color(0xffF2F2F9).withOpacity(0.2),
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffF2F2F9),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 简介
  Container _introContainer(String intro) {
    return Container(
      margin: const EdgeInsets.only(top: 30, right: 48),
      child: Text(
        intro,
        style: const TextStyle(
            color: Color(0xffF2F2F9),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.5),
      ),
    );
  }

  /// 标题
  Container _titleContainer(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 48,
          height: 1.2,
          fontWeight: FontWeight.bold,
          color: Color(0xffE5C27A),
        ),
      ),
    );
  }

  /// 搜索框
  Container _searchContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xffECECEC).withOpacity(0.9),
          borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.all(2),
                child: TextField(
                  onChanged: (value) => searchValue = value,
                  onSubmitted: (value) => _searchHomeFood(),
                  decoration: const InputDecoration(
                    hintText: 'Food name',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(height: 1.55),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _searchHomeFood(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'assets/icons/home/home_search.png',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 搜索首页食物
  _searchHomeFood() {
    log('开始搜索：$searchValue');
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(20, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
