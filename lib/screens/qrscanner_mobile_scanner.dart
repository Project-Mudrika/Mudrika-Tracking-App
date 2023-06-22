import 'package:flutter/material.dart';
import 'package:live_tracking/constants/user_type.dart';
import 'package:live_tracking/models/Consignment.dart';
import 'package:live_tracking/screens/landing_page.dart';
import 'package:live_tracking/screens/qrscanner_response.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class QRScanner extends StatefulWidget {
  final userType;
  const QRScanner({super.key, this.userType = UserType.driver});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  late String _qrValue;
  late String _consId;
  late String _sender;
  late String _receiver;

  // qrValue = {
  //  8ohdf990hw0f;0xFF5b57500odj34j;0x048jsd8ds96s
  //  (consID; senderAddress; receiverAddress)
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: MobileScanner(
          // allowDuplicates: false,
          controller: MobileScannerController(
              facing: CameraFacing.back, torchEnabled: false),
          onDetect: (barcode) {
            if (barcode.barcodes.first.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final String code = barcode.barcodes.first.rawValue!;
              setState(() {
                _qrValue = code;
                var splitCode = code.split(";");
                _consId = splitCode[0];
                _sender = splitCode[1];
                _receiver = splitCode[2];
              });
              // var consDetails =
              fetchConsignmentDetails(_consId, _receiver).then((value) {
                print("Consignment details: $value");
                // Provider.of<Consignment>(context, listen: false)
                //     .updateConsignmentField("sender", value[0]);
                // Provider.of<Consignment>(context, listen: false)
                //     .updateConsignmentField("receiver", value[1]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRScannerResponsePage(
                        sender: value[0],
                        receiver: value[1],
                        userType: widget.userType,
                      ),
                    ));
              });
              debugPrint('Barcode found! $code');
            }
          }),
    );
  }
}

Future<List<dynamic>> fetchConsignmentDetails(
    String consId, String receiver) async {
  late List<String> consignmentDetails = ["", ""];
  var senderResponse = await supabase
      .from('consignments')
      .select("location")
      .eq("cons_id", consId)
      .then((value) {
    print("sender $consId : $value");
    return consignmentDetails[0] = value[0]["location"];
  });
  var receiverResponse = await supabase
      .from('authority')
      .select("district")
      .eq("accid", receiver)
      .then((value) {
    print("recvr $receiver : $value");
    return consignmentDetails[1] = value[0]["district"];
  });
  return consignmentDetails;
}
