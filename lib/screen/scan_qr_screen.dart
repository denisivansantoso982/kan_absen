import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kan_absen/firebase/database.dart';
import 'package:kan_absen/models/data/present_data.dart';
import 'package:kan_absen/models/data/users_data.dart';
import 'package:kan_absen/models/present_model.dart';
import 'package:kan_absen/models/profile_model.dart';
import 'package:kan_absen/templates/alert_dialog_template.dart';
import 'package:kan_absen/templates/colour_template.dart';
import 'package:kan_absen/templates/text_style_template.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({Key? key}) : super(key: key);
  static const String route = "/scanqr_screen";

  @override
  _ScanQRScreenState createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // Barcode? _barcode;
  QRViewController? _qrViewController;
  bool isFlashOn = false;
  late DateTime presentTime;
  late DateTime homeTime;

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

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    _qrViewController!.pauseCamera();
    controller.scannedDataStream.listen((_value) {
      controller.pauseCamera();
      if (_value.code == 'Buana Paksa Indonesia') {
        _doScanProcess(context, _value, DateTime.now());
      } else {
        AlertDialogTemplate().showTheDialog(
          context: context,
          title: 'Terjadi Kesalahan!',
          content: 'QRCode anda salah!',
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
                _qrViewController!.resumeCamera();
              },
              color: ColourTemplate.primaryColour,
              child: Text(
                "OKE",
                style: TextStyleTemplate.boldWhite(size: 18),
              ),
            ),
          ],
        );
      }
    });
  }

  void _doScanProcess(
      BuildContext context, Barcode barcode, DateTime scanTime) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      final UsersData? profile = Provider.of<ProfileModel>(context, listen: false).theProfile;
      final PresentData? present = Provider.of<PresentModel>(context, listen: false).thePresentData;
      if (scanTime.isBefore(presentTime) || scanTime.isAfter(presentTime) && scanTime.isBefore(homeTime)) {
        await doScanPresent(profile!.uid, scanTime.millisecondsSinceEpoch);
        Navigator.of(context).pop();
      } else {
        await doScanHome(present!.uid, profile!.uid, present.present, scanTime.millisecondsSinceEpoch);
        Navigator.of(context).pop();
      }
      Navigator.of(context).pop();
    } catch (error) {
      Navigator.of(context).pop();
      AlertDialogTemplate().showTheDialog(
        context: context,
        title: "Terjadi Kesalahan",
        content: error.toString(),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            color: ColourTemplate.primaryColour,
            child: Text(
              "OKE",
              style: TextStyleTemplate.boldWhite(size: 18),
            ),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, DateTime> argu =
        ModalRoute.of(context)!.settings.arguments as Map<String, DateTime>;
    presentTime = argu.values.elementAt(0);
    homeTime = argu.values.elementAt(1);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.chevron_left_outlined,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Row(
                  children: [
                    MaterialButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          isFlashOn = !isFlashOn;
                        });
                        _qrViewController!.toggleFlash();
                      },
                      child: Icon(
                        isFlashOn
                            ? Icons.flash_off_outlined
                            : Icons.flash_on_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    MaterialButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        _qrViewController!.flipCamera();
                      },
                      child: const Icon(
                        Icons.flip_camera_ios_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (QRViewController controller) {
                _qrViewController = controller;
                _onQRViewCreated(controller, context);
              },
              overlay: QrScannerOverlayShape(
                borderColor: ColourTemplate.primaryColour,
                borderRadius: 4,
                borderLength: 24,
                borderWidth: 4,
              ),
              formatsAllowed: const [BarcodeFormat.qrcode],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Text(
                'Pastikan untuk Kamera mendapat gambar dengan jernih!',
                textAlign: TextAlign.center,
                style: TextStyleTemplate.mediumWhite(size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
