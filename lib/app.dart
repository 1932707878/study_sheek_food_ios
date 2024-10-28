import 'package:flutter/material.dart';
import 'package:study_sheek_food_ios/routes/route_utils.dart';
import 'package:study_sheek_food_ios/routes/routes.dart';

class SheekApp extends StatelessWidget {
  const SheekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.greenAccent,
          highlightColor: Color.fromRGBO(0, 0, 0, 0),
          splashColor: Color.fromRGBO(0, 0, 0, 0)),
      navigatorKey: RouteUtils.navigatorKey,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: RoutePath.tab,
      // home: HomePage(),
    );
  }
}
