import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:winsvold/utils/navigator_arguments.dart';
import 'package:winsvold/views/OCRView/bulletpoint.dart';
import 'package:winsvold/views/routes.dart';

class OCRPage extends StatefulWidget {
  OCRPage({Key? key, required this.title}) : super(key: key);

  final String title;
  final listRegex = RegExp(
      r'[a-zA-Z]+ [0-9]+\s[0-9\-]+\s[0-9]{2}:[0-9]{2}\n([a-zA-Z0-9\n :.\/]*)\n[a-zA-Z0-9 ()]*(A|a)rtikler');
  final numberAmountRegex = RegExp(
      r'\n[a-zA-Z 0-9.]+\n([0-9]*)\n*(Antall: ([0-9]+) [a-zA-Z0-9. \/]*)?');

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
          actions: [
            IconButton(
                onPressed: (() => {
                      Navigator.of(context).pushNamed(
                        ExtractSettings.routeName,
                      )
                    }),
                icon: const Icon(Icons.settings)),
          ]),
      body: SizedBox(
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
                              var matches =
                                  widget.listRegex.allMatches(_extractText);

                              var numberMatches = widget.numberAmountRegex
                                  .allMatches(matches.first.group(0).toString())
                                  .map((match) => [
                                        int.parse(match.group(1).toString()),
                                        int.parse(
                                            (match.group(3) ?? 0).toString())
                                      ])
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
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: ElevatedButton(
                          child: const Text(
                            'Test API',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(context)
                                .pushNamed(ExtractProductList.routeName,
                                    arguments: ProductArguments(productList: [
                                      [2248502, 0],
                                      [11164201, 1],
                                      [1126801, 10],
                                      [12934302, 2],
                                      [9133502, 1],
                                    ]));
                          },
                        ),
                      ),
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
