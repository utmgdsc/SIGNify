import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/settings.dart';
import 'package:frontend/user_info.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
      XFile videoFile = await _controller.stopVideoRecording();
      print(await uploadVideo(File(videoFile.path), userId));
      setState(() => _recording = false);
    } else {
      await _controller.startVideoRecording();
      setState(() => _recording = true);
    }
  }

  Future<String> uploadVideo(File file, String userId) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:5000/upload_video'));
    request.fields['id'] = userId;
    request.files.add(await http.MultipartFile.fromPath('video', file.path));
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    return jsonDecode(response.body)['text'];
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
                  onPressed: () => _recordVideo(userInfo.getUserId),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
