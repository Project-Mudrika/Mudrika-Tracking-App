import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  late Future<CameraController> _controller;

  Future<CameraController> fetchCam() async {
    WidgetsFlutterBinding.ensureInitialized();
    var cameras = await availableCameras();
    var firstCamera = cameras.first;
    var controller = CameraController(firstCamera, ResolutionPreset.medium);
    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }

    return controller;
  }

  @override
  void initState() {
    super.initState();
    _controller = fetchCam();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _controller,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: CameraPreview(snapshot.data!),
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      try {
                        await _controller;
                        final image = await snapshot.data?.takePicture();
                        if (!mounted) return;

                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DisplayPictureScreen(
                                  imagePath: image!.path,
                                )));
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Icon(Icons.camera),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
