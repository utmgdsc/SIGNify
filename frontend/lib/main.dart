import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/custom_theme.dart';
import 'package:frontend/camera_screen.dart';
import 'package:frontend/settings.dart';
import 'package:frontend/home.dart';
import 'package:frontend/theme_model.dart';
import 'package:frontend/user_info.dart';
import 'package:image/image.dart' as image;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite/tflite.dart';
import 'dart:typed_data';

void LoadDetectionModel() async {
  Tflite.close();
  try {
    await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/labels.txt");
    print("Loaded model successfully");
    TestModel();
  } on Exception catch (e) {
    print("Failed to load model: " + e.toString());
  }
}

Uint8List imageToByteListFloat32(
    image.Image img, int inputSize, double mean, double std) {
  var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
  var buffer = Float32List.view(convertedBytes.buffer);
  int pixelIndex = 0;
  for (var i = 0; i < inputSize; i++) {
    for (var j = 0; j < inputSize; j++) {
      var pixel = img.getPixel(j, i);
      buffer[pixelIndex++] = (image.getRed(pixel) - mean) / std;
      buffer[pixelIndex++] = (image.getGreen(pixel) - mean) / std;
      buffer[pixelIndex++] = (image.getBlue(pixel) - mean) / std;
    }
  }
  return convertedBytes.buffer.asUint8List();
}

Future<image.Image> addAndResize(String s) async {
  var img = Image.asset(
    s,
    width: 64,
    height: 64,
  );
  ByteData testImg = (await rootBundle.load(s));
  image.Image? baseSizeImage = image.decodeImage(testImg.buffer.asUint8List());
  return image.copyResize(baseSizeImage!, height: 64, width: 64);
}

void TestModel() async {
  image.Image resizeImage;
  // image.copyResize(img, width: 64, height: 64);
  // var out = await Tflite.runModelOnBinary(binary: binary)
  try {
    var res;
    String ALPHA = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    int score = 0;
    for (int i = 0; i < 26; i++) {
      String imgSrc = "assets/images/" + ALPHA[i] + "_test.jpg";
      // To run model, first use the addAndResize to
      resizeImage = await addAndResize(imgSrc);
      res = await Tflite.runModelOnBinary(
          binary: imageToByteListFloat32(resizeImage, 64, 0.0, 255.0),
          numResults: 29);
      if (res[0]['label'] == ALPHA[i]) {
        score++;
      }
    }
    print("Model Score: " + ((score / 26) * 100).toString() + "%");
  } catch (e) {
    print("runModelError: " + e.toString());
  }
}

void main() {
  // Initialize widget binding
  WidgetsFlutterBinding.ensureInitialized();
  LoadDetectionModel();
  // Access app local data
  SharedPreferences.getInstance().then((sharedPreferences) {
    // Get local data with key
    var color = sharedPreferences.getString('ThemeColor');
    var isDark = sharedPreferences.getBool('isDark') ?? false;
    var fontSize = sharedPreferences.getDouble('fontSize') ?? 15;
    String userId = sharedPreferences.getString("userId") ?? "";

    // Set theme color according to local data
    if (color == 'pink') {
      currentTheme = createThemeData(Colors.pink, isDark, fontSize);
    } else if (color == 'orange') {
      currentTheme = createThemeData(Colors.orange, isDark, fontSize);
    } else if (color == 'brown') {
      currentTheme = createThemeData(Colors.brown, isDark, fontSize);
    } else if (color == 'lightBlue') {
      currentTheme = createThemeData(Colors.lightBlue, isDark, fontSize);
    } else if (color == 'purple') {
      currentTheme = createThemeData(Colors.purple, isDark, fontSize);
    } else {
      currentTheme = createThemeData(defaultColor, isDark, fontSize);
    }

    runApp(
      // Used for multiple provider, provider can be shared in all pages
      MultiProvider(
        providers: [
          // user_info class
          Provider(create: (context) => UserInfo(userId)),
          // theme_model class
          ChangeNotifierProvider(
              create: (context) => ThemeNotifier(currentTheme)),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    // Use provider class to update theme in real time
    return MaterialApp(
        title: 'SIGNify', theme: themeNotifier.getTheme, home: CameraScreen());
  }
}
