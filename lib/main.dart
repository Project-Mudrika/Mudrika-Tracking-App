import 'package:flutter/material.dart';
import 'package:live_tracking/models/AccountInfo.dart';
import 'package:live_tracking/screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: "https://netlauydpmmztazzzldy.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5ldGxhdXlkcG1tenRhenp6bGR5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTUyODE4MTgsImV4cCI6MTk3MDg1NzgxOH0.EOi8V57Djyl7qSUwPHtrjvUn18keF2gVMeRkwnOB1cQ");

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
