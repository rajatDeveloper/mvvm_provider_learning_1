import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        Center(
          child: Text("Logout"),
        ),
        SizedBox(
          width: 20,
        )
      ]),
      body: SafeArea(
        child: Column(
          children: [Text("Home screen")],
        ),
      ),
    );
  }
}
