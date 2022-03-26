import 'dart:convert';

import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:frontend/settings.dart';
import 'package:frontend/user_info.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:image/image.dart' as IMG;
import 'package:native_screenshot/native_screenshot.dart';
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
  FlutterTts flutterTts = FlutterTts();

  late Timer timer;
  String output = "";
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
  _recordVideo(String userId) async {
    if (_recording) {
      timer.cancel();
      setState(() => _recording = false);
    } else {
      setState(() => _recording = true);
      timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) async {
        String? path = await NativeScreenshot.takeScreenshot();

        if (path == null || path.isEmpty) {
          print("Screenshot didnt work");
        }

        File imgFile = File(path!);
        // Cropping the image
        Uint8List bytes = imgFile.readAsBytesSync();
        IMG.Image? src = IMG.decodeImage(bytes);

        if (src != null) {
          IMG.Image destImage = IMG.copyCrop(src, 300, 990, 560, 560);
          var jpg = IMG.encodeJpg(destImage);
          // var res  = await imageToByteListFloat32(destImage, 560, 0.0, 255.0);

          // path = "../assets/images/IMG_4188.jpg";
          // Uint8List myGesture = File(path).readAsBytesSync();
          // IMG.Image? myImage = IMG.decodeImage(myGesture);
          // IMG.Image resizedImage = IMG.copyResize(myImage!, width:64, height:64);
          IMG.Image resizedImage =
              IMG.copyResize(destImage, width: 64, height: 64);
          var res = await Tflite.runModelOnBinary(
              binary: imageToByteListFloat32(resizedImage, 64, 0.0, 255.0),
              numResults: 29);
          if (res != null) {
            output = res[0]['label'];
            setState(() {});
          }

          print(res);
          // File croppedImage = await File(imgFile.path).writeAsBytes(jpg);
        }
      });
    }
  }

  Uint8List imageToByteListFloat32(
      IMG.Image img, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = img.getPixel(j, i);
        buffer[pixelIndex++] = (IMG.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (IMG.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (IMG.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  // Send video to flask backend
  void storeHistory(String userId, String translation) async {
    // parse URL
    var url = Uri.parse('http://10.0.2.2:5000/history');
    // http post request to backend Flask
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'id': userId, 'translation': translation}),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Create userInfo variable to access user_info class method
    final userInfo = Provider.of<UserInfo>(context);
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
              alignment: const Alignment(0, 0.715),
              child: Text(
                output,
                style: const TextStyle(fontSize: 15),
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
                  onPressed: () => _recordVideo(userInfo.getUserId),
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
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  iconSize: 35,
                  icon: const Icon(
                    Icons.volume_up,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await flutterTts.setLanguage("en-US");
                    await flutterTts.setPitch(1);
                    await flutterTts.speak(output);
                  },
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
