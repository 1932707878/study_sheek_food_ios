import 'package:flutter/material.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff595761),
      body: Center(
        child: Container(
          height: 300,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 40, right: 40),
          color: const Color(0xff29282e),
          child: Stack(
            children: [
              // 三角纹理
              Positioned(
                bottom: -40,
                left: 0,
                right: -20,
                child: ClipPath(
                  clipper: TriangleClipper(),
                  child: Container(
                    // TODO 没有设计图黑
                    color: Colors.black.withOpacity(1),
                    child: Image.asset('assets/icons/home/home_bg.png'),
                  ),
                ),
              ),
              // 标题
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Container(
                  child: Text(
                    'Tortilla De Patatas',
                    style: TextStyle(
                      fontSize: 48,
                      height: 1.2,
                      fontWeight: FontWeight.w900,
                      color: Color(0xffE5C27A),
                    ),
                  ),
                ),
              ),
              // 标签
              // 底部数据
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 56,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: const Color(0xff616066),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: const Color(0xff84868d),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: const Color(0xff616066),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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
