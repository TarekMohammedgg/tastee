import 'package:flutter/material.dart';
import 'routes.dart';
// import screens as you add features...

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Add cases here as features grow
      // case Routes.login:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("No Route Found")),
          ),
        );
    }
  }
}
