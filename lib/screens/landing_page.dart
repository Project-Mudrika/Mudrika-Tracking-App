import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_tracking/screens/login_page.dart';
import 'package:live_tracking/models/AccountInfo.dart';
import 'package:live_tracking/screens/qrscanner_mobile_scanner.dart';
import 'package:provider/provider.dart';

import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;

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
    var _accountAddress = Provider.of<AccountInfo>(context, listen: false)
        .accountInfo["accountAddress"];
    var accountDetails = fetchAccountInfo(_accountAddress!)
        .then((value) => print("Received details: $value"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe4f7ec),
      appBar: AppBar(
          title: const Text("Mudrika"),
          backgroundColor: const Color(0xFF33322B)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Welcome,\n",
            style: GoogleFonts.montserrat(
                fontSize: 32, fontWeight: FontWeight.w300),
          ),
          Consumer<AccountInfo>(builder: (context, accountInfo, child) {
            return Text(
              // "Welcome, ${accountInfo.accountInfo['firstName']} ${accountInfo.accountInfo['lastName']}");
              "${accountInfo.accountInfo['accountAddress']}",
              style: GoogleFonts.montserrat(
                  fontSize: 48, fontWeight: FontWeight.w600),
            );
          }),
          FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 2))
                  ]),
              child:
                  Consumer<AccountInfo>(builder: (context, accountInfo, child) {
                return ElevatedButton(
                  // margin: const EdgeInsets.all(16),

                  onPressed: () async {
                    if (await isAuthority(
                        accountInfo.accountInfo['accountAddress']!)) {
                      print("Authority aane");
                    } else {
                      print("Driver aane");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5b5750)),
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QRScanner())),
                    child: Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: Column(children: const [
                        Icon(Icons.qr_code_scanner),
                        Text("Scan QR Code")
                      ]),
                    ),
                  ),
                );
              }),
            ),
          )
        ]),
      ),
    );
  }
}

final supabase = Supabase.instance.client;

Future<dynamic> fetchAccountInfo(String _accountAddress) async {
  late dynamic accountDetails;
  var response = await supabase
      .from('driver')
      .select()
      .eq("account_address", _accountAddress)
      .then((value) {
    print(value);
    accountDetails = value;
  });
  return accountDetails;
}

Future<bool> isAuthority(String _accountAddress) async {
  late dynamic fetchedInfo;
  await supabase
      .from('driver')
      .select("account_address")
      .eq("account_address", _accountAddress)
      .then((value) => fetchedInfo = value);
  print("IsAuthority: $fetchedInfo");
  return fetchedInfo == [];
}
