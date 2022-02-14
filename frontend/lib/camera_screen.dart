import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/settings.dart';

class CameraScreen extends StatefulWidget {
  final MaterialColor theme;
  const CameraScreen({Key? key, required this.theme}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _recording = false;
  bool _initialized = true;
  late CameraController _controller;

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
      final file = await _controller.stopVideoRecording();
      setState(() => _recording = false);
    } else {
      await _controller.startVideoRecording();
      setState(() => _recording = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: Stack(
          children: [
            CameraPreview(_controller),
            Align(
              alignment: Alignment.topRight,
              child: SafeArea(
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MySettingsPage(theme: widget.theme)),
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
                  backgroundColor: widget.theme[900],
                  child: Icon(_recording ? Icons.stop : Icons.circle),
                  onPressed: () => _recordVideo(),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
