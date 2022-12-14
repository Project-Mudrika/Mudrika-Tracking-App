import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_tracking/models/AccountInfo.dart';
import 'package:live_tracking/screens/landing_page.dart';
import 'package:live_tracking/screens/qrscanner_mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

const bool LOGIN_DEV_FLAG = false;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'Mudrika',
          description: 'Disaster Management Infrastructure',
          url: 'https://walletconnect.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));

  var _session, _uri, _account;

  loginWithWallet(BuildContext context, {bool devFlag = false}) async {
    if (devFlag) {
      _account = "0xd1CfE5c21023C4F9TESTa7dACCOUNT22Bb4742";
      Provider.of<AccountInfo>(context, listen: false)
          .updateAccountField("accountAddress", _account);
      return;
    }
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        setState(() {
          _session = session;
        });
      } catch (exp) {
        print(exp);
      }
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LandingPage()));
    }

    setState(() {
      _account = _session.accounts[0];
      Provider.of<AccountInfo>(context, listen: false)
          .updateAccountField("accountAddress", _account);
      print("Account: $_account");
    });
  }

// Load Landing Page if wallet is already connected
  @override
  void initState() {
    super.initState();
    if (connector.connected) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LandingPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    connector.on(
        "connect",
        (session) => setState(() {
              _session = session;
            }));
    connector.on(
        "session_update",
        (payload) => setState(() {
              _session = payload;
              print(payload);
            }));
    connector.on("disconnect", (payload) => setState(() => _session = null));

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
                // onPressed: () => Navigator.push(
                //     context,
                //     // ignore: prefer_const_constructors
                //     MaterialPageRoute(builder: (context) => QRScanner())),
                onPressed: () async {
                  await loginWithWallet(context, devFlag: LOGIN_DEV_FLAG);
                  if (!mounted) {
                    return;
                  }
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LandingPage()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5b5750)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/metamask.png",
                        width: 27,
                      ),
                      const SizedBox(width: 8),
                      Text("Sign In with Metamask",
                          style: GoogleFonts.varelaRound()),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
