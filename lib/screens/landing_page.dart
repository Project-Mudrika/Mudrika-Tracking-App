import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/AccountInfo.dart';
import 'login_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    if (Provider.of<AccountInfo>(context, listen: false)
            .accountInfo["accountAddress"] ==
        '') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mudrika")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
        child: Column(children: [
          Consumer<AccountInfo>(builder: (context, accountInfo, child) {
            return Text(
              // "Welcome, ${accountInfo.accountInfo['firstName']} ${accountInfo.accountInfo['lastName']}");
              "Welcome,\n${accountInfo.accountInfo['accountAddress']}",
              style: GoogleFonts.montserrat(
                  fontSize: 48, fontWeight: FontWeight.w600),
            );
          }),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 2))
                  ]),
              child: Card(
                // margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: Column(children: const [
                    Icon(Icons.qr_code_scanner),
                    Text("Scan QR Code")
                  ]),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
