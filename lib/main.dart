import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_tracking/screens/map_page.dart';
import 'package:live_tracking/services/location_service.dart';

void main() {
  runApp(MyApp());
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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 120, horizontal: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(36, 31, 31, 0.13),
            spreadRadius: 5,
            blurRadius: 12,
            offset: Offset(4, 4),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Mudrika",
              style: GoogleFonts.lora(fontSize: 48),
              textAlign: TextAlign.center,
            ),
            Text(
              "Disaster Management Infrastructure",
              style: GoogleFonts.yrsa(
                  fontSize: 14, color: const Color(0xFF33322B)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5b5750)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.wallet),
                      SizedBox(width: 8),
                      Text("Sign In with Metamask"),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
