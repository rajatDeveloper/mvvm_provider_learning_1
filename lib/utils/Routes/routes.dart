import 'package:flutter/material.dart';
import 'package:mvvm_provider/utils/Routes/routes_name.dart';
import 'package:mvvm_provider/view/home_view.dart';
import 'package:mvvm_provider/view/login_view.dart';
import 'package:mvvm_provider/view/signup_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeRoute:
        return MaterialPageRoute(builder: (BuildContext context) => HomeView());

      case RoutesName.loginRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginView());

      case RoutesName.signupRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUpView());

      default:
        return MaterialPageRoute(builder: ((_) {
          return const Scaffold(
            body: Center(child: Text("No Screen Error")),
          );
        }));
    }
  }
}
