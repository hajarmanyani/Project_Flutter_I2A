import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: ImageClassificationPage(),
    );
  }
}

class ImageClassificationPage extends StatefulWidget {
  @override
  _ImageClassificationPageState createState() => _ImageClassificationPageState();
}

class _ImageClassificationPageState extends State<ImageClassificationPage> {
  List<dynamic>? _recognitions;
  bool _isModelReady = false;
  late String _selectedImagePath = '';

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    try {
      String? res = await Tflite.loadModel(
        model: "assets/model2.tflite",
        labels: "assets/labels.txt",
      );
      print(res);
      setState(() {
        _isModelReady = true;
      });
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  Future<void> classifyImage(String imagePath) async {
    var recognitions = await Tflite.runModelOnImage(
      path: imagePath,
    );

    setState(() {
      _recognitions = recognitions;
    });
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Do something with the picked image
      print("Image path: ${pickedFile.path}");
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
      classifyImage(_selectedImagePath!);
    } else {
      print("No image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Classification'),
      ),
      body: _isModelReady
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _selectedImagePath.isNotEmpty
              ? Image.file(File(_selectedImagePath), height: 200.0, width: 200.0)
              : Text("Select an image"),
          SizedBox(height: 20),
          _recognitions != null
              ? Text("Prediction: ${_recognitions![0]['label'].toString().substring(2)}")
              : Container(),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: getImage,
            child: Text("Pick Image"),
          ),
        ],
         )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
