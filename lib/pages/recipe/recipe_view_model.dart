import 'dart:ui';

import 'package:flutter/material.dart';

class RecipeItem extends StatelessWidget {
  // TODO 组件默认值

  Stack _getRecipeItem() {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 40, right: 40),
          color: const Color(0xff29282e),
          child: Stack(
            children: [
              // 三角纹理
              Positioned(
                top: 20,
                left: 0,
                right: 0,
                child: ClipPath(
                  clipper: TriangleClipper(),
                  child: Image.asset('assets/icons/home/home_bg.png'),
                ),
              ),
              // 底部数据
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 56,
                  child: _getBottomView(910, 6, 35),
                ),
              )
            ],
          ),
        ),
        // 图片
        Positioned(
          top: 20,
          bottom: 76,
          right: 20,
          child: SizedBox(
            width: 200,
            child: OverflowBox(
              alignment: Alignment.centerRight,
              maxHeight: 210,
              child: Image.asset(
                'assets/icons/home/home_patatas.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        // 标题和标签
        Positioned(
          top: 20,
          left: 60,
          right: 60,
          child: Column(
            children: [
              // 标题
              _getTitleView('Tortilla De Patatas'),
              // 标签
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: double.infinity,
                  child: Row(
                    children: showTags(['VEGETERIAN', 'SPANISH']),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  /// 标题视图
  Text _getTitleView(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 48,
        height: 1.2,
        fontWeight: FontWeight.w900,
        color: Color(0xffE5C27A),
      ),
    );
  }

  /// 底部数据视图
  Row _getBottomView(int calorie, persons, minutes) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: const Color(0xff616066),
            child: Container(
              margin: const EdgeInsets.only(top: 8, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$calorie',
                    style: const TextStyle(
                      color: Color(0xffF2F2F9),
                      fontSize: 16,
                      height: 1.2,
                    ),
                  ),
                  const Text(
                    'kcal / meal',
                    style: TextStyle(
                      color: Color(0xff9F9FAF),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: const Color(0xff84868d),
            child: Container(
              margin: const EdgeInsets.only(top: 8, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$persons',
                    style: const TextStyle(
                      color: Color(0xffF2F2F9),
                      fontSize: 16,
                      height: 1.2,
                    ),
                  ),
                  const Text(
                    'persons',
                    style: TextStyle(
                      color: Color(0xff9F9FAF),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: const Color(0xff616066),
            child: Container(
              margin: const EdgeInsets.only(top: 8, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$minutes',
                    style: const TextStyle(
                      color: Color(0xffF2F2F9),
                      fontSize: 16,
                      height: 1.2,
                    ),
                  ),
                  const Text(
                    'minutes',
                    style: TextStyle(
                      color: Color(0xff9F9FAF),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
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

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
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
