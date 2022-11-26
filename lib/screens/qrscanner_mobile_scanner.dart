import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
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
              debugPrint('Barcode found! $code');
            }
          }),
    );
  }
}
