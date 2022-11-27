import 'package:flutter/material.dart';
import 'package:live_tracking/models/AccountInfo.dart';
import 'package:live_tracking/screens/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => AccountInfo(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xffe4f7ec),
            // body: MapPage(),
            body: LoginPage(),
          ),
        ));
  }
}
