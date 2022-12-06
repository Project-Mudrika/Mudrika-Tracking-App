import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_tracking/constants/user_type.dart';
import 'package:live_tracking/models/Consignment.dart';
import 'package:live_tracking/screens/map_page.dart';
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
        child: SizedBox.expand(
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Consignment Transit",
                  style: GoogleFonts.lora(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  "From",
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),

                // Consumer<Consignment>(
                //   builder: (context, consignmentDetails, child) {
                //     return Text(consignmentDetails.consignment["sender"]!);
                //   },
                // ),

                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.location_on_outlined),
                  Expanded(
                    child: Text(
                      receiver!,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
                Text(
                  "To",
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
                // Consumer<Consignment>(
                //   builder: (context, consignmentDetails, child) {
                //     return Text(consignmentDetails.consignment["receiver"]!);
                //   },
                // ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.location_on),
                  Expanded(
                    child: Text(
                      sender!,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MapPage(
                                  userType: UserType.driver,
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.bus_alert),
                      const SizedBox(
                        width: 16,
                      ),
                      Flexible(
                        child: Text(
                          "Start Journey",
                          style: GoogleFonts.montserrat(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
