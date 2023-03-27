import 'package:flutter/material.dart';
import 'package:mvvm_provider/utils/Routes/routes.dart';
import 'package:mvvm_provider/utils/Routes/routes_name.dart';
import 'package:mvvm_provider/view/home_view.dart';
import 'package:mvvm_provider/view/login_view.dart';
import 'package:mvvm_provider/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
      child: MaterialApp(
        title: 'Mvvm Provider',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeView(),
        // initialRoute: RoutesName.loginRoute,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}


// 6 video 

