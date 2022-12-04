import 'package:flutter/material.dart';
import 'package:live_tracking/models/Consignment.dart';
import 'package:provider/provider.dart';

class QRScannerResponsePage extends StatelessWidget {
  final sender, receiver;
  // ignore: prefer_const_constructors_in_immutables
  QRScannerResponsePage({super.key, this.sender, this.receiver});

  @override
  Widget build(BuildContext context) {
    // var consignmentDetails = Provider.of<Consignment>(context).consignment;
    // print("hello");
    // print(consignmentDetails);
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
            // Consumer<Consignment>(
            //   builder: (context, consignmentDetails, child) {
            //     return Text(consignmentDetails.consignment["sender"]!);
            //   },
            // ),
            Text(sender!),
            const Text("To"),
            // Consumer<Consignment>(
            //   builder: (context, consignmentDetails, child) {
            //     return Text(consignmentDetails.consignment["receiver"]!);
            //   },
            // ),
            Text(receiver!)
          ],
        )),
      ),
    );
  }
}
