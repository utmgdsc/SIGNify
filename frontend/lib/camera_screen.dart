import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:screenshot/screenshot.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/settings.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _recording = false;
  bool _initialized = true;
  late CameraController _controller;
  late Timer timer;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    _cameraSetUp();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Set up the front camera
  _cameraSetUp() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[1], ResolutionPreset.max);
    await _controller.initialize();
    setState(() => _initialized = false);
  }

  // Start or stop recording
  _recordVideo() async {
    if (_recording) {
      timer.cancel();
      setState(() => _recording = false);
    } else {
      setState(() => _recording = true);
      timer = Timer.periodic(const Duration(milliseconds: 500), (timer) async {
        screenshotController.capture().then((capturedImage) async {
          File image = File.fromRawPath(capturedImage!);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Screenshot(
        controller: screenshotController,
        child: Scaffold(
          body: Stack(
            children: [
              CameraPreview(_controller),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 5,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MySettingsPage()),
                      );
                    },
                    icon: const Icon(
                      Icons.settings,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.black54,
                  padding: const EdgeInsets.all(25),
                  child: FloatingActionButton(
                    child: Icon(_recording ? Icons.stop : Icons.circle),
                    onPressed: () => _recordVideo(),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 200,
                height: 200,
                child: Text(""),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 5,
                    )),
              ),
            )
          ],
            ],
          ),
        ),
      );
    }
  }
}
