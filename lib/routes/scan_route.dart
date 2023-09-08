import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:scavengerhunt/misc/painters/scan_route_painters/barcode_detector_painter.dart';
import 'package:scavengerhunt/misc/painters/scan_route_painters/detector_view.dart';
import 'package:scavengerhunt/routes/scan_route_screen/scanned_screen.dart';

class BarcodeScannerView extends StatefulWidget {
  final User user;
  const BarcodeScannerView({super.key, required this.user});

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  var _cameraLensDirection = CameraLensDirection.back;
  CustomPaint? _customPaint;
  String? _text;
  String? _code;
  double _screenWidth = 0;
  double _screenHeight = 0;
  bool _canProcess = true;
  bool _isBusy = false;
  bool _didCapture = false;

  @override
  void initState() {
    _code = null;
    _didCapture = false;
    super.initState();
  }

  @override
  void dispose() {
    _canProcess = false;
    _didCapture = false;
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return _code == null ? DetectorView(
      title: 'Barcode Scanner',
      customPaint: _customPaint,
      text: _text,
      onImage: _processImage,
      onCapture: _captureCode,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    ) : scannedScreen(context, _screenWidth, _screenHeight, widget.user, _code!);
  }

  void _captureCode(){
    setState(() {
      _didCapture = true;
    });
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final barcodes = await _barcodeScanner.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = BarcodeDetectorPainter(
        barcodes,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
      print('_didCapture: $_didCapture');
      print('_barcodes: ${barcodes.length}');
      if (_didCapture && barcodes.length == 1)  {
        setState(() {
          _code = barcodes.first.displayValue;
        });
        _didCapture = false;
      }
      _didCapture = false;
    } else {
      String text = 'Barcodes found: ${barcodes.length}\n\n';
      for (final barcode in barcodes) {
        text += 'Barcode: ${barcode.rawValue}\n\n';
      }
      _text = text;
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}