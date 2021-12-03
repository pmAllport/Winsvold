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
import 'package:winsvold/views/OCRView/bulletpoint.dart';
import 'package:winsvold/views/routes.dart';

class OCRPage extends StatefulWidget {
  OCRPage({Key? key, required this.title}) : super(key: key);

  final String title;
  final RegExp listRegex = RegExp(
      r'[0-9]{4}-[0-9]{2}-[0-9]{2}\s+[0-9]+:[0-9]+.*[a-zA-Z]+\s+\([0-9]+\s+[a-zA-Z]+\)');
  final RegExp numberRegex = RegExp(r"[0-9]{5,8}");

  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  bool _scanning = false;
  late XFile? _pickedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tesseract OCR'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            !_scanning
                ? Column(
                    children: [
                      Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: ElevatedButton(
                          child: const Text(
                            'Velg bilde av kvitteringen.',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            // Navigator.of(context).pushNamed(
                            //     ExtractProductList.routeName,
                            //     arguments: ProductArguments(productList: [
                            //       2248502,
                            //       11164201,
                            //       1126801,
                            //       12934302
                            //     ]));

                            final ImagePicker _picker = ImagePicker();
                            _pickedImage = await _picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              _scanning = true;
                            });
                            String _extractText =
                                await FlutterTesseractOcr.extractText(
                                    _pickedImage!.path,
                                    language: 'nor');
                            setState(() {
                              var matches = widget.listRegex.allMatches(
                                  _extractText.replaceAll("\n", " "));

                              for (var match in matches) {
                                debugPrint(match.group(0).toString());
                              }
                              var numberMatches = widget.numberRegex
                                  .allMatches(matches.first.group(0).toString())
                                  .map((match) =>
                                      int.parse(match.group(0).toString()))
                                  .toList();
                              _scanning = false;
                              Navigator.of(context).pushNamed(
                                  ExtractProductList.routeName,
                                  arguments: ProductArguments(
                                      productList: numberMatches));
                            });
                          },
                        ),
                      ),
                      Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "Sliter programmet med å gjenkjenne teksten? \n Her er noen tips:",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                          const BulletPoint(
                              text: "Prøv å fjerne \"rynker\" i kvitteringen."),
                          const BulletPoint(
                              text: "Bruk et bilde med god oppløsning."),
                          const BulletPoint(
                              text: "Prøv å øke kontrasten på bildet."),
                          const BulletPoint(
                              text:
                                  "Prøv å beskjære slik at bare kvitteringen vises."),
                        ],
                      )
                    ],
                  )
                : Container(),
            const SizedBox(height: 20),
            _scanning
                ? Center(
                    child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(
                            "OCR-prosessen kan ta opp til 1 minutt.\n Vennligst vent.",
                            style: Theme.of(context).textTheme.subtitle1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ))
                : Container(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
