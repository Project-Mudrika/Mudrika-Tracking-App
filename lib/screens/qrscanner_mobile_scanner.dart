import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  var _qrValue;
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
              });
              debugPrint('Barcode found! $code');
            }
          }),
    );
  }
}
