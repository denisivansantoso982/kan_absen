import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({Key? key}) : super(key: key);
  static const String route = "/scanqr_screen";

  @override
  _ScanQRScreenState createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? _barcode;
  QRViewController? _qrViewController;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _qrViewController!.pauseCamera();
    } else if (Platform.isIOS) {
      _qrViewController!.resumeCamera();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _qrViewController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                (_barcode != null) ? 'Barcode Type: ${describeEnum(_barcode!.format)}   Data: ${_barcode!.code}' : 'Scan Code',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController _qrViewController) {
    this._qrViewController = _qrViewController;
    _qrViewController.scannedDataStream.listen((_value) {
      setState(() {
        _barcode = _value;
      });
    });
  }
}
