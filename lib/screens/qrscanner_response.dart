import 'package:flutter/material.dart';
import 'package:live_tracking/models/Consignment.dart';
import 'package:provider/provider.dart';

class QRScannerResponsePage extends StatefulWidget {
  const QRScannerResponsePage({super.key});

  @override
  State<QRScannerResponsePage> createState() => _QRScannerResponsePageState();
}

class _QRScannerResponsePageState extends State<QRScannerResponsePage> {
  @override
  void initState() {
    super.initState();
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
        child: Card(
            child: Column(
          children: [
            const Text("From"),
            Consumer<Consignment>(
              builder: (context, consignmentDetails, child) {
                return Text(consignmentDetails.consignment["sender"]!);
              },
            ),
            const Text("To"),
            Consumer<Consignment>(
              builder: (context, consignmentDetails, child) {
                return Text(consignmentDetails.consignment["receiver"]!);
              },
            ),
          ],
        )),
      ),
    );
  }
}
