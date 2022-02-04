import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

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

  _cameraSetUp() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[1], ResolutionPreset.max);
    await _controller.initialize();
    setState(() => _initialized = false);
  }

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
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CameraPreview(_controller),
          Container(
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.black54,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: FloatingActionButton(
              backgroundColor: const Color(0xFFA5D6D1),
              child: Icon(_recording ? Icons.stop : Icons.circle),
              onPressed: () => _recordVideo(),
            ),
          ),
        ],
      );
    }
  }
}
