import 'package:flutter/material.dart';

import 'Screen/User/register.dart';
import 'Screen/home_page.dart';

class MyApp extends StatelessWidget {
  int signup;
  // MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.pink),
      //home: Homepage(),
      onGenerateRoute: RouteSettngsPage.generateRoute,
    );
  }
}

class RouteSettngsPage extends RouteSettings {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Registration());
        break;
      case "/signup":
        return MaterialPageRoute(builder: (_) => Registration());
        break;
      case "/home":
        return MaterialPageRoute(builder: (_) => Home());
        break;
    }
  }
}
