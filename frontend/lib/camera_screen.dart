import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/settings.dart';
import 'package:tflite/tflite.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _recording = false;
  bool _initialized = true;
  late CameraController _controller;
  late CameraImage cameraImage;
  late List recognitions;

  @override
  void initState() {
    _cameraSetUp();
    _loadModel();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    Tflite.close();
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
      _controller.stopImageStream();
      setState(() => _recording = false);
    } else {
      setState(() => _recording = true);
      _controller.startImageStream((image) {
        cameraImage = image;
        _runModel();
      });
    }
  }

  Future _loadModel() async {
    Tflite.close();
    await Tflite.loadModel(model: "", labels: "");
  }

  _runModel() async {
    recognitions = await Tflite.detectObjectOnFrame(
          bytesList: cameraImage.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage.height,
          imageWidth: cameraImage.width,
          imageMean: 127.5,
          imageStd: 127.5,
          numResultsPerClass: 1,
          threshold: 0.1,
        ) ??
        [];
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
                      MaterialPageRoute(builder: (context) => MySettingsPage()),
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
          ],
        ),
      );
    }
  }
}
