import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:winsvold/utils/navigator_arguments.dart';
import 'package:winsvold/views/routes.dart';

// [0-9]{4}-[0-9]{2}-[0-9]{2}\s+[0-9]+:[0-9]+(?s).*[a-zA-Z]+\s+\([0-9]+\s+[a-zA-Z]+\)
// [0-9]{6,8}$

class OCRPage extends StatefulWidget {
  OCRPage({Key? key, required this.title}) : super(key: key);

  final String title;
  final RegExp listRegex = RegExp(
      r'[0-9]{4}-[0-9]{2}-[0-9]{2}\s+[0-9]+:[0-9]+.*[a-zA-Z]+\s+\([0-9]+\s+[a-zA-Z]+\)');
  final RegExp numberRegex = RegExp(r"[0-9]{6,8}");

  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  bool _scanning = false;
  String _extractText = '';
  late XFile? _pickedImage = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tesseract OCR'),
      ),
      body: ListView(
        children: [
          _pickedImage == null
              ? Container(
                  height: 300,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image,
                    size: 100,
                  ),
                )
              : Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      image: DecorationImage(
                        image: FileImage(File(_pickedImage!.path)),
                        fit: BoxFit.fill,
                      )),
                ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ElevatedButton(
              child: const Text(
                'Select image of receipt',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                setState(() {
                  _scanning = true;
                });
                final ImagePicker _picker = ImagePicker();
                _pickedImage =
                    await _picker.pickImage(source: ImageSource.gallery);
                _extractText = await FlutterTesseractOcr.extractText(
                    _pickedImage!.path,
                    language: 'nor');
                setState(() {
                  var matches = widget.listRegex
                      .allMatches(_extractText.replaceAll("\n", " "));
                  var numberMatches = widget.numberRegex
                      .allMatches(matches.first.group(0).toString())
                      .map((match) => int.parse(match.group(0).toString()))
                      .toList();
                  _scanning = false;
                  Navigator.of(context).pushNamed(ExtractProductList.routeName,
                      arguments: ProductArguments(productList: numberMatches));
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          _scanning
              ? const Center(child: CircularProgressIndicator())
              : const Icon(
                  Icons.done,
                  size: 40,
                  color: Colors.green,
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
